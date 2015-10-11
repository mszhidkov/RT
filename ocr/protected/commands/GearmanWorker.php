<?php
/**
 * Created by PhpStorm.
 * User: max
 * Date: 11.04.15
 * Time: 15:52
 */

require_once(dirname(__FILE__).'/../modules/ocr/models/COCREngine.php');
require_once(dirname(__FILE__).'/../modules/ocr/models/CDocument.php');
require_once(dirname(__FILE__).'/../modules/ocr/models/IDocument.php');
require_once(dirname(__FILE__).'/../modules/ocr/models/CPassport.php');
require_once(dirname(__FILE__).'/../modules/ocr/models/CSNILS.php');

$worker = new GearmanWorker();
$worker->addServer();

$worker->addFunction('AddRecognizeTask', 'Recognize');

while (true) {
    $worker->work();
    if ($worker->returnCode() != GEARMAN_SUCCESS) break;
}

function Recognize($job)
{
    $workload = $job->workload();
    $data = json_decode($workload, true);

    \models\COCREngine::CheckPerson($data);
}