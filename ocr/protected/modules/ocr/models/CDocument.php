<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 17.03.15
 * Time: 23:02
 *
 * @property mixed $fields
 * @property string $source_file
 */

namespace models;


abstract class CDocument {

    public $fields = array();
    protected $source_file;
    protected $f_folder;
    protected $folder;
    protected $name;
}