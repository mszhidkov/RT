<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 17.03.15
 * Time: 23:18
 */

namespace models;


class CSNILS extends CDocument implements IDocument {

    const FEMALE = 0;
    const MALE = 1;

    public $number;
    public $first_name;
    public $second_name;
    public $third_name;
    public $birthday;
    public $sex;

    public function __construct($file, $f_folder, $folder, $name, $number, $first_name, $second_name, $third_name, $birthday, $sex)
    {
        $this->source_file = $file;
        $this->f_folder = $f_folder;
        $this->folder = $folder;
        $this->name = $name;

        $this->number = $number;
        $this->first_name = $first_name;
        $this->second_name = $second_name;
        $this->third_name = $third_name;
        $this->birthday = $birthday;
        $this->sex = $sex;
        $this->fields = array(
            'number' => $this->number,
            'first_name' => $this->first_name,
            'second_name' => $this->second_name,
            'third_name' => $this->third_name,
         //   'birthday' => $this->$birthday,
            'sex' => $this->sex);
    }

    public function Recognize()
    {
        return true;
    }

    public function IsBlank()
    {

        echo "File {$this->source_file} uploaded<br>";
        echo "White-balancing:<br>";
        $cmd = "cp /var/www/html/php.sh {$this->f_folder}/php.sh && sh {$this->f_folder}/php.sh {$this->source_file} {$this->f_folder}/wb_{$this->name}";
        echo "cmd is <code>'{$cmd}'</code><br>";
        echo shell_exec($cmd);
        /**
         * @var $res - процент черного
         */
        $res = 10;
        return ($res < 5)?true:false;
    }

} 