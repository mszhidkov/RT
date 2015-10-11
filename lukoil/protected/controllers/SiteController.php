<?php
class SiteController extends Controller
{
	/**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
			// captcha action renders the CAPTCHA image displayed on the contact page
			'captcha'=>array(
				'class'=>'CCaptchaAction',
				'backColor'=>0xFFFFFF,
			),
			// page action renders "static" pages stored under 'protected/views/site/pages'
			// They can be accessed via: index.php?r=site/page&view=FileName
			'page'=>array(
				'class'=>'CViewAction',
			),
            'soap'=>array(
                'class'=>'CWebServiceAction',
            ),
		);
	}

    public function behaviors()
    {
        return array(
            'pdfable' => array(
                'class' => 'ext.pdfable.Pdfable',
                'pdfOptions' => array(
                    'bin' => Yii::app()->params['service']['wkhtmltopdf'],
                    'dpi'   => Yii::app()->params['service']['wkhtmltopdf_dpi'],
                ),
                'defaultPdfPageOptions' => array(
                    'page-size'         => Yii::app()->params['service']['wkhtmltopdf_page_size'],
                ),
            ),
        );
    }

	/**
	 * This is the default 'index' action that is invoked
	 * when an action is not explicitly requested by users.
	 */
	public function actionIndex()
	{
        echo "<pre>";
        echo "<h3>Service configuration</h3>";
        print_r(Yii::app()->params['service']);
        if(Yii::app()->params['service']['enable_logging'])
        {
            echo "<h3>Last 50 lines of log</h3>";
            $log_path = Yii::app()->params['service']['log'];
            $cmd = "tail -50 {$log_path}";
            echo shell_exec($cmd);
        }
		// renders the view file 'protected/views/site/index.php'
		// using the default layout 'protected/views/layouts/main.php'
		//$this->render('index');
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

	/**
	 * Displays the contact page
	 */
	public function actionContact()
	{
		$model=new ContactForm;
		if(isset($_POST['ContactForm']))
		{
			$model->attributes=$_POST['ContactForm'];
			if($model->validate())
			{
				$name='=?UTF-8?B?'.base64_encode($model->name).'?=';
				$subject='=?UTF-8?B?'.base64_encode($model->subject).'?=';
				$headers="From: $name <{$model->email}>\r\n".
					"Reply-To: {$model->email}\r\n".
					"MIME-Version: 1.0\r\n".
					"Content-Type: text/plain; charset=UTF-8";

				mail(Yii::app()->params['adminEmail'],$subject,$model->body,$headers);
				Yii::app()->user->setFlash('contact','Thank you for contacting us. We will respond to you as soon as possible.');
				$this->refresh();
			}
		}
		$this->render('contact',array('model'=>$model));
	}

	/**
	 * Displays the login page
	 */
	public function actionLogin()
	{
		$model=new LoginForm;

		// if it is ajax validation request
		if(isset($_POST['ajax']) && $_POST['ajax']==='login-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}

		// collect user input data
		if(isset($_POST['LoginForm']))
		{
			$model->attributes=$_POST['LoginForm'];
			// validate user input and redirect to the previous page if valid
			if($model->validate() && $model->login())
				$this->redirect(Yii::app()->user->returnUrl);
		}
		// display the login form
		$this->render('login',array('model'=>$model));
	}

	/**
	 * Logs out the current user and redirect to homepage.
	 */
	public function actionLogout()
	{
		Yii::app()->user->logout();
		$this->redirect(Yii::app()->homeUrl);
	}

    /**
     * @param string $fileData
     * @return string $base64Encoded dataString
     * @throws SoapFault
     * @soap
     */
    public function PrintReport($fileData)
    {
        $xmlDoc = new DOMDocument();
        $datetime = date("Y-m-d H:i:s");
        $enable_logging = Yii::app()->params['service']['enable_logging'];
        !$enable_logging?:$log = Yii::app()->params['service']['log'];

        $fileData = preg_replace("/<\?xml .*\?>/",'',$fileData);

        if(!($xmlDoc->loadXML($fileData)))
        {
            !$enable_logging?:file_put_contents($log, "{$datetime} - Not XML File\n{$fileData}\n", FILE_APPEND | LOCK_EX);
            throw new SoapFault("DATA fault","Not XML File");
        }
        else
        {
            if(!($schema = $xmlDoc->getElementsByTagName("Документ")))
            {
                !$enable_logging?:file_put_contents($log, "{$datetime} - Not valid XML file\n{$fileData}\n", FILE_APPEND | LOCK_EX);
                throw new SoapFault("DATA fault","Not valid XML file");
            }
            else
            {
                if(!($knd = $schema->item(0)->getAttribute('КНД')))
                {
                    !$enable_logging?:file_put_contents($log, "$datetime - Not valid XML file\n{$fileData}\n", FILE_APPEND | LOCK_EX);
                    throw new SoapFault("DATA fault","Not valid XML file");
                }
                else
                {
                    $xslDoc = new DOMDocument();
                    $path = Yii::app()->params['service']['xslt'].$knd.'.xsl';
                    if(!($xslDoc->load($path)))
                    {
                        !$enable_logging?:file_put_contents($log, "$datetime - Not valid KND\n{$fileData}\n", FILE_APPEND | LOCK_EX);
                        throw new SoapFault("DATA fault","Not valid KND");
                    }

                    $proc = new XSLTProcessor();
                    $proc->importStylesheet($xslDoc);

                    $result = $proc->transformToXML($xmlDoc);
                    //  $result = iconv('utf-8','cp1251',$result);

                    if(!$result)
                    {
                        !$enable_logging?:file_put_contents($log, "$datetime - Transformation failed\n{$fileData}\n", FILE_APPEND | LOCK_EX);
                        throw new SoapFault("DATA fault","Transformation failed");
                    }
                    else
                    {
                        $this->layout = '/layouts/print';

                        $pdf = $this->createPdf();
                        $pdf->renderPage("_print", array('content' => $result));

                        $uniq = uniqid();
                        $path = Yii::app()->basePath."/runtime/tmp_filename_{$uniq}";
                        $pdf->saveAs($path);
                        $r = file_get_contents($path);

                        !$enable_logging?:file_put_contents($log, "$datetime - temporary file: {$path}\n", FILE_APPEND | LOCK_EX);

                        return base64_encode($r);
                    }
                }
            }
        }
    }

    public function actionTestPrint()
    {
        error_reporting(3);
        $client=new SoapClient("http://{$_SERVER['HTTP_HOST']}/lukoil/index.php?r=site/soap",array('cache_wsdl' => WSDL_CACHE_NONE, "trace" => 1));
        $xmlData = '<?xml version="1.0" encoding="windows-1251"?>
<Файл ИдФайл="IP_PDNONDS_1LA_1LA_7705514400262445001_20150112_1B3BDB25-78A9-4F81-89A1-52D89F9414CB" ВерсФорм="5.03" ВерсПрог="2.2.3972.0">
   <Документ КНД="1166008">
      <ПодтвДок E-mail="1LA-abLukTest">
         <ЮЛ НаимОрг="&quot;ЛУКОЙЛ-ИНФОРМ&quot;" ИННЮЛ="7705514400" КПП="262445001" />
      </ПодтвДок>
      <СвИзвещП ДатаПол="12.01.2015" ВремяПол="22.51.19">
         <СведПолФайл ИмяПостФайла="PD_NONDS_7705514400262445001_7705514400262445001_1LA_20150112_c38bbc21c8b44eab91c8889f2159b978">
            <ЭЦППолФайл>MIAGCSqGSIb3DQEHAqCAMIACAQExDDAKBgYqhQMCAgkFADCABgkqhkiG9w0BBwEAAKCCAy4wggMqMIIC2aADAgECAgoZieLKAAAAAAXIMAgGBiqFAwICAzARMQ8wDQYDVQQDEwZTUFMgQ0EwHhcNMTQwODEyMTM0MjA4WhcNMTUwODEyMTM1MjA4WjAOMQwwCgYDVQQDEwNzb3MwYzAcBgYqhQMCAhMwEgYHKoUDAgIkAAYHKoUDAgIeAQNDAARAxttnhMEzLe5cqdRpkAryEfqkqtqXRCgi25+OQsr5wdw1kgLCuVeeI+dw89OkD4E8lkp4ugWCOGOUmHs/cRXqZKOCAhIwggIOMA4GA1UdDwEB/wQEAwIE8DATBgNVHSUEDDAKBggrBgEFBQcDAjAdBgNVHQ4EFgQUJLHhjBWYtOy2vNJE9mdMDVKw4PwwHwYDVR0jBBgwFoAUbJekHZC2hWaZ0mc7ZdL0jwmO/EUwgZQGA1UdHwSBjDCBiTCBhqCBg6CBgIY/aHR0cDovL2h5cGVyLnNtb2xlbnNrLmdhcmFudC1jb3JwLmxvY2FsL0NlcnRFbnJvbGwvU1BTJTIwQ0EuY3Jshj1maWxlOi8vaHlwZXIuc21vbGVuc2suZ2FyYW50LWNvcnAubG9jYWwvQ2VydEVucm9sbC9TUFMgQ0EuY3JsMIIBDgYIKwYBBQUHAQEEggEAMIH9MGwGCCsGAQUFBzAChmBodHRwOi8vaHlwZXIuc21vbGVuc2suZ2FyYW50LWNvcnAubG9jYWwvQ2VydEVucm9sbC9oeXBlci5zbW9sZW5zay5nYXJhbnQtY29ycC5sb2NhbF9TUFMlMjBDQS5jcnQwagYIKwYBBQUHMAKGXmZpbGU6Ly9oeXBlci5zbW9sZW5zay5nYXJhbnQtY29ycC5sb2NhbC9DZXJ0RW5yb2xsL2h5cGVyLnNtb2xlbnNrLmdhcmFudC1jb3JwLmxvY2FsX1NQUyBDQS5jcnQwIQYIKwYBBQUHMAGGFWh0dHA6Ly92bS1zZWRvdi9vY3NwLzAIBgYqhQMCAgMDQQBxESeyIz5lQlfn89K6VhfITjXOf4KMGNvBRny5VRaVK79wKaxyShShISAQIAof0BoNm6RbzCKFqJIScnWBxeYwMYIBVjCCAVICAQEwHzARMQ8wDQYDVQQDEwZTUFMgQ0ECChmJ4soAAAAABcgwCgYGKoUDAgIJBQCggdEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwMTEyMTk1MDM2WjAvBgkqhkiG9w0BCQQxIgQgPtTCcvlmOnHyRwSC25i6FDjwmn4WVkxBoS9NGhd5gz0wZgYLKoZIhvcNAQkQAi8xVzBVMFMwUTAIBgYqhQMCAgkEIIBO/3PvEQSqCkYEroFyqzFvYeT3J3WwBYt4oeQVgpbzMCMwFaQTMBExDzANBgNVBAMTBlNQUyBDQQIKGYniygAAAAAFyDAKBgYqhQMCAhMFAARA7x2EXH/lpJqT3oZPRkjAJyWnHnqpO/EhzLcqQ+gqmhMzkfzZelUvxwooH0va3azpsn0jwd7EiLVjCemyoYUYsAAAAAAAAA==</ЭЦППолФайл>

         </СведПолФайл>
      </СвИзвещП>
      <ОтпрДок E-mail="1LA">
         <СпецОперат НаимОрг="Спецоператор" ИденСОС="1LA" />
      </ОтпрДок>
      <ПолДок E-mail="1LA-abLukTest">
         <ЮЛ НаимОрг="&quot;ЛУКОЙЛ-ИНФОРМ&quot;" ИННЮЛ="7705514400" КПП="262445001" />
      </ПолДок>
   </Документ>
</Файл>';

       try
       {
            $client->PrintReport($xmlData);
       }
       catch (exception $e)
       {
           var_dump($e->getMessage());

           var_dump($client->__getLastRequest());
           var_dump($client->__getLastResponse());

       }
    }
}