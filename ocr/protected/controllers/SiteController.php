<?php

class SiteController extends Controller
{

	/**
	 * This is the default 'index' action that is invoked
	 * when an action is not explicitly requested by users.
	 */
	public function actionIndex()
	{
        error_reporting(3);
        $client = new GearmanClient();

        print gearman_version() . "\n";
		// renders the view file 'protected/views/site/index.php'
		// using the default layout 'protected/views/layouts/main.php'

		$this->render('index');
	}

	/**
	 * This is the action to handle external exceptions.
	 */
	public function actionError()
	{

		if($error=Yii::app()->errorHandler->error)
		{
			if(Yii::app()->request->isAjaxRequest)
				echo $error['message'];
			else
				$this->render('error', $error);
		}
	}

    public function actionRecognize()
    {
        $client=new SoapClient("http://{$_SERVER['HTTP_HOST']}/ocr/index.php?r=soap/service/soap",
            array(
                'cache_wsdl' => WSDL_CACHE_NONE,
                'trace'=>1,
                'soap_version' => SOAP_1_2
            ));
        echo $client->CheckPerson();
    }
}