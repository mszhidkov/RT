<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt" />
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251" />
  <!--Запоминаем ИНН, КПП, Дату документа-->
  <xsl:variable name="Kpp" select="Файл/Документ/СвНП/НПЮЛ/@КПП" />
  <xsl:variable name="Inn">
    <xsl:value-of select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ" />
    <xsl:value-of select="Файл/Документ/СвНП/НПФЛ/@ИННФЛ" />
  </xsl:variable>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок" />
  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!-- href="/kilor/xslt/style.css" -->
    <style>
      .table-compact td
      {
      padding: 0pt;
      }
    </style>

    <!-- Счетчик номеров страниц -->
    <script type="text/javascript">
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

    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates />
    </div>
  </xsl:template>


  <xsl:template match="Файл/Документ">
    <!--Налоговая декларация по земельному налогу (от 16.10.09)-->
    <!--КНД 1151001-->
    <!--NO_NDS-->
    <xsl:call-template name="titlePage" />
    <xsl:apply-templates select="ЗемНалНД" />
  </xsl:template>

  <xsl:template match="ЗемНалНД">
    <!--Раздел 1: Сумма налога,подлежащая уплате в бюджет (возмещению из бюджета),по данным налогоплательщика-->
    <xsl:call-template name="Page1" />
    <!--Раздел 2: -->
    <xsl:apply-templates select="СумПУ" />
    <!-- Количество страниц выведем -->
    <xsl:call-template name="CountPage" />
  </xsl:template>


  <!--Страницы-->
  <!--стр.1_Лист01-->
  <xsl:template name="titlePage">
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader" />
            <!--Заголовок-->
            <tr>
              <th class="nowrap">
                <h1>
                  Налоговая декларация по земельному налогу
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
                        <xsl:with-param name="input" select="@НомКорр" />
                        <xsl:with-param name="size" select="3" />
                      </xsl:call-template>
                    </td>
                    <!--Налоговый период (код)-->
                    <td class="text-center">
                      Налоговый период <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@Период" />
                        <xsl:with-param name="size" select="2" />
                      </xsl:call-template>
                    </td>
                    <!--Отчетный год-->
                    <td class="text-center">Отчетный год</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОтчетГод" />
                        <xsl:with-param name="size" select="4" />
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
                        <xsl:with-param name="input" select="@КодНО" />
                        <xsl:with-param name="size" select="4" />
                      </xsl:call-template>
                    </td>
                    <!--по месту нахождения (учета) (код)-->
                    <td class="text-center">
                      по месту нахождения (учета) <span style="font-size: 8pt">(код)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ПоМесту" />
                        <xsl:with-param name="size" select="3" />
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <!--Название организации-->
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input">
                    <xsl:value-of select="СвНП/НПЮЛ/@НаимОрг" />
                    <xsl:apply-templates select="СвНП/НПФЛ/ФИО" mode="one_line" />
                  </xsl:with-param>
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="4" />
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
                        <xsl:with-param name="input" select="СвНП/@ОКВЭД" />
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
                        <xsl:with-param name="input" select="СвНП/@Тлф" />
                        <xsl:with-param name="size" select="20" />
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
                <table>
                  <tr>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="Подписант" />
                    </td>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:call-template name="TaxWorker" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton" />
        </td>
      </tr>
    </table>
    <!-- Формируем id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <!--Заголовок для первой страницы-->
  <xsl:template name="titlePageHeader">
    <tr>
      <td>
        <table>
          <tr>
            <td>
              <xsl:call-template name="pageHeader">
                <xsl:with-param name="barCode">a0750`TPQSa</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="podpis text-right" width="280" style="padding-top: 4mm; padding-right: 4mm; padding-bottom: 0;">
              Приложение № 1 к Приказу ФНС России<br/>от 28.10.2011 № ММВ-7-11/696@
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right">
        <b>
          Форма по КНД <xsl:value-of select="@КНД" />
        </b>
      </td>
    </tr>
  </xsl:template>

  <!--Заголовок для каждой страницы-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <table>
      <tr>
        <!--Штрих-код-->
        <td style="width: 32mm">
          <table>
            <tr>
              <td style="vertical-align: top">
                <div style="background-color: black; height: 5.0mm; width: 5.0mm;"></div>
              </td>
              <td>
                <span class="barcode_EAN8">
                  <xsl:value-of select="$barCode" />
                </span>
              </td>
              <td style="vertical-align: top">
                <div style="background-color: black; height: 5.0mm; width: 5.0mm;"></div>
              </td>
            </tr>
          </table>
        </td>
        <!--ИНН,КПП,страница-->
        <td>
          <table style="margin-top: 2mm;">
            <tr>
              <td class="nowrap" style="width: 10mm;">ИНН</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$Inn" />
                  <xsl:with-param name="size" select="12" />
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <table style="margin-top: 2mm; width: auto;">
            <tr>
              <td class="nowrap" style="width: 10mm;">КПП</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$Kpp" />
                  <xsl:with-param name="size" select="9" />
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">Стр.</td>
              <!-- Номер страницы -->
              <xsl:call-template name="pageNum" />
            </tr>
          </table>
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
            <xsl:with-param name="input" select="substring( $input, 1, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
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
                подтверждающих документов<br/>и (или) их копий на
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
                Зарегистрирована за №
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
        <td class="podpis">(Фамилия, И.О.)</td>
        <td>&#160;</td>
        <td class="podpis">(Подпись)</td>
      </tr>
    </table>
  </xsl:template>



  <!--функции для разбивки строк-->
  <xsl:template name="breakDate">
    <xsl:param name="input"></xsl:param>
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 1, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 4 )" />
            <xsl:with-param name="size" select="4" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--СведенияПодтверждаю-->
  <xsl:template name="СведенияПодтверждаю">
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
                <xsl:value-of select="$docDate" />
              </td>
              <td class="explanation" style="width: 5%">&#160;(дата)</td>
              <td style="width: 25%">&#160;</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <xsl:call-template name="Feuilleton" />
  </xsl:template>

  <xsl:template match="Подписант">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center bold">
          Достоверность и полноту сведений, указанных<br />в настоящей декларации, подтверждаю:
        </td>
      </tr>
      <!--квадрат-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="50mm">&#160;</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@ПрПодп" />
                  <xsl:with-param name="size" select="1" />
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                1 - налогоплательщик,<br />2 - представитель налогоплательщика
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--ФИО-->
      <xsl:apply-templates select="ФИО" />
      <!--наименование организации - представителя налогоплательщика-->
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="СвПред/@НаимОрг" />
            <xsl:with-param name="size" select="20" />
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
                  <xsl:with-param name="input">
                    <xsl:value-of select="$docDate" />
                  </xsl:with-param>
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
          Наименование документа,<br />подтверждающего полномочия представителя
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="СвПред/@НаимДок" />
            <xsl:with-param name="size" select="20" />
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="line">2</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="ФИО">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Фамилия" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Имя" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Отчество" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="podpis">
        (фамилия, имя, отчество полностью)
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="ФИО" mode="one_line">
    <xsl:value-of select="@Фамилия" />
    <xsl:text></xsl:text>
    <xsl:value-of select="@Имя" />
    <xsl:text></xsl:text>
    <xsl:value-of select="@Отчество" />
  </xsl:template>

  <!--Подвал-->
  <xsl:template name="Feuilleton">
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
  </xsl:template>

  <!--********************* Раздел 1 (лист 2) *********************************-->
  <xsl:template name="Page1">
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0750`TPRPa</xsl:with-param>
                  <xsl:with-param name="pageNum">2</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <th class="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 1. Сумма земельного налога, подлежащая уплате в бюджет
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-center italic">
                Наименование соглашения о разделе продукции (для участников недр, предоставленных в пользование на условиях СРП)
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@НаимСРП" />
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="4" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                <br />
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <!--Применить шаблон для нескольких бюджетных классификаций-->
                  <xsl:apply-templates select="СумПУ" mode="page1" />
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="СведенияПодтверждаю" />
        </td>
      </tr>
    </table>
    <!-- Формируем id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <!--********************* Раздел 2 (лист 3) *********************************-->
  <xsl:template match="СумПУ">
    <xsl:variable name="KBK" select="@КБК" />
    <xsl:variable name="OKATO" select="@ОКТМО" />
    <xsl:for-each select="РасчПлатЗН">
      <xsl:call-template name="Page2">
        <xsl:with-param name="KBK" select="$KBK" />
        <xsl:with-param name="OKATO" select="$OKATO" />
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="Page2">
    <xsl:param name="KBK" />
    <xsl:param name="OKATO" />
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td colspan="3">
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0750`TPSWa</xsl:with-param>
                  <xsl:with-param name="pageNum">3</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td colspan="3" class="bold text-center" style="padding-top: 3mm;">
                Раздел 2. Расчет налоговой базы и суммы земельного налога
              </td>
            </tr>
            <tr>
              <td class="text-center italic" colspan="3" style="padding-top: 2mm;">
                Кадастровый номер земельного участка
              </td>
            </tr>
            <tr>
              <td colspan="3">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@НомКадастрЗУ" />
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td style="padding-top: 3mm" class="text-center italic" align="center">Показатели</td>
              <td style="padding-top: 3mm" class="text-center italic" align="center">
                Код<br />строки
              </td>
              <td style="padding-top: 3mm" class="text-center italic" align="center">Значения показателей</td>
            </tr>
            <tr>
              <td align="center">1</td>
              <td align="center">2</td>
              <td align="center">3</td>
            </tr>
            <tr>
              <td style="width:45%">Код бюджетной классификации</td>
              <td style="width:5%" class="text-center">010</td>
              <td style="width:50%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$KBK" />
                  <xsl:with-param name="size" select="20" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Код по ОКТМО</td>
              <td class="text-center">020</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$OKATO" />
                  <xsl:with-param name="size" select="11" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Категория земель (код)</td>
              <td class="text-center">030</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@КатегорЗем" />
                  <xsl:with-param name="size" select="12" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Период строительства</td>
              <td class="text-center">040</td>
              <td>
                <table>
                  <tr>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ПерСтр" />
                        <xsl:with-param name="size" select="1" />
                      </xsl:call-template>
                    </td>
                    <td>1 - 3 года, 2- свыше 3 лет.</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                Кадастровая стоимость (доля кадастровой стоимости)<br/>земельного участка / Нормативная цена земли (руб.)
              </td>
              <td class="text-center">050</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@СтКадастрЗУ" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Доля налогоплательщика в праве на земельный участок</td>
              <td class="text-center">060</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="@ДоляЗУ" />
                  <xsl:with-param name="size1" select="10"/>
                  <xsl:with-param name="size2" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td colspan="3">
                <b>I. Определение налоговой базы</b>
              </td>
            </tr>
            <tr>
              <td>
                Код налоговой льготы в виде необлагаемой налогом<br/>суммы
              </td>
              <td class="text-center">070</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот387_2Сум/@КодНалЛьгот" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Не облагаемая налогом сумма (руб.) <span style="font-size: 7pt">
                  (п. 2 ст. 387<br/>Налогового кодекса Российской Федерации (далее - Кодекс))
                </span>
              </td>
              <td class="text-center">080</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот387_2Сум/@СумНеОбл" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Код налоговой льготы в виде не облагаемой налогом суммы</td>
              <td class="text-center">090</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот391_5/@КодНалЛьгот" />
                  <xsl:with-param name="size" select="7" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Не облагаемая налогом сумма (руб.) <span style="font-size: 7pt">(п.5 ст.391 Кодекса)</span>
              </td>
              <td class="text-center">100</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот391_5/@СумНеОбл" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Код налоговой льготы в виде доли не облагаемой площади земельного участка</td>
              <td class="text-center">110</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот387_2Пл/@КодНалЛьгот" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Доля не облагаемой площади земельного участка<br/><span style="font-size: 7pt">(п.2 ст.387 Кодекса)</span>
              </td>
              <td class="text-center">120</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="ОпрНалБаза/Льгот387_2Пл/@ДоляПлЗУ" />
                  <xsl:with-param name="size1" select="10"/>
                  <xsl:with-param name="size2" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Налоговая база (руб.)</td>
              <td class="text-center">130</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="ОпрНалБаза/@НалБаза" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold">II. Налоговая ставка (%)</td>
              <td class="text-center">140</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="@НалСтав" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold">III. Исчисление суммы земельного налога</td>
            </tr>
            <tr>
              <td>
                Количество полных месяцев владения земельным<br/>участком в течение налогового периода
              </td>
              <td class="text-center">150</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/@КолМесВлЗУ" />
                  <xsl:with-param name="size" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Коэффициент Кв</td>
              <td class="text-center">160</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="СумНалИсчисл/@Кв" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Сумма исчисленного налога</td>
              <td class="text-center">170</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/@СумНалИсчисл" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Количество полных месяцев использования льготы</td>
              <td class="text-center">180</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/@КолМесЛьгот" />
                  <xsl:with-param name="size" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Коэффициент Кл</td>
              <td class="text-center">190</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="СумНалИсчисл/@Кл" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Код налоговой льготы в виде освобождения от<br/>налогообложения
              </td>
              <td class="text-center">200</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2Осв/@КодНалЛьгот" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td style="width:42%">
                Сумма налоговой льготы (руб.) <span style="font-size: 7pt">(п. 2 ст. 387 Кодекса)</span>
              </td>
              <td class="text-center">210</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2Осв/@СумЛьг" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Код налоговой льготы в виде освобождения от<br/>налогообложения
              </td>
              <td class="text-center">220</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот395/@КодНалЛьгот" />
                  <xsl:with-param name="size" select="7" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Сумма налоговой льготы (руб.) <span style="font-size: 7pt">(ст. 395, ст.7 Кодекса)</span>
              </td>
              <td class="text-center">230</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот395/@СумЛьг" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>Код налоговой льготы в виде уменьшения суммы налога</td>
              <td class="text-center">240</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2УмСум/@КодНалЛьгот" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Сумма налоговой льготы (руб.) <span style="font-size: 7pt">(п. 2 ст. 387 Кодекса)</span>
              </td>
              <td class="text-center">250</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2УмСум/@СумЛьг" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Код налоговой льготы в виде снижения налоговой<br/>ставки
              </td>
              <td class="text-center">260</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2СнСтав/@КодНалЛьгот" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Сумма налоговой льготы (руб.) <span style="font-size: 7pt">(п. 2 ст. 387 Кодекса)</span>
              </td>
              <td class="text-center">270</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/Льгот387_2СнСтав/@СумЛьг" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                Исчисленная сумма налога, подлежащая уплате<br/>в бюджет за налоговый период (руб.)
              </td>
              <td class="text-center">280</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СумНалИсчисл/@СумНалУплат" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <!-- Формируем id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="СумПУ" mode="page1">
    <tr>
      <td style="width:45%">Код бюджетной классификации</td>
      <td style="width:5%" class="text-center">010</td>
      <td style="width:50%">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@КБК" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>Код по ОКТМО</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@ОКТМО" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">0</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Исчисленная сумма налога, подлежащая уплате в<br/>бюджет за налоговый период (руб.)
      </td>
      <td class="text-center">021</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@НалИсчисл" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">
        в т.ч. сумма авансовых платежей, подлежащая<br/>уплате в бюджет за:
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">первый квартал (руб.)</td>
      <td class="text-center">023</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@АвПУКв1" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">второй квартал (руб.)</td>
      <td class="text-center">025</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@АвПУКв2" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">третий квартал (руб.)</td>
      <td class="text-center">027</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@АвПУКв3" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <xsl:apply-templates select="@НалПУ">
      <xsl:with-param name="strNum1">030</xsl:with-param>
      <xsl:with-param name="strNum2">040</xsl:with-param>
    </xsl:apply-templates>
    <tr>
      <td>
        <br />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="@НалПУ">
    <xsl:param name="strNum1" />
    <xsl:param name="strNum2" />
    <tr>
      <td>Сумма налога, подлежащая уплате в бюджет (руб.)</td>
      <td class="text-center">
        <xsl:value-of select="$strNum1"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test=".>0">
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input" select="."/>
              <xsl:with-param name="size" select="15"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input"/>
              <xsl:with-param name="size" select="15"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <tr>
      <td>Сумма налога, исчисленная к уменьшению (руб.)</td>
      <td class="text-center">
        <xsl:value-of select="$strNum2"/>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="substring-after(.,'-')"/>
          <xsl:with-param name="size" select="15"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>




  <!-- Формируем для страницы id = "printFormPageN" -->
  <xsl:template name="printFormPage">
    <xsl:param name="id"></xsl:param>
    <script type="text/javascript">
      // присваиваем очередное значение
      var element = document.getElementById('<xsl:value-of select="$id" />');
      if (element)
      element.setAttribute('id', 'printFormPage' + PageNumScript);
    </script>
  </xsl:template>

  <!-- Формируем номера страниц -->
  <xsl:template name="pageNum">
    <!-- добавляем к id строчку 'pageNum' т.к. в рамках одной страницы  generate-id() 
    выдает одно и то же значение при нумерации элементов DIV и элементов TD -->
    <xsl:variable name="id" select="concat(generate-id(),'pageNum')" />
    <td id="{$id}" class="text-left"></td>
    <script type="text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id" />', PageNumScript, 3, 1, '0');
    </script>
  </xsl:template>

  <!-- Формируем кол-во страниц -->
  <xsl:template name="CountPage">
    <script type="text/javascript">
      breakStr('CountPage', PageNumScript, 3, 0, '-');
    </script>
  </xsl:template>

  <xsl:template name="breakFraction">
    <xsl:param name="input" />
    <xsl:param name="size1"/>
    <xsl:param name="size2"/>
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:value-of select="substring-before( $input, '/' )" />
            </xsl:with-param>
            <xsl:with-param name="size" select="$size1" />
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
        <td>/</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '/' )" />
            <xsl:with-param name="size" select="$size2" />
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakFraction1">
    <xsl:param name="input1" />
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring($input1, 1, 1)" />
            <xsl:with-param name="size" select="1" />
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
        <td style="vertical-align: middle">.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input1, '.' )" />
            <xsl:with-param name="size" select="4" />
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>