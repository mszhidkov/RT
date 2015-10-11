<div class='container' style='margin-top: 60px;'>
    <h1>Rus-Telecom OCR engine</h1>
    <?=CHtml::beginForm("index.php?r=TaskDistribution/AddTask", "POST", array("enctype" => "multipart/form-data")) ?>
    <div>Passport</div>
    <div><?= CHtml::fileField('passport','',array()) ?></div>
    <div><?= CHtml::textField('p_first_name','Сорока')?></div>
    <div><?= CHtml::textField('p_second_name','Екатерина')?></div>
    <div><?= CHtml::textField('p_third_name','Владимировна')?></div>
    <div><?= CHtml::textField('p_birthday','31 05 1985')?></div>

    <div>SNILS</div>
    <div><?= CHtml::fileField('snils','',array()) ?></div>
    <div><?= CHtml::textField('s_number','135-461-84764')?></div>
    <div><?= CHtml::textField('s_first_name','Сорока')?></div>
    <div><?= CHtml::textField('s_second_name','Екатерина')?></div>
    <div><?= CHtml::textField('s_third_name','Владимировна')?></div>
    <div><?= CHtml::textField('s_birthday','31 05 1985')?></div>
    <div><?= CHtml::textField('s_sex','женский')?></div>


    <div><?= CHtml::submitButton('Test',array('name' => 'check'))?></div>


<!--        <input type="file" name="photo"><br><br>-->
<!--        <input class='span2' type="text" name="p_series" placeholder="Серия (через пробел)"><input class='span2' type="text" name="p_number" placeholder="Номер"><br>-->
<!--        <input class='span4' type="text" name="p_code" placeholder="Код подразделения (через пробел)"><br>-->
<!--        <input class='span4' type="text" name="p_issuedate" placeholder="Дата выдачи (через пробел)"><br>-->
<!--        <input class='span4' type="text" name="p_bday" placeholder="Дата рождения (через пробел)"><br>-->
<!--        <hr>-->
<!--        <button type="sumbit" class='btn btn-success btn-large'>Отправить</button>-->
    <?= CHtml::endForm(); ?>
</div>
