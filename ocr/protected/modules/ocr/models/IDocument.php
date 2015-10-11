<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 17.03.15
 * Time: 22:54
 */

namespace models;


interface IDocument {

    public function Recognize();

    public function IsBlank();

}