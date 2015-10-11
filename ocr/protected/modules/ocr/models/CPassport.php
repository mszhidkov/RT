<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 17.03.15
 * Time: 23:11
 */

namespace models;


class CPassport extends CDocument implements IDocument {

    public $first_name;
    public $second_name;
    public $third_name;
    public $birthday;

//    protected $f_folder;
//    protected $folder;
//    protected $name;

    public function __construct($file, $f_folder, $folder, $name, $first_name, $second_name, $third_name, $birthday)
    {
        $this->source_file = $file;
        $this->f_folder = $f_folder;
        $this->folder = $folder;
        $this->name = $name;

        $this->first_name = $first_name;
        $this->second_name = $second_name;
        $this->third_name = $third_name;
        $this->birthday = $birthday;
        $this->fields = array(
            'first_name' => $this->first_name,
            'second_name' => $this->second_name,
            'third_name' => $this->third_name,
            'birthday' => $this->birthday);
    }

    public function Recognize()
    {
    //    COCREngine::Rotate($this);
    //    COCREngine::Recognize($this);
        return true;
    }

    public function IsBlank()
    {
        file_put_contents('/tmp/gearman_test.log', "File {$this->source_file} uploaded\nWhite-balancing:\n", FILE_APPEND | LOCK_EX);
        $cmd = "cp /var/www/html/php.sh {$this->f_folder}/php.sh && sh {$this->f_folder}/php.sh {$this->source_file} {$this->f_folder}/wb_{$this->name}";
        echo "cmd is <code>'{$cmd}'</code><br>";
        file_put_contents('/tmp/gearman_test.log', "cmd is '{$cmd}'\n", FILE_APPEND | LOCK_EX);
        $res1 = shell_exec($cmd);
        file_put_contents('/tmp/gearman_test.log', "{$res1}'\n", FILE_APPEND | LOCK_EX);


        /**
         * @var $res - процент черного
         */
        $res = 10;
        return ($res < 5)?true:false;
    }
} 