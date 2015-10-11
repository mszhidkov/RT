<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 31.03.15
 * Time: 22:34
 */

class ServiceController extends CController
{
    public function actions()
    {
        return array(
            'soap'=>array(
                'class'=>'CWebServiceAction',
            ),
        );
    }

    /**
     * @param $data
     * @return string
     * @soap
     */
    public function CheckPerson($data)
    {
        $result = $data." checked!!!";
        return $result;
    }

    public function actionTest()
    {
        echo "22";
    }
}