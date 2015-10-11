<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="breakStr.xslt"/>
	<xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!-- /kilor/xslt/ -->

  <xsl:variable name="INN" select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
  <xsl:variable name="KPP" select="Файл/Документ/СвНП/НПЮЛ/@КПП"/>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок"/>

  <xsl:template match="/">
    <link rel="stylesheet" type="text/css" href=" /kilor/xslt/style.css"/>
    <!--<link rel="stylesheet" type="text/css" href="http://temp.web-dev.tensor.ru/kilor/xslt/style.css"/>-->
    <!-- подключаем скрипт счетчика номеров страниц -->
    <!-- Счетчик номеров страниц -->
    <script type = "text/javascript">
      // счетчик страниц
      var PageNumScript = 0;
      // функция breakStr - вывод номеров страниц
      // id - уникальный идентификатор элемента (td)
      // input, size, alignRight, symbol по аналогии с breakStr в xslt
      function breakStr(id, input, size, alignRight, symbol)
      {
      var i = 0;
      var k = 0;
      // шапка
      var sHTML = '&lt;table class="field_filled"&gt;&lt;tr&gt;';
      // переводим в строку, если число
      var StrNum = input.toString();
      // цикл по size
      while (i &lt; size)
      {
      // очерередной символ по умолчанию прочерк
      var smb = symbol;
      if ( (StrNum.length >= size-i &amp;&amp; alignRight) || (StrNum.length > i &amp;&amp; !alignRight))
      {
      smb = StrNum.substring(k, k+1);
      k = k + 1;
      }

      // выводим очередную ячейку
      sHTML = sHTML + '&lt;td class="border-dotted"&gt;' + smb + '&lt;/td&gt;';

      i = i + 1;
      }
      // шапку закрываем
      var sHTML = sHTML + '&lt;/tr&gt;&lt;/table&gt;';
      //alert(sHTML);
      var element = document.getElementById(id);
      if (element)
      element.innerHTML = sHTML;
      }
    </script>


    <style>
      .view_container .table-with-border td
      {
      border: solid 1px black;
      font-size: 8pt;
      }
      .view_container .table-with-border2 td
      {
      text-align: center;
      border: solid 1px black;
      font-size: 9pt;
      }
      .view_container .big-h1
      {
      font-size: 11pt;
    </style>

    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="Документ">
    <!--Налоговая декларация по налогу на игорный бизнес-->
    <!--КНД 1152011-->
    <!--NO_IGBISND-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="ИгБизНД"/>

    <!-- Количество страниц выведем -->
    <xsl:call-template name="CountPage"/>

  </xsl:template>

  <xsl:template match="ИгБизНД">
    <!--Раздел 1: Сумма налога, подлежащая уплате в бюджет-->
    <xsl:apply-templates select="СумНалПУ" mode="section1"/>

    <!--Раздел 2: Сумма налога к уплате-->
    <xsl:apply-templates select="РасчНал" mode="section2"/>

    <!--Раздел 2.1: Расчет налога на игорный бизнес по игровым столам-->
    <xsl:apply-templates select="РасчНал/РасчНалСтВс/РасчНалСт" mode="section3"/>

    <!--Раздел 3: Расчет налога на игорный бизнес по игровым столам-->
    <xsl:apply-templates select="ИзмКолОбПер" mode="section4"/>

    <!--Раздел 3.1: Изменение количества игровых столов за налоговый период-->
    <xsl:apply-templates select="ИзмКолОбПер/ИзмКолСтВс/ИзмКолСт" mode="section5"/>
  </xsl:template>



  <xsl:template match="Section1">
    <!--Раздел 1: Сумма налога к уплате-->
    <xsl:apply-templates select="СумНалПУ"/>
  </xsl:template>


  <!--<xsl:template match="СумНалПУ">
    Раздел 1: Сумма налога к уплате
    <xsl:call-template name="Section1"/>
  </xsl:template>-->

  <!--Страницы-->

  <!--стр.1_Лист01-->
  <xsl:template name="titlePage">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader"/>

            <!--Заголовок-->
            <tr>
              <th>
                <h1 class="padding-top5mm">
                  Налоговая декларация по налогу на игорный бизнес
                </h1>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <!--Номер корректировки-->
                    <td class="text-left">Номер корректировки</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@НомКорр"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <!--Налоговый период (код)-->
                    <td class="text-center">
                      Налоговый период <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@Период"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <!--Отчетный год-->
                    <td class="text-center">Отчетный год</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОтчетГод"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <!--Налоговый орган (код)-->
                    <td>
                      Представляется в налоговый орган <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КодНО"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <!--по месту нахождения (учета) (код)-->
                    <td class="text-center">
                      по месту нахождения (учета) <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ПоМесту"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>

                </table>
              </td>
            </tr>

            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СвНП/НПЮЛ/@НаимОрг"/>
                  <xsl:with-param name="size" select="40"/>
                  <xsl:with-param name="line" select="4"/>
                </xsl:call-template>
              </td>
            </tr>

            <tr>
              <td class="podpis">(налогоплательщик)</td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <!--Код вида экономической деятельности по классификатору ОКВЭД-->
                    <td class="text-center">Код вида экономической деятельности по классификатору ОКВЭД</td>
                    <td class="text-left">
                      <xsl:call-template name="breakOKVED">
                        <xsl:with-param name="input" select="СвНП/@ОКВЭД"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>


            <tr>
              <td>
                <table>
                  <tr>
                    <td class="text-right">
                      Форма реорганизации<br/>(ликвидация) <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>&#160;</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@ФормРеорг"/>
                        <xsl:with-param name="size" select="1"/>
                      </xsl:call-template>
                    </td>
                    <td>&#160;&#160;&#160;&#160;&#160;</td>
                    <td class="text-right">
                      ИНН/КПП реорганизованной<br/>организации
                    </td>
                    <td>&#160;</td>
                    <td class="text-right">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@ИННЮЛ"/>
                        <xsl:with-param name="size" select="10"/>
                      </xsl:call-template>
                    </td>
                    <td>/</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@КПП"/>
                        <xsl:with-param name="size" select="9"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>


            <tr>
              <td>
                <table>
                  <tr>
                    <!--Номер контактного телефона-->
                    <td class="text-center">Номер контактного телефона</td>
                    <td class="text-left">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/@Тлф"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <!--число страниц-->
                    <td width="5%" class="text-">На</td>
                    <td width="8%" id="CountPage"></td>
                    <td width="10%" class="text-right">страницах</td>

                    <!--число приложений-->
                    <td width="57%" class="text-center">&#160;&#160;&#160;с приложением подтверждающих документов или их копий на</td>
                    <td width="10%" style="text-align: center;">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <td width="10%" class="text-left">листах</td>
                  </tr>

                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table style="height: 100%; margin-top: 5mm;">
                  <tr>
                    <td style="border: 1pt double black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="Подписант"/>
                    </td>
                    <td style="border: 1pt double black; width: 50%; vertical-align: top">
                      <xsl:call-template name="TaxWorker"/>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 1:-->
  <xsl:template match="СумНалПУ" mode="section1">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPRQa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 5mm;">
                  Раздел 1. Сумма налога, подлежащая уплате в бюджет
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section1Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="SectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 2:-->
  <xsl:template match="РасчНал" mode="section2">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPSXa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                Раздел 2. Расчет налога на игорный бизнес
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section2Table1"/>
              </td>
            </tr>
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                Сумма исчисленного налога на игорный бизнес
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section2Table2"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 2.1:-->
  <xsl:template match="РасчНалСт" mode="section3">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPTUa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                Раздел 2.1. Расчет налога на игорный бизнес по игровым столам *
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section3Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 3:-->
  <xsl:template match="ИзмКолОбПер" mode="section4">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPURa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                Раздел 3. Изменение количества объектов налогообложения налогом на игорный бизнес за налоговый период
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section4Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>
  
  <!--Раздел 3.1:-->
  <xsl:template match="ИзмКолСт" mode="section5">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPVYa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                Раздел 3.1. Изменение количества игровых столов за налоговый период **
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section5Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 1-->
  <xsl:template name="Section1Table">
    <table style="margin-top: 5mm;">
      <tr>
        <td class="text-center italic" style="width: 42%">Показатели</td>
        <td class="text-center italic" style="width: 8%">
          Код<br/>строки
        </td>
        <td class="text-center italic" style="width: 50%">Значения показателей</td>
      </tr>
      <tr>
        <td class="text-center">1</td>
        <td class="text-center">2</td>
        <td class="text-center">3</td>
      </tr>
      <tr>
        <td>
          Код бюджетной классификации
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КБК"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Код ОКАТО
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ОКАТО"/>
            <xsl:with-param name="size" select="11"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма налога, подлежащая уплате в бюджет (руб.)
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@НалПУ"/>
            <xsl:with-param name="size" select="15"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Табличная часть1 Раздела 2-->
  <xsl:template name="Section2Table1">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTable1Razd2"/>
      <tr>
        <td style="font-size: 8pt">
          Количество объектов, <br/> подлежащих налогообложению <br/> (единиц), всего
        </td>
        <td class="text-center">020</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалАвт/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦТот/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦБук/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрТот/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрБук/@КолОбВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="bold">
          в том числе:
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          по ставке налога, <br/> установленной в <br/> соответствии с пунктом 1 <br/> статьи 369 НК РФ
        </td>
        <td class="text-center">030</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалАвт/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦТот/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦБук/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрТот/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрБук/@КолОб_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          по 1/2 ставки налога, <br/> установленной в <br/> соответствии с пунктами 3 и 4 <br/> статьи 370 НК РФ
        </td>
        <td class="text-center">040</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалАвт/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦТот/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦБук/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрТот/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрБук/@КолОб_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          по ставке налога, <br/> установленной в <br/> соответствии с пунктом 1 <br/> статьи 369 НК РФ с учетом <br/> абзаца 2 пункта 1 статьи 370 <br/> НК РФ
        </td>
        <td class="text-center">050</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@КолОбУч_370.1.2"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          по 1/2 ставки налога, <br/> установленной в <br/> соответствии с пунктами 3 и 4 <br/> статьи 370 НК РФ с учетом <br/> абзаца 2 пункта 1 статьи 370 <br/> НК РФ
        </td>
        <td class="text-center">060</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@КолОбУч_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Табличная часть2 Раздела 2-->
  <xsl:template name="Section2Table2">
    <table style="margin-top: 5mm;">
      <tr>
        <td class="text-center italic" style="width: 40%">Объекты налогообложения</td>
        <td class="text-center italic" style="width: 10%">
          Код<br/>строки
        </td>
        <td class="text-center italic" style="width: 15%">
          Ставка налога<br/>(руб.)
        </td>
        <td class="text-center italic" style="width: 35%">
          Сумма исчисленного налога на игорный<br/>бизнес (руб.)
        </td>
      </tr>
      <tr>
        <td class="text-center">1</td>
        <td class="text-center">2</td>
        <td class="text-center">3</td>
        <td class="text-center">4</td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Игровые столы, всего
        </td>
        <td class="text-center padding-top5mm">070</td>
        <td>
        </td>
        <td class=" text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалСтВс/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Игровые автоматы
        </td>
        <td class="text-center padding-top5mm">080</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалАвт/@СтавНал"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалАвт/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Процессинговые центры тотализаторов
        </td>
        <td class="text-center padding-top5mm">090</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦТот/@СтавНал"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦТот/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Процессинговые центры букмекерских контор
        </td>
        <td class="text-center padding-top5mm">100</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦБук/@СтавНал"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПЦБук/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Пункты приема ставок тотализаторов
        </td>
        <td class="text-center padding-top5mm">110</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрТот/@СтавНал"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрТот/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Пункты приема ставок букмекерских контор
        </td>
        <td class="text-center padding-top5mm">120</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрБук/@СтавНал"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалПрБук/@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 2.1-->
  <xsl:template name="Section3Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTableHat"/>
      <tr>
        <td class="padding-top5mm">
          Количество имеющихся игровых полей на игровом столе
        </td>
        <td class="text-center padding-top5mm">010</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПолей"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Размер ставки налога на игорный бизнес в месяц, установленный законом <br/> субъекта Российской Федерации в соответствии с пунктом 1 статьи 369 <br/> НК РФ (руб.)
        </td>
        <td class="text-center padding-top5mm">020</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СтавНал_369.1"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Размер ставки налога на игорный бизнес в месяц, установленный в <br/> соответствии с пунктом 1 статьи 369 НК РФ с учетом абзаца 2 пункта 1 <br/> статьи 370 НК РФ <br/> (стр.020 гр.3 х стр. 010 гр.3)
        </td>
        <td class="text-center padding-top5mm">030</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СтавНалУч_370.1.2"/>
            <xsl:with-param name="size" select="7"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Количество игровых столов, имеющих количество полей, указанное в <br/> стр.010 гр.3, подлежащих налогообложению (единиц), всего
        </td>
        <td class="text-center padding-top5mm">040</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПолВсего"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm bold">в том числе:</td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          по ставке налога, установленной в соответствии с пунктом 1 статьи 369 <br/> НК РФ
        </td>
        <td class="text-center padding-top5mm">050</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПол_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          по 1/2 ставки налога, установленной в соответствии с пунктами 3 и 4 <br/> статьи 370 НК РФ
        </td>
        <td class="text-center padding-top5mm">060</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПол_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          по ставке налога, установленной в соответствии с пунктом 1 статьи 369 <br/> НК РФ с учетом абзаца 2 пункта 1 статьи 370 НК РФ
        </td>
        <td class="text-center padding-top5mm">070</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПолУч_370.1.2"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          по 1/2 ставки налога, установленной в соответствии с пунктами 3 и 4 <br/> статьи 370 НК РФ с учетом абзаца 2 пункта 1 статьи 370 НК РФ
        </td>
        <td class="text-center padding-top5mm">080</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПолУч_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма исчисленного налога на игорный бизнес (руб.)
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@НалИсчисл"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
    <div class="italic" style="margin-top: 250pt; font-size: 8pt">
      * При наличии игровых столов с различным количеством игровых полей раздел 2.1 заполняется столько раз, сколько имеется вариантов <br/> количества игровых полей на игровых столах. При этом данные по количеству игровых столов, имеющих одинаковое количество игровых <br/> полей, и сумме исчисленного налога на игорный бизнес по данным игровым столам показываются в разделе 2.1 на одной странице.
    </div>
  </xsl:template>

  <!--Табличная часть Раздела 3-->
  <xsl:template name="Section4Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTable1Razd2"/>
      <tr>
        <td style="font-size: 8pt">
          Количество объектов<br/>налогообложения,<br/>зарегистрированных в<br/>налоговом органе (единиц):
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          на начало налогового<br/>периода
        </td>
        <td class="text-center">010</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          установлено до 15 числа
        </td>
        <td class="text-center">020</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          выбыло после 15 числа
        </td>
        <td class="text-center">030</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          установлено после 15<br/>числа
        </td>
        <td class="text-center">040</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          выбыло до 15 числа
        </td>
        <td class="text-center">050</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          на конец налогового<br/>периода
        </td>
        <td class="text-center">060</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолСтВс/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолАвт/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦТот/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПЦБук/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрТот/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="ИзмКолПрБук/@КолОбКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>


  <!--Табличная часть Раздела 3.1-->
  <xsl:template name="Section5Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTableHat"/>
      <tr>
        <td class="padding-top5mm">
          Количество имеющихся игровых полей на игровом столе
        </td>
        <td class="text-center padding-top5mm">010</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолПолей"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          Количество игровых столов, зарегистрированных в налоговом органе <br/> (единиц):
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          на начало налогового периода
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтНачПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          установлено до 15 числа
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтУстДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          выбыло после 15 числа
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтВыбПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          установлено после 15 числа
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтУстПос15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          выбыло до 15 числа
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтВыбДо15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          на конец налогового периода
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КолСтКонПер"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
    <div class="italic" style="margin-top: 400pt; font-size: 8pt">
      ** При наличии игровых столов с различным количеством игровых полей раздел 3.1 заполняется столько раз, сколько имеется вариантов <br/> количества игровых полей на игровых столах. При этом данные по количеству игровых столов, имеющих одинаковое количество игровых <br/> полей, показываются в разделе 3.1 на одной странице.
    </div>
  </xsl:template>

  <!--Шапки для Таблицы 1 Раздела 2, 3-->
  <xsl:template name="StandartTable1Razd2">
    <tr style="font-size: 8pt">
      <td class="text-center italic" style="width: 23%">Показатели</td>
      <td class="text-center italic" style="width: 5%">
        Код<br/>строки
      </td>
      <td class="text-center italic" style="width: 12%">
        Игровые столы,<br/>всего
      </td>
      <td class="text-center italic" style="width: 12%">
        Игровые<br/>автоматы
      </td>
      <td class="text-center italic" style="width: 12%">
        Процессинговые<br/>центры<br/>тотализаторов
      </td>
      <td class="text-center italic" style="width: 12%">
        Процессинговые<br/>центры<br/>букмекерских<br/>контор
      </td>
      <td class="text-center italic" style="width: 12%">
        Пункты приема<br/>ставок<br/>тотализаторов
      </td>
      <td class="text-center italic" style="width: 12%">
        Пункты<br/>приема<br/>ставок<br/>букмекерских<br/>контор
      </td>
    </tr>
    <tr style="font-size: 8pt">
      <td class="text-center italic">1</td>
      <td class="text-center italic">2</td>
      <td class="text-center italic">3</td>
      <td class="text-center italic">4</td>
      <td class="text-center italic">5</td>
      <td class="text-center italic">6</td>
      <td class="text-center italic">7</td>
      <td class="text-center italic">8</td>
    </tr>
  </xsl:template>

    <!--Шапки таблиц для Разделов 2.1, 3.1-->
  <xsl:template name="StandartTableHat">
    <tr>
      <td class="text-center italic" style="width: 60%">Показатели</td>
      <td class="text-center italic" style="width: 10%">
        Код<br/>строки
      </td>
      <td class="text-left italic" style="width: 30%">Значения показателей</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td style="padding-left: 50pt">3</td>
    </tr>
  </xsl:template>

  <!--Подвал для Разделов-->
  <xsl:template name="SectionFeuilleton">
    <tr>
      <td class="footer">
        <table>
          <tr>
            <td class="text-center bold" style="font-size: 8pt">Достоверность и полноту сведений, указанных на данной странице, подтверждаю:</td>
          </tr>
          <tr>
            <td class="text_center">
              <table>
                <tr>
                  <td style="width: 25%">&#160;</td>
                  <td class="field_text" style="width: 15%">&#160;</td>
                  <td class="explanation" style="width: 5%">&#160;(подпись)</td>
                  <td style="width: 10%">&#160;</td>
                  <td class="border-bottom text-center" style="width: 15%">
                    <xsl:value-of select="$docDate"/>
                  </td>
                  <td class="explanation" style="width: 5%">&#160;(дата)</td>
                  <td style="width: 25%">&#160;</td>
                </tr>
              </table>
            </td>
          </tr>
          <xsl:call-template name="Feuilleton"/>
        </table>
      </td>
    </tr>
  </xsl:template>

  <!--Заголовок для каждой страницы-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageID"></xsl:param>
    <table>
      <tr>
        <!--Штрих-код-->
        <td style="width: 30mm">
          <table>
            <tr>
              <td style="vertical-align: top">
                <div style="background-color: black; height: 5.0mm; width: 5.0mm; float: bottom">&#160;</div>
              </td>
              <td>
                <span class="barcode_EAN8">
                  <xsl:value-of select="$barCode"/>
                </span>
              </td>
              <td style="vertical-align: top">
                <div style="background-color: black; height: 5.0mm; width: 5.0mm; float: bottom">&#160;</div>
              </td>
            </tr>
          </table>
        </td>

        <!--ИНН,КПП,страница-->
        <td>
          <xsl:call-template name="INN_KPP_Page">
            <xsl:with-param name="pageID" select="$pageID"/>
          </xsl:call-template>
        </td>

      </tr>
    </table>
  </xsl:template>

  <!--Заголовок для первой страницы-->
  <xsl:template name="titlePageHeader">
    <tr>
      <td>
        <table>
          <tr>
            <td>
              <xsl:call-template name="pageHeader">
                <xsl:with-param name="barCode">a0210`VPQTa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="podpis text-right" style="width: 50mm; padding-top: 4mm; padding-right: 0mm; padding-bottom: 0;">
              Приложение № 1 к Приказу ФНС России<br/>
              от 28.12.2011 N ММВ-7-3/985@
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right">
        <b>
          Форма по КНД <xsl:value-of select="@КНД"/>
        </b>
      </td>
    </tr>
  </xsl:template>

  <!--Подвал-->
  <xsl:template name="Feuilleton">
    <tr>
      <td class="footer" >
        <table>
          <tr>
            <td>
              <div style="background-color: black; height: 5.0mm; width: 5.0mm; float: left">&#160;</div>
            </td>
            <td>
              <div style="background-color: black; height: 5.0mm; width: 5.0mm; float: right">&#160;</div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="INN_KPP_Page">
    <xsl:param name="pageID"/>
    <table style="margin-top: 2mm; width: auto">
      <tr>
        <td class="nowrap" style="width: 10mm;">ИНН</td>
        <td>

          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$INN"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
    <table style="margin-top: 2mm; width: auto">
      <tr>
        <td class="nowrap" style="width: 10mm;">КПП</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$KPP"/>
            <xsl:with-param name="size" select="9"/>
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">Стр.</td>
        <xsl:call-template name="pageNum">
          <xsl:with-param name="pageID" select="$pageID"/>
        </xsl:call-template>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="Подписант">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center">
          <b>
            Достоверность и полноту сведений, указанных<br/>в настоящей декларации, подтверждаю:
          </b>
        </td>
      </tr>
      <!--квадрат-->
      <tr>
        <td class="text-center">
          <table>
            <tr>
              <td style="width: 15%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@ПрПодп"/>
                  <xsl:with-param name="size" select="1"/>
                </xsl:call-template>
              </td>
              <td class="text-left explanation">
                1 - налогоплательщик,<br/>2 - представитель налогоплательщика
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--ФИО-->
      <xsl:apply-templates select="ФИО"/>
      <tr>
        <td class="podpis">
          (фамилия, имя, отчество полностью)
        </td>
      </tr>

      <!--наименование организации - представителя налогоплательщика-->
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="СвПред/@НаимОрг"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="line">8</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="podpis">
          (наименование организации - представителя налогоплательщика)
        </td>
      </tr>
      <!--подпись, дата-->
      <tr>
        <td>
          <table style='margin-top: 7mm;'>
            <tr>
              <td style='width: 15%'>Подпись&#160;</td>
              <td class='field_text' style='width: 30%'>&#160;</td>
              <td style='width: 10%'>&#160;Дата</td>
              <td style='width: 40%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input" select="$docDate"/>
                  <xsl:with-param name="size" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-center">М.П.</td>
              <td></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>
      <!--наименование документа, подтверждающего полномочия руководителя-->
      <tr>
        <td class="text-center" style="padding-top: 3mm">
          Наименование документа,<br/>подтверждающего полномочия представителя
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="СвПред/@НаимДок"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="line">2</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="TaxWorker">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center">
          <b>Заполняется работником налогового органа</b>
        </td>
      </tr>
      <tr>
        <td class="text-center">Сведения о представлении декларации</td>
      </tr>
      <!--код-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="75%" class="text-center">
                Данная декларация представлена <span style="font-size: 8pt">(код)</span>
              </td>
              <td class="text-left">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="2"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--количество страниц-->
      <tr>
        <td>
          <table class="tble-with-border">
            <tr>
              <td width="15%"></td>
              <td width="15%" class="text-center">на</td>
              <td width="25%" class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td width="45%" class="text-left">страницах</td>
            </tr>
          </table>
        </td>
      </tr>
      <!--количество приложений-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="55%" class="text-right">
                с приложением<br/>
                подтверждающих документов<br/> или их копий на
              </td>
              <td width="7%"></td>
              <td class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                листах
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--дата-->
      <tr>
        <td>
          <table>
            <tr>
              <td style="padding-left: 5mm">
                Дата представления<br/>декларации
              </td>
              <td>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input"/>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--регистрационный номер-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-center"  style="padding-left: 2mm">
                Зарегистрирована <br/>за №
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="11"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <!--подпись-->
    <table style="margin-top: 5mm">
      <tr>
        <td width="45%" class="field_text"></td>
        <td width="10%">&#160;</td>
        <td width="45%" class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">Фамилия, И.О.</td>
        <td>&#160;</td>
        <td class="podpis">Подпись</td>
      </tr>
    </table>
  </xsl:template>

  <!--Общие теги-->
  <xsl:template match="ФИО">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Фамилия"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Имя"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Отчество"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="@ОКАТО">
    <xsl:param name="strNum"></xsl:param>
    <tr>
      <td>Код по ОКАТО</td>
      <td class="text-center">
        <xsl:value-of select="$strNum"/>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="."/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="@КБК">
    <xsl:param name="strNum"></xsl:param>
    <tr>
      <td>Код бюджетной классификации</td>
      <td class="text-center">
        <xsl:value-of select="$strNum"/>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="."/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--разбить строку-->
  <xsl:template name="breakDate">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 1, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 4 )"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakOKVED">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 1, 2 )"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 2 )"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Формируем номера страниц -->
  <xsl:template name="pageNum">
    <xsl:param name="pageID"/>
    <!-- добавляем к id строчку 'pageID' т.к. в рамках одной страницы (одного узла) generate-id() 
    выдает одно и то же значение разделяем сами их -->
    <xsl:variable name="id" select="concat(generate-id(),'pageID',$pageID)"/>
    <td id="{$id}" class="text-left"></td>
    <script type = "text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id"/>', PageNumScript, 3, 1, '0');
    </script>
  </xsl:template>

  <!-- Формируем кол-во страниц -->
  <xsl:template name="CountPage">
    <script type = "text/javascript">
      breakStr('CountPage', PageNumScript, 3, 0, '-');
    </script>
  </xsl:template>

</xsl:stylesheet>