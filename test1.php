<html>
<head></head>
<body>

 <?php 

require_once "phpwebdriver/WebDriver.php";

include('simple_html_dom.php');

$webdriver = new WebDriver("localhost", "4444");
//$webdriver->connect("internet explorer");    

$webdriver->connect("firefox");                
$webdriver->get("http://services.fms.gov.ru/info-service.htm?sid=2000");
$element = $webdriver->findElementBy(LocatorStrategy::xpath, "//object[@type='application/x-shockwave-flash']/param[@name='FlashVars']");
$links = $element->getValue();


$match_count = preg_match_all("/((tmp)[^(?)]*)/",$links,$links_arr);


$static_addr = 'http://services.fms.gov.ru/';

for ($i = 0; $i<$match_count;$i++)
{
	$links_arr[0][$i] = $static_addr . $links_arr[0][$i];
	$md5_arr[$i] = md5_file($links_arr[0][$i]);


	switch ($md5_arr[$i])
    {
    case "669cf3532495afd40304eab33106bc94":
    	$capcha .= "1";
    break;

    case "e9d71c9ff6d2f5de0ba6b50633947d16":
   		$capcha .= "2";
    break;

    case "c66bb3ca19adff2903fa8731291d6b6b":
   		$capcha .= "3";
    break;

    case "ea77c2f378cdc327f07b84c311b88782":
    case "c53155e3279afc0a70a7f9212b37fd7e":
    	$capcha .= "4";
    break;

    case "1e44921e41455c19ef3dbbe442798aba":
    	$capcha .= "5";
    break;

    case "d41d8cd98f00b204e9800998ecf8427e":
    case "c948e5bd536655405b3a5abd47f964c3":
    	$capcha .= "6";
    break;

    case "f50c5a35d604e18c2d47e34383b782b7":
    	$capcha .= "7";
    break;

    case "51282edec22d43b8e0681f2ddd7d8e78":
    	$capcha .= "8";
    break;
    }
}

echo $capcha;

$pass_ser = "4608";
$pass_num = "317091";
$pass_date = "13.08.2008";

$element = $webdriver->findElementBy(LocatorStrategy::id, "form_PASSPORT_SER");
if( isset( $element ) ) {
    $element->sendKeys( array( $pass_ser ) );
}

    $element = $webdriver->findElementBy(LocatorStrategy::id, "form_PASSPORT_NUM");
if( isset( $element ) ) {
    $element->sendKeys( array( $pass_num ) );
}

$element = $webdriver->findElementBy(LocatorStrategy::id, "form_PASSPORT_DATE");
if( isset( $element ) ) {
    $element->sendKeys( array( $pass_date ) );
}

$element = $webdriver->findElementBy(LocatorStrategy::id, "form_captcha-input");
if( isset( $element ) ) {
    $element->sendKeys( array( $capcha ) );    
}

$element = $webdriver->findElementBy(LocatorStrategy::id, "form_submit");
if( isset( $element ) ) {
            $element->submit();
            usleep( self::LOAD_DELAY );
}

/*
$html = $this->webdriver->getPageSource();
$body = preg_replace( '/(^(.*)<body[^>]*>)|(<\/body>(.*)$)/si', '', $html );
$match_count = preg_match_all("/((tmp)[^(?)]*)/",$body,$server_ansver);
*/
echo $capcha;

?>

 </body>
 </html>
