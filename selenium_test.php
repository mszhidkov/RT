<?php

/*require_once "phpwebdriver/WebDriver.php";

$webdriver = new WebDriver("localhost", "4444");  

$webdriver->connect("firefox");                
$webdriver->get("http://fssprus.ru/iss/ip/");

$html = $webdriver->getPageSource();

echo $html;
*/


require_once "phpwebdriver/WebDriver.php";


$webdriver = new WebDriver("localhost", "4444");
$webdriver->connect("firefox");                

$webdriver->get("http://78.47.109.221/12.mp3");

echo "Sucsess!!!\n";

$webdriver->close();


?>