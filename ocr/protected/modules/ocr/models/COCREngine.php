<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 18.03.15
 * Time: 0:00
 */

namespace models;


class COCREngine {

    /**
     * @param CDocument $doc
     */
    public static function CompareWithSource($doc)
    {

    }

    /**
     * @param CDocument $doc
     */
    public static function Rotate($doc)
    {

    }

    /**
     * @param CDocument $doc
     */
    public static function WhiteBoard($doc)
    {

    }

    /**
     * @param CDocument $doc
     */
    public static function Recognize($doc)
    {

    }

    /**
     * @param array $data
     * 1) Получаем данные необходимые для проверки
     * 2) Создаем объекты документов
     * 3) Проверяем каждый документ на "белый лист" -> в случае если хотябы один "белый лист" сразу возвращаем ошибку
     * 4) Пытаемся распознать документы по очереди. В случае если не удалось распознать -> выдаем ошибку и не распознаем другие
     */
    public static function CheckPerson($data)
    {
        if($data)
        {
            $passport = new CPassport(
                $data['passport'],
                $data['f_folder'],
                $data['folder'],
                $data['p_name'],
                $data['p_first_name'],
                $data['p_second_name'],
                $data['p_third_name'],
                $data['p_birthday']);
            $snils = new CSNILS(
                $data['snils'],
                $data['f_folder'],
                $data['folder'],
                $data['s_name'],
                $data['s_number'],
                $data['s_first_name'],
                $data['s_second_name'],
                $data['s_third_name'],
                $data['s_birthday'],
                $data['s_sex']);


            if(!$passport->IsBlank() && !$snils->IsBlank())
            {
                if($passport_check = $passport->Recognize())
                {
                    if($snils_check = $snils->Recognize())
                    {
                        //todo handle SUCCESS RESULT
                    //    file_put_contents('/tmp/gearman_test.log', "1111111111\n", FILE_APPEND | LOCK_EX);
                    //    file_put_contents('/tmp/gearman_test.log', "\n".$passport->first_name." ".$snils->number."\n", FILE_APPEND | LOCK_EX);
                    }
                    else
                    {
                        //todo handle ERROR
                    }
                }
                else
                {
                    //todo handle ERROR
                }
            }
            else
            {
                //todo handle BLANK ERROR
            }


    //        foreach($data as $filed)
    //        {
    //            file_put_contents('/tmp/gearman_test.log', microtime() . "  " . $filed."\n", FILE_APPEND | LOCK_EX);
    //        }
        }
    }
}