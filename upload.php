﻿<?php
	function RotateAndRecognize($f_folder, $name)
	{
		$angle = 90;
		for ($i=1; $i<=3; $i++)
		{
			$cmd = "convert -rotate +{$angle} {$f_folder}/{$name} {$f_folder}/{$angle}_{$name}";
			
			echo "cmd is <code>'{$cmd}'</code><br>";
			echo exec($cmd);
			
			Recognize($f_folder, "{$angle}_{$name}");
			
			$angle += 90;
		}
	}
	
	function Recognize($f_folder, $name)
	{
		static $count = 0;
		
		$count++;
			
		$cmd = "tesseract {$f_folder}/{$name} {$f_folder}/res{$count} digits";
		echo "<br>cmd is <code>'{$cmd}'</code><br>";
		echo exec($cmd);
		
		$count++;
		
		$cmd = "tesseract {$f_folder}/{$name} {$f_folder}/res{$count} -l rus";
		echo "<br>cmd is <code>'{$cmd}'</code><br>";
		echo exec($cmd);
		
		$cmd = "convert {$f_folder}/{$name} -crop 100%x15% -deskew 40% -trim +repage {$f_folder}/%d_{$name}";
		exec($cmd);
		
		for ($i=0; $i<=6; $i++)
		{
			$count++;
			
			$cmd = "tesseract {$f_folder}/{$i}_{$name} {$f_folder}/res{$count} digits";
			echo "<br>cmd is <code>'{$cmd}'</code><br>";
			echo exec($cmd);
			
			$count++;
			
			$cmd = "tesseract {$f_folder}/{$i}_{$name} {$f_folder}/res{$count} -l rus";
			echo "<br>cmd is <code>'{$cmd}'</code><br>";
			echo exec($cmd);
		}
	}
