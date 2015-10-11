<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Rus-Telecom OCR engine</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
        <script src="bootstrap/js/jquery-2.1.3.min.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>


	</head>
	<body>
		<div class='container' style='margin-top: 60px;'>
			<h1>Rus-Telecom OCR engine</h1>
			<form method="POST" action="upload.php" enctype="multipart/form-data">
				<input type="file" name="photo"><br><br>
				<input class='span2' type="text" name="p_series" placeholder="Серия (через пробел)"><input class='span2' type="text" name="p_number" placeholder="Номер"><br>
				<input class='span4' type="text" name="p_code" placeholder="Код подразделения (через пробел)"><br>
				<input class='span4' type="text" name="p_issuedate" placeholder="Дата выдачи (через пробел)"><br>
				<input class='span4' type="text" name="p_bday" placeholder="Дата рождения (через пробел)"><br>
				<hr>
				<button type="sumbit" class='btn btn-success btn-large'>Отправить</button>
			</form>
		</div>
	</body>
</html>