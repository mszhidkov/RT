<?php

require_once "phpwebdriver/WebDriver.php";

$webdriver = new WebDriver("localhost", "4444");   

function findOptionElementByText($text) 
{
        $option = $this->findElementBy(LocatorStrategy::xpath, 'option[normalize-space(text())="'.$text.'"]');
        return $option;
}

function getScreenshot() 
{
        $request = $this->requestURL . "/screenshot";
        $response = $this->execute_rest_request_GET($request);
        return $this->extractValueFromJsonResponse($response);
}

function InputData($last_name,$first_name,$region)
{
        global $webdriver;

        $element = $webdriver->findElementBy(LocatorStrategy::name, "is[region_id][0]");
        $opt = $element->findOptionElementByText($region);
        $opt->click();


        $element = $webdriver->findElementBy(LocatorStrategy::name, "is[last_name]");
        if( isset( $element ) ) {
            $element->sendKeys( array( $last_name ) );
        }

        $element = $webdriver->findElementBy(LocatorStrategy::name, "is[first_name]");
        if( isset( $element ) ) {
            $element->sendKeys( array( $first_name ) );
        }


        $element = $webdriver->findElementBy(LocatorStrategy::id, "sub_fiz");
        if( isset( $element ) ) {
                    $element->submit();
        }
}

function SaveCapture($cnt,$folder_name)
{
        global $webdriver;

        if (!is_dir($folder_name))
          mkdir($folder_name);

        $png_filename = "{$folder_name}/screen{$cnt}.png";
        $element_screenshot = "{$folder_name}/captcha_screen{$cnt}.png";

        $img = $webdriver->getScreenshot();
        $data = base64_decode($img);
        $success = file_put_contents($png_filename, $data);

        $element = $webdriver->findElementBy(LocatorStrategy::id, "capchaVisual");

        $element_size = $element->getSize();

        $element_width = $element_size->{'width'};
        $element_height = $element_size->{'height'};

              
        $element_src_x = $element->getLocation()->{'x'};
        $element_src_y = $element->getLocation()->{'y'};



        $src = imagecreatefrompng($png_filename);
        $dest = imagecreatetruecolor($element_width, $element_height);
        imagecopy($dest, $src, 0, 0, $element_src_x, $element_src_y, $element_width, $element_height);
        imagepng($dest, $element_screenshot);

        return $element_screenshot;
}

$last_name = "Гречкина";
$first_name = "Наталья";
$region = "Московская область";
$folder_name = "fssp_captcha";

$webdriver->connect("firefox");                
$webdriver->get("http://fssprus.ru/iss/ip/");
/*InputData($last_name,$first_name,$region);
$html = $webdriver->getPageSource();*/



echo "<!DOCTYPE html>
              <html>
              <head>
                <title></title>
              </head>
              <body>";

for ($count=0;$count<5;$count++)
{
        $webdriver->refresh();
        InputData($last_name,$first_name,$region);
        $html = $webdriver->getPageSource();

        $captcha_src = SaveCapture($count,$folder_name);

        $cmd = "tesseract {$captcha_src} {$folder_name}/script_res{$count} digits";
        exec($cmd);

        $result = file_get_contents("{$folder_name}/script_res{$count}.txt");
        $result = trim($result);
        $result = str_replace(" ","",$result);



              echo "<bold>Attempt #{$count}</bold><br>
              <img src='{$captcha_src}'>
              <br>cmd is <code>'{$cmd}'</code><br><br>
              <bold> RECOGNIZED TEXT = '{$result}'</bold><br>";
}

echo "</body></html>";
$webdriver->close();
?>