?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Rus-Telecom OCR engine</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="stylesheet" href="./bootstrap/css/bootstrap.css" />
		<script src="./bootstrap/js/jquery-2.1.3.min.js"></script>
		<script src="./bootstrap/js/bootstrap.js"></script>
	</head>
	<body>
		<div class='container' style='margin-top: 60px;'>
			<h1>Rus-Telecom OCR Engine</h1>
			<div class="tabbable">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab1" data-toggle="tab">Console</a></li>
					<li><a href="#tab2" data-toggle="tab">RAW data</a></li>
					<li><a href="#tab3" data-toggle="tab">Parsed data</a></li>
					<li><a href="#tab4" data-toggle="tab">Levenshtein distance</a></li>
					<li><a href="#tab5" data-toggle="tab">Images</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<div class='well'>
							<?php
                            error_reporting(3);
								$start_time = time();
								
								$day_date = date('d-m-Y', time());
								$folder = "/var/www/html/uploads/".$day_date;
								@mkdir($folder);
								$hms_date = date('H-i-s', time());
								$f_folder = $folder.'/'.$hms_date;
								@mkdir($f_folder);
								
								$tmp_name = $_FILES['photo']["tmp_name"];
								$name = $_FILES['photo']["name"];
								if (!move_uploaded_file($tmp_name, $f_folder."/{$name}"))
									die('fuck. upload failed;');
								
								$fname = $f_folder."/".$name;
								
								echo "File {$fname} uploaded<br>";
								echo "White-balancing:<br>";
								$cmd = "cp /var/www/html/php.sh {$f_folder}/php.sh && sh {$f_folder}/php.sh {$fname} {$f_folder}/wb_{$name}";
								echo "cmd is <code>'{$cmd}'</code><br>";
								echo shell_exec($cmd);
								
								$files = array();
								
								Recognize($f_folder, "wb_{$name}");
								
								echo "<br>Grayscale, auto-rotate, additional white'n'black threshold <strong>+morphology</strong> and crop:<br>";
								$cmd = "convert {$f_folder}/wb_{$name} -colorspace gray -deskew 40% -threshold 40%x80% -morphology close diamond -morphology thicken '1x3>:1,0,1' -trim +repage {$f_folder}/c_wb_{$name}";
								echo "cmd is <code>'{$cmd}'</code><br>";
								echo exec($cmd);
								
								Recognize($f_folder, "c_wb_{$name}");
								
								echo "<br>Crop image:<br>";
								$cmd = "convert {$f_folder}/c_wb_{$name} -crop 100%x50% -trim +repage {$f_folder}/%d_c_wb_{$name}";
								echo "cmd is <code>'{$cmd}'</code><br>";
								echo exec($cmd);
								
								$cmd = "tesseract {$f_folder}/0_c_wb_{$name} {$f_folder}/res digits";
								Recognize($f_folder, "0_c_wb_{$name}");
								Recognize($f_folder, "1_c_wb_{$name}");
								
								echo "<hr><hr>";
								
								RotateAndRecognize($f_folder, "0_c_wb_{$name}");
								RotateAndRecognize($f_folder, "1_c_wb_{$name}");
								
								echo "<strong>Execution time: ".(time()-$start_time)." sec.</strong>";
							?>
						</div>
					</div>
					<div class="tab-pane" id="tab2">
						<div class='well'>
							<?php
								$files = array();
								for ($i=1; $i<=300; $i++)
								{
									$f_naaame = "{$f_folder}/res{$i}.txt";
									$fp = fopen($f_naaame, 'r');
									if ($fp)
									{
										$files[] = explode("\n", fread($fp, filesize($f_naaame)));
										fclose($fp);
									}
								}
									
								foreach ($files as $num=>$res)
									echo "<h2>{$num}</h2>".implode("<br>", $res)."<hr>";
							?>
						</div>
					</div>
					<div class="tab-pane" id="tab3">
						<div class='well'>
							<?php
								$p_series = explode(' ', $_POST['p_series']);
								$p_code = explode(' ', $_POST['p_code']);
								$p_issuedate = explode(' ', $_POST['p_issuedate']);
								$p_bday = explode(' ', $_POST['p_bday']);
							
								$compare_list = array(
									'Серия паспорта (1)' => $p_series[0],
									'Серия паспорта (2)' => $p_series[1],
									'Номер паспорта' => $_POST['p_number'],
									'Код подразделения (1)' => $p_code[0],
									'Код подразделения (2)' => $p_code[1],
									'Дата выпуска (1)' => $p_issuedate[0],
									'Дата выпуска (2)' => $p_issuedate[1],
									'Дата выпуска (3)' => $p_issuedate[2],
									'Дата рождения (1)' => $p_bday[0],
									'Дата рождения (2)' => $p_bday[1],
									'Дата рождения (3)' => $p_bday[2],
								);
								
								for ($i=0; $i<count($files); $i++)
								{
									echo "<h4>File #{$i}</h4>";
									$res = $files[$i];
									foreach ($res as $str)
									{
										$str_array = explode(' ', trim($str));
										
										foreach ($str_array as $str_elem)
										{
											if ($str_elem == '')
												continue;
											
											foreach ($compare_list as $type=>$compare_elem)
											{
												if ($compare_elem === trim($str_elem))
													echo "Find {$type}: {$str_elem} (Full string is \"{$str}\")<br>";
											}
										}
									}
								}
							?>
						</div>
					</div>
					<div class="tab-pane" id="tab4">
						<div class='well'>
							<table class='table table-bordered table-hover'>
								<thead>
									<tr>
										<th>Тип данных</th>
										<th>Данные OCR</th>
										<th>Данные OCR (очищенные)</th>
										<th>Введенные данные</th>
										<th>Расстояние по Левенштейну</th>
									<tr>
								</thead>
								<tbody>
							<?php
								$compare_list = array(
									'Серия и номер паспорта' => $_POST['p_series']." ".$_POST['p_number'],
									'Только серия паспорта' => $_POST['p_series'],
									'Только номер паспорта' => $_POST['p_number'],
									'Код подразделения' => $_POST['p_code'],
									'Дата выпуска' => $_POST['p_issuedate'],
									'Дата рождения' => $_POST['p_bday'],
								);
								
								for ($i=0; $i<count($files); $i++)
								{
									$res = $files[$i];
									foreach ($res as $str)
									{
										$str = trim($str);
										if ($str == '')
											continue;
										
										foreach ($compare_list as $type=>$compare_elem)
										{
											$p_str = ereg_replace("/\D/", "", $str);//;str_replace(array(" ",",",".","'","\"",),"",$str);
											$compare_elem = str_replace(" ","",$compare_elem);
											$dist = levenshtein($p_str,$compare_elem);
											
											if ($dist < 3)
											{
												echo "
													<tr>
														<td>{$type}</td>
														<td>{$str}</td>
														<td>{$p_str}</td>
														<td>{$compare_elem}</td>
														<td>{$dist}</td>
													</tr>
												";
											}
										}
									}
								}
							?>
								</tbody>
							</table>
						</div>
					</div>
					<div class="tab-pane" id="tab5">
						<div class='well'>
							<?php
								$hf = "//192.168.1.8/uploads/{$day_date}/{$hms_date}";
								
								echo "
									<h4>Original:</h4>
									<a href='{$hf}/{$name}' target=_blank><img src='{$hf}/{$name}' style='max-height: 300px; width: auto;'></a>
									<h4>White-balanced:</h4>
									<a href='{$hf}/wb_{$name}' target=_blank><img src='{$hf}/wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<h4>Grayscale, auto-rotate, additional white'n'black threshold + morphology and crop:</h4>
									<a href='{$hf}/c_wb_{$name}' target=_blank><img src='{$hf}/c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<h4>Crop:</h4>
									<a href='{$hf}/0_c_wb_{$name}' target=_blank><img src='{$hf}/0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/1_c_wb_{$name}' target=_blank><img src='{$hf}/1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<h4>Rotate:</h4>
									<a href='{$hf}/90_0_c_wb_{$name}' target=_blank><img src='{$hf}/90_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/90_1_c_wb_{$name}' target=_blank><img src='{$hf}/90_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/180_0_c_wb_{$name}' target=_blank><img src='{$hf}/180_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/180_1_c_wb_{$name}' target=_blank><img src='{$hf}/180_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/270_0_c_wb_{$name}' target=_blank><img src='{$hf}/270_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
									<a href='{$hf}/270_1_c_wb_{$name}' target=_blank><img src='{$hf}/270_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a>
								";
								echo "<h4>Crop 15% (angle=0):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_0_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=90):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_90_0_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_90_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=180):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_180_0_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_180_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=270):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_270_0_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_270_0_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=0):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_1_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=90):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_90_1_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_90_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=180):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_180_1_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_180_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
								
								echo "<h4>Crop 15% (angle=270):</h4>";
								for ($i=0; $i<=6; $i++)
								{
									echo "<a href='{$hf}/{$i}_270_1_c_wb_{$name}' target=_blank><img src='{$hf}/{$i}_270_1_c_wb_{$name}' style='max-height: 300px; width: auto;'></a><br>";
								}
							?>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>