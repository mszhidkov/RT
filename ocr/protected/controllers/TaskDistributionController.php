<?php

class TaskDistributionController extends Controller
{
    /**
     * 1) Получаем данные с формы/соапа
     * 2) Определяем тип запроса //todo
     * 3) Сохраняем данные в бд и на жесткий диск, генерируем ИД итд
     * 4) Формируем массив данных для передачи рабочему (данные полей + пути к файлам)
     */
	public function actionAddTask()
	{
		if(isset($_POST['check']))
        {

            $day_date = date('d-m-Y', time());
            $folder = "/tmp/uploads/".$day_date;
            @mkdir($folder,0777,true);
            $hms_date = date('H-i-s', time());
            $f_folder = $folder.'/'.$hms_date;
            @mkdir($f_folder,0777,true);

            $p_tmp_name = $_FILES['passport']["tmp_name"];
            $p_name = $_FILES['passport']["name"];
            if (!move_uploaded_file($p_tmp_name, $f_folder."/{$p_name}"))
                die('fuck. upload failed;');
            $p_fname = $f_folder."/".$p_name;

            $s_tmp_name = $_FILES['snils']["tmp_name"];
            $s_name = $_FILES['snils']["name"];
            if (!move_uploaded_file($s_tmp_name, $f_folder."/{$s_name}"))
                die('fuck. upload failed;');
            $s_fname = $f_folder."/".$s_name;

            $data = array(
                'passport' => $p_fname,
                'p_first_name' => $_POST['p_first_name'],
                'p_second_name' => $_POST['p_second_name'],
                'p_third_name' => $_POST['p_third_name'],
                'p_birthday' => $_POST['p_birthday'],

                'snils' => $s_fname,
                's_first_name' => $_POST['s_first_name'],
                's_second_name' => $_POST['s_second_name'],
                's_third_name' => $_POST['s_third_name'],
                's_birthday' => $_POST['s_birthday'],
                's_number' => $_POST['s_number'],
                's_sex' => $_POST['s_sex'],

                'f_folder' => $f_folder,
                'folder' =>$folder,
                'p_name' => $p_name,
                's_name' => $s_name,
            );

            $client = new GearmanClient();
            $client->addServer('127.0.0.1', '4730');

            $client->doBackground('AddRecognizeTask', json_encode($data));
        }
	}
}