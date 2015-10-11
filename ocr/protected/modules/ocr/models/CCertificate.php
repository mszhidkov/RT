<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 17.03.15
 * Time: 23:44
 */

namespace models;


class CCertificate extends CDocument implements IDocument{

    public $fio;

    public function __construct($file, $fio)
    {
        $this->source_file = $file;
        $this->fio = $fio;

        $this->fields = array('fio' => $this->fio);
    }

    public function Recognize()
    {

    }

    public function IsBlank()
    {

    }

} 