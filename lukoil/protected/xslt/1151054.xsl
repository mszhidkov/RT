<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="no_format.xslt"/>
  <xsl:include href="counter.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--Запоминаем ИНН, КПП, Дату документа-->
  <xsl:variable name="Kpp" select="Файл/Документ/СвНП/НПЮЛ/@КПП"/>
  <xsl:variable name="Inn">
    <xsl:value-of select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
    <xsl:value-of select="Файл/Документ/СвНП/НПФЛ/@ИННФЛ"/>
  </xsl:variable>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок"/>
  
  <xsl:template match="/">
    <link rel="stylesheet" type="text/css" href="/kilor/xslt/style.css"/>

    <style>
      .view_container .table-compact td
      {
      padding: 0.5pt;
      }
    </style>
    
    <!--Печатаем скрипт в тело документа!-->
    <xsl:call-template name="InitCounterScript"/>
    
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>

  </xsl:template>

  <xsl:template match="Документ">
    <!--НД по налогу на добычу полезных ископаемых (от 16.12.11)-->
    <!--КНД 1151054-->
    <!--5.02-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="НДПИ"/>
    
    <!-- Количество страниц выведем -->
    <xsl:call-template name="CountPage"/>
    
  </xsl:template>

  <xsl:template match="НДПИ">
    <!--Раздел 1. Сумма налога, подлежащая уплате в бюджет, по данным налогоплательщика-->
    <xsl:apply-templates select="СумНалПУ"/>
    <!--Раздел 2. Данные, служащие основанием для исчисления и уплаты налога, за исключением угля-->
    <xsl:apply-templates select="ИсчУплНал"/>
    <!--Раздел 3. Определение стоимости единицы добытого полезного ископаемого исходя из расчетной стоимости-->
    <xsl:apply-templates select="СтоимЕдДПИ"/>
    <!--Раздел 4. Данные, служащие основанием для исчисления и уплаты налога, при добыче угля по участку недр-->
    <xsl:apply-templates select="ИсчУплНалУг"/>
  </xsl:template>

  <!--Страницы-->

  <!--стр.1_Лист01-->
  <xsl:template name="titlePage">

      <table class="page page-margin-narrow">
        <tr>
          <td class="page-content">
            <table>
              <xsl:call-template name="titlePageHeader"/>
              <!--Заголовок-->
              <tr>
                <th class ="nowrap">
                  <h1>
                    Налоговая декларация<br/>по налогу на добычу полезных ископаемых
                  </h1>
                </th>
              </tr>

              <tr>
                <td>
                  <table>
                    <tr>
                      <!--Номер корректировки-->
                      <td class="text-left nowrap" width="10%">Номер корректировки</td>
                      <td>
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="@НомКорр"/>
                          <xsl:with-param name="size" select="3"/>
                        </xsl:call-template>
                      </td>
                      <!--Налоговый период (код)-->
                      <td class="text-right">Налоговый период <span class="explanation">(код)</span></td>
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
                      <td class="text-center">Представляется в налоговый орган <span class="explanation">(код)</span></td>
                      <td>
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="@КодНО"/>
                          <xsl:with-param name="size" select="4"/>
                        </xsl:call-template>
                      </td>
                      <!--по месту нахождения (учета) (код)-->
                      <td class="text-center">по месту нахождения (учета) <span class="explanation">(код)</span></td>
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
                    <xsl:with-param name="input">
                      <xsl:value-of select="СвНП/НПЮЛ/@НаимОрг"/>
                      <xsl:apply-templates select="СвНП/НПФЛ/ФИО" mode="one_line"/>
                    </xsl:with-param>
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
                      <td class="text-right">Код вида экономической деятельности по классификатору ОКВЭД</td>
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
                      <!--Форма реорганизации(ликвидации) (код)-->
                      <td class="text-right">
                        Форма реорганизации<br/>(ликвидации) <span class="explanation">(код)</span>
                      </td>
                      <td width="5%">
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@ФормРеорг"/>
                          <xsl:with-param name="size" select="1"/>
                        </xsl:call-template>
                      </td>
                      <td class="text-right">ИНН/КПП реорганизованной<br/>организации</td>
                      <td>
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@ИННЮЛ"/>
                          <xsl:with-param name="size" select="10"/>
                        </xsl:call-template>
                      </td>
                      <td width="1%">/</td>
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
                      <td class="text-right">На</td>
                      <td class="text-center">
                        <table>
                          <tr>
                            <td id="CountPage">
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td  class="text-left">страницах</td>

                      <!--число приложений-->
                      <td class="text-right">с приложением подтверждающих документов или их копий на</td>
                      <td>
                        <xsl:call-template name="noFotmat"/>
                      </td>
                      <td class="text-center">
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input"/>
                          <xsl:with-param name="size" select="3"/>
                        </xsl:call-template>
                      </td>
                      <td class="text-left">листах</td>
                    </tr>

                  </table>
                </td>
              </tr>

              <tr>
                <td>
                  <table>
                    <tr>
                      <td width="50%" class="border-right border-top vertical-align-top">
                        <xsl:apply-templates select="Подписант"/>
                      </td>
                      <td width="50%" class="border-top vertical-align-top">
                        <xsl:call-template name="TaxWorker"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

            </table>
          </td>
        </tr>
        <tr>
          <td class="footer" >
            <xsl:call-template name="Feuilleton"/>
          </td>
        </tr>
    </table>
    
  </xsl:template>

  <!--Части страниц-->
  <!--Заголовок для каждой страницы-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageID"></xsl:param>
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
                  <xsl:value-of select="$barCode"/>
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
                  <xsl:with-param name="input" select="$Inn"/>
                  <xsl:with-param name="size" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <table style="margin-top: 2mm; width: auto;">
            <tr>
              <td class="nowrap" style="width: 10mm;">КПП</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$Kpp"/>
                  <xsl:with-param name="size" select="9"/>
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">Стр.</td>

              <!-- Номер страницы -->
              <xsl:call-template name="pageNum">
                <xsl:with-param name="pageID" select="$pageID"/>
                <xsl:with-param name="alignRight">true</xsl:with-param>
                <xsl:with-param name="symbol">0</xsl:with-param>
              </xsl:call-template>
            </tr>
          </table>
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
                <xsl:with-param name="barCode">a0100`VPQXa</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="text-right vertical-align-top padding-top5mm" width="40%" style="font-size: 6pt;">
              Приложение № 1 к Приказу ФНС РФ от 16.12.2011 № ММВ-7-3/928@
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
                <td class="field_text" style="width: 15%">
                  <xsl:value-of select="$docDate"/>
                </td>
                <td class="explanation" style="width: 5%">&#160;(дата)</td>
                <td style="width: 25%">&#160;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <xsl:call-template name="Feuilleton"/>

  </xsl:template>

  <xsl:template match="Подписант">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center bold">
          Достоверность и полноту сведений, указанных<br/>в настоящей декларации, подтверждаю:
        </td>
      </tr>
      <!--квадрат-->
      <tr>
        <td >
          <table>
            <tr>
              <td width="50mm">&#160;</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@ПрПодп"/>
                  <xsl:with-param name="size" select="1"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                1 - налогоплательщик,<br/>2 - представитель налогоплательщика
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--ФИО-->
      <xsl:apply-templates select="ФИО"/>


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
          <table style='margin-top: 10mm;'>
            <tr>
              <td style='width: 15%'>Подпись&#160;</td>
              <td class='field_text' style='width: 30%'>&#160;</td>
              <td style='width: 10%'>&#160;Дата</td>
              <td style='width: 40%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:value-of select="$docDate"/>
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
        <td class="text-center">
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

  <xsl:template match="ФИО">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Фамилия"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Имя"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Отчество"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
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
    <xsl:value-of select="@Фамилия"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Имя"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Отчество"/>
  </xsl:template>

  <xsl:template name="TaxWorker">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center">
          <b>Заполняется работником налогового органа</b><br/><br/>Сведения о представлении декларации
        </td>
      </tr>
      <!--код-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-center">
                Данная декларация представлена (код)
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
          <table>
            <tr>
              <td class="text-center">
                на
              </td>
              <td class="text-center" width="20%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                страницах
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--количество приложений-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                с приложением<br/>подтверждающих документов<br/>или их копий на
              </td>
              <td width="5%"></td>
              <td width="20%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
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
              <td class="text-left">
                Дата представления<br/>декларации
              </td>
              <td>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input"></xsl:with-param>
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
              <td class="text-center">
                Зарегистрирована<br/>за №
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
                  <xsl:with-param name="size" select="13"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <!--подпись-->
    <table class="margin-top5mm">
      <tr>
        <td class="field_text"></td>
        <td>&#160;</td>
        <td class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">(Фамилия, И.О.)</td>
        <td>&#160;</td>
        <td class="podpis">(Подпись)</td>
      </tr>
    </table>
  </xsl:template>


  <!--********************* Раздел 1 (лист 2 ) *********************************-->

  <xsl:template match="СумНалПУ">
    <xsl:call-template name="pageRecursiveR1">
      <xsl:with-param name="CountPage" select="ceiling(count(СумПУ) div 8)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--выводим по 8 блоков на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*8 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  
  <xsl:template name="pageR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPRUa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 class="margin-top5mm">
                  Раздел 1. Сумма налога, подлежащая уплате в бюджет
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="42%">Показатели</td>
                    <td width="5%">Код<br/>строки</td>
                    <td width="53%">Значения показателей</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>

                  <!-- Выводим блоки-->
                  <xsl:call-template name="OutStrRecursiveR1">
                    <xsl:with-param name="node" select="$node/СумПУ"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>

                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>
    
    
  </xsl:template>

  <xsl:template name="OutStrRecursiveR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 8) * 8"/>

    <tr>
      <td>Код бюджетной классификации</td>
      <td class="text-center">010</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@КБК"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>Код по ОКАТО</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@ОКАТО"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>Сумма налога, подлежащая уплате в бюджет (руб.)</td>
      <td class="text-center">030</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@НалПУ"/>
          <xsl:with-param name="size" select="15"/>
          <xsl:with-param name="nullIsPrinted"></xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>&#160;</td>
    </tr>
    
    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--********************* Раздел 2 (лист 3 ) *********************************-->
  <xsl:template match="ИсчУплНал">
    <xsl:call-template name="pageRecursiveR2">
      <xsl:with-param name="CountPage" select="ceiling(count(ДанДПИ/ДанДПИУч) div 3)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR2">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--выводим по 3 блока на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR2">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*3 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR2">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR2">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPSRa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 class="margin-top5mm">
                  Раздел 2. Данные, служащие основанием для исчисления и уплаты налога, за исключением угля
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="42%">Показатели</td>
                    <td width="5%">Код<br/>строки</td>
                    <td width="53%">Значение показателей</td>
                  </tr>
                  <tr>
                    <td>Код вида добытого полезного ископаемого</td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КодДПИ"/>
                        <xsl:with-param name="size" select="5"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Код бюджетной классификации</td>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КБК"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Код единицы измерения количества добытого полезного ископаемого по ОКЕИ</td>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОКЕИ"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="30%">
                      Код по ОКАТО /<br/>Серия, номер и вид лицензии на<br/>пользование недрами
                    </td>
                    <td width="15%">
                      Код основания<br/>налогообложения
                    </td>
                    <td width="40%">
                      Количество добытого полезного ископаемого,<br/>подлежащего налогообложению
                    </td>
                    <td width="15%">
                      Значение<br/>коэффициента Кв<br/><span class="podpis">
                        (указывается при<br/>добыче нефти)
                      </span>
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1/2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <!--Выводим блоки-->
                  <xsl:call-template name="OutStrRecursiveR2">
                    <xsl:with-param name="node" select="$node/ДанДПИ/ДанДПИУч"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="48%">Показатели</td>
                    <td width="7%">Код<br/>строки</td>
                    <td width="45%">Значение показателей</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <tr>
                    <td>Стоимость единицы добытого полезного ископаемого</td>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@СтоимЕдДПИ"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Доля содержания химически чистого драгоценного металла в добытом полезном ископаемом</td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@ДоляДрМетДПИ"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="1"/>
                        <xsl:with-param name="decsize" select="10"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Количество реализованного добытого полезного ископаемого</td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@КолРеалДПИ"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="decsize" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Выручка от реализации добытого полезного ископаемого</td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@ВырРеалДПИ"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Налоговая база</td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@НалБаза"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Сумма налогового вычета</td>
                    <td class="text-center">085</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@НалВыч"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Сумма исчисленного налога</td>
                    <td class="text-center">090</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@НалИсчисл"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
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
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>


  </xsl:template>

  <xsl:template name="OutStrRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 3) * 3"/>

    <tr>
      <td class="vertical-align-top">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@ОКАТО"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
        <table style="width: auto; margin-top: 2pt;">
          <tr>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@СерЛицНедр"/>
                <xsl:with-param name="size" select="3"/>
              </xsl:call-template>
            </td>
            <td width="3%"></td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@НомЛицНедр"/>
                <xsl:with-param name="size" select="5"/>
              </xsl:call-template>
            </td>
            <td width="3%"></td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@ВидЛицНедр"/>
                <xsl:with-param name="size" select="2"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </td>
      <td colspan="2">
        <xsl:call-template name="outColR2">
          <xsl:with-param name="node" select="$node[$position]"/>
        </xsl:call-template>
      </td>
      <!--
      <td class="vertical-align-top">
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@КоэфКв"/>
          <xsl:with-param name="size" select="1"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
      -->
      <td>
        <xsl:call-template name="outColKoefR2">
          <xsl:with-param name="node" select="$node[$position]"/>
        </xsl:call-template>
      </td>
    </tr>
    
    <tr>
      <td colspan="5"></td>
    </tr>

    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="outColR2">
    <xsl:param name="node"/>
    <!-- выводим рекрсивно либо 5 строк либо количество-->
    <table>
      <xsl:call-template name="outColRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="count">
          <xsl:choose>
            <xsl:when test="count($node/КолДПИОсн) > 5">
              <xsl:value-of select="count($node/КолДПИОсн)"/>
            </xsl:when>
            <xsl:otherwise>
              5
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template> 
    </table>
  </xsl:template>

  <xsl:template name="outColRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="pos">1</xsl:param>
    <xsl:param name="count"/>

    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node/КолДПИОсн[$pos]/@КодОснов"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node/КолДПИОсн[$pos]/@КолДПИ"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > $pos">
      <xsl:call-template name="outColRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="pos" select="$pos + 1"/>
        <xsl:with-param name="count" select="$count"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--Коэффициенты-->
  <xsl:template name="outColKoefR2">
    <xsl:param name="node"/>
    <!-- выводим рекрсивно либо 5 строк либо количество-->
    <table>
      <xsl:call-template name="outColKoefRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="count">
          <xsl:choose>
            <xsl:when test="count($node/Коэф) > 5">
              <xsl:value-of select="count($node/Коэф)"/>
            </xsl:when>
            <xsl:otherwise>
              5
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </table>
  </xsl:template>

  <xsl:template name="outColKoefRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="pos">1</xsl:param>
    <xsl:param name="count"/>

    <tr>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node/Коэф[$pos]"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > $pos">
      <xsl:call-template name="outColKoefRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="pos" select="$pos + 1"/>
        <xsl:with-param name="count" select="$count"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  

  <!--********************* Раздел 3 (лист 4 ) *********************************-->

  <xsl:template match="СтоимЕдДПИ">
    <xsl:call-template name="pageRecursiveR3">
      <xsl:with-param name="CountPage" select="ceiling(count(СумРасхДПИОтд/СумРасхДПИВид) div 7)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR3">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--выводим по 7 блоков на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR3">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*7 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR3">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPTYa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--раздел 3 и 3.1-->
            <tr>
              <td>
                <xsl:if test="$position = 1">
                  <xsl:call-template name="outTable3.1">
                    <xsl:with-param name="node" select="$node"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            
            <!--раздел 3.2-->
            <tr>
              <td class="bold text-center padding-top5mm">
                <!--отступ для всез страниц кроме первой-->
                <xsl:if test="$position != 1">
                  <div style="margin-top: 50mm"></div>
                </xsl:if>
                3.2. Определение суммы расходов по отдельным добытым полезным ископаемым
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="50%">Код единицы измерения количества по ОКЕИ<span class="podpis">(строка 110)</span></td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="$node/СумРасхДПИОтд/@ОКЕИ"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
           
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center italic explanation" >
                    <td width="14%">
                      Код добытого<br/>полезного<br/>ископаемого
                    </td>
                    <td width="38%">
                      Количество добытого<br/>полезного ископаемого
                    </td>
                    <td width="17%">
                      Доля добытого<br/>полезного ископаемого<br/>в общем количестве<br/>добытых полезных<br/>ископаемых
                    </td>
                    <td width="31%">
                      Сумма расходов по добыче полезного<br/>ископаемого (руб.)
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR3">
                    <xsl:with-param name="node" select="$node/СумРасхДПИОтд/СумРасхДПИВид"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable3.1">
    <xsl:param name="node"/>
    <table>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          Раздел 3. Определение стоимости единицы добытого полезного ископаемого исходя из расчетной стоимости
        </td>
      </tr>
      <tr>
        <td class="text-right italic explanation" colspan="3">
          Раздел 3 заполняется и включается в состав налоговой декларации<br/>
          только в случае оценки стоимости какого-либо добытого полезного<br/>
          ископаемого исходя из расчетной стоимости
        </td>
      </tr>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          3.1. Определение общей суммы расходов по добыче полезных ископаемых
        </td>
      </tr>
      <tr class="text-center italic" >
        <td width="50%">Показатели</td>
        <td width="10%">Код<br/>строки</td>
        <td width="40%">Значение показателей</td>
      </tr>
      <tr>
        <td>
          Прямые расходы по добыче полезных ископаемых,<br/>произведенные в налоговом периоде
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ПрРасхДобПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Остаток незавершенного производства на начало<br/>налогового периода
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ОстНПНачПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Остаток незавершенного производства на конец<br/>отчетного периода
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ОстНПКонПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">Сумма прямых расходов, относящихся к добытым в<br/>налоговом периоде полезным ископаемым</div>
          <div class="podpis text-left">(стр.010 + стр.020 - стр.030)</div>
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ПрРасхДПИПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Внереализационные расходы, относящиеся к добытым<br/>полезным ископаемым (в соответствии с подпунктами 6, 7<br/>пункта 4 статьи 340 НК)
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ВнереалРасхДПИ"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Косвенные расходы, относящиеся к добытым полезным<br/>ископаемым
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@КосвРасхДПИ"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Косвенные расходы, связанные с добычей полезных<br/>ископаемых и другими видами деятельности
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@КосвРасхДр"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Общая сумма прямых расходов, произведенных в течение<br/>налогового периода по всем видам деятельности
        </td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@ПрРасхПерОбщ"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">
            Сумма косвенных и иных расходов, относящаяся к<br/>добытым в налоговом периоде полезным ископаемым
          </div>
          <div class="podpis text-left">(стр.050 + стр.060 + стр.070 х стр.010 : стр. 080)</div>
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@КосвИнРасхПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">
            Общая сумма расходов по добыче полезных<br/>ископаемых, произведенных в налоговом периоде
          </div>
          <div class="podpis text-left">(стр.040 + стр.090)</div>
        </td>
        <td class="text-center">100</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/СумРасхДПИОбщ/@РасхОбщДобПер"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>

    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveR3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 7) * 7"/>

    <tr align="center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@КодДПИ"/>
          <xsl:with-param name="size" select="5"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@КоличДПИ"/>
          <xsl:with-param name="size" select="11"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@ДоляДПИОбщКол"/>
          <xsl:with-param name="size" select="1"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@СумРасхДобПИ"/>
          <xsl:with-param name="size" select="13"/>
          <xsl:with-param name="decsize" select="2"/>
          <xsl:with-param name="nullIsPrinted"></xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>

    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR3">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--********************* Раздел 4 (лист 5,6,7 ) *********************************-->
  <xsl:template match="ИсчУплНалУг">
    <!--вызываем раздел 4.1 рекурсивно с блоками по 10 на листе-->
    <xsl:call-template name="pageRecursiveR4.1">
      <xsl:with-param name="CountPage" select="ceiling(count(ДанДПИУг/ДанДПИУгУч) div 10)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
    
    <!--4.2-->
    <xsl:apply-templates select="РасчНалУпл"/>

    <!--4.3-->
    <xsl:apply-templates select="РасчНалВыч"/>
  </xsl:template>

  <!--4.1-->
  
  <xsl:template name="pageRecursiveR4.1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--выводим по 10 блоков на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR4.1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*10 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR4.1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR4.1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPUVa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--раздел 4 -->
            <tr>
              <td>
                <xsl:if test="$position = 1">
                  <xsl:call-template name="outTable4">
                    <xsl:with-param name="node" select="$node"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td class="bold text-center padding-top5mm">
                4.1. Данные о количестве добытого полезного ископаемого по участку недр
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="33%" rowspan="2">
                      Код по ОКАТО /<br/>Код вида добытого полезного ископаемого
                    </td>
                    <td colspan="2">
                      Количество добытого полезного ископаемого, подлежащего налогообложению:<br/>
                      по налоговой ставке 0% (рублей) /<br/>
                      по общеустановленной ставке
                    </td>
                  </tr>
                  <tr class="text-center italic">
                    <td>
                      код основания налогообложения
                    </td>
                    <td>
                      количество
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1/2</td>
                    <td width="27%">3/4</td>
                    <td width="40%">5/6</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR4.1">
                    <xsl:with-param name="node" select="$node/ДанДПИУг/ДанДПИУгУч"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <table>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          Раздел 4. Данные, служащие основанием для исчисления и уплаты налога, при добыче угля по участку недр
        </td>
      </tr>
      <tr class="text-center italic" >
        <td width="47%">Показатели</td>
        <td width="3%">
          Код<br/>строки
        </td>
        <td width="50%">Значение показателей</td>
      </tr>
      <tr>
        <td>
          Код бюджетной классификации
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$node/@КБК"/>
            <xsl:with-param name="size" select="20"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Серия, номер и вид лицензии на пользование недрами
        </td>
        <td class="text-center">020</td>
        <td>
          <table style="width: auto; margin-top: 2pt;">
            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@СерЛицНедр"/>
                  <xsl:with-param name="size" select="3"/>
                </xsl:call-template>
              </td>
              <td width="3%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@НомЛицНедр"/>
                  <xsl:with-param name="size" select="5"/>
                </xsl:call-template>
              </td>
              <td width="3%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@ВидЛицНедр"/>
                  <xsl:with-param name="size" select="2"/>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          Код единицы измерения количества добытого полезного<br/>ископаемого по ОКЕИ
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$node/@ОКЕИ"/>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template name="OutStrRecursiveR4.1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 10) * 10"/>

    <tr align="center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@ОКАТО"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@КодДПИ"/>
          <xsl:with-param name="size" select="5"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/КолДПИ_0/@КодОснов"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/КолДПИОбщ/@КодОснов"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/КолДПИ_0/@КолДПИ"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/КолДПИОбщ/@КолДПИ"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
    </tr>

    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR4.1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--4.2-->
  <xsl:template match="РасчНалУпл">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPVSa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="text-center bold padding-top5mm">
                4.2. Расчет суммы налога, подлежащей уплате в бюджет, по участку недр
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="50%">Показатели</td>
                    <td width="10%">
                      Код<br/>строки
                    </td>
                    <td width="40%">Значение показателей</td>
                  </tr>
                  <tr>
                    <td>
                      Остаток неучтенных при определении налогового вычета<br/>расходов на начало налогового периода
                    </td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОстНачПер"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма расходов, осуществленных (понесенных)<br/>
                      налогоплательщиком в налоговом периоде и связанных с<br/>
                      обеспечением безопасных условий и охраны труда при<br/>
                      добыче угля в текущем налоговом периоде всего<br/>
                      <span class="explanation">(стр.030+стр.040+стр.050)</span>
                    </td>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="РасхОТПер/@РасхОТПерВс"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      в том числе:<br/><br/>материальные расходы
                    </td>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="РасхОТПер/@МатРасх"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      расходы налогоплательщика на приобретение и (или)<br/>создание амортизируемого имущества
                    </td>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="РасхОТПер/@РасхАмИмущ"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      расходы, осуществленные (понесенные)<br/>
                      налогоплательщиком в случаях достройки,<br/>
                      дооборудования, реконструкции, модернизации,<br/>
                      технического перевооружения объектов основных<br/>средств
                    </td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="РасхОТПер/@РасхРекон"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма расходов, осуществленных (понесенных)<br/>
                      налогоплательщиком и связанных с обеспечением<br/>
                      безопасных условий и охраны труда при добыче угля,<br/>
                      включаемых в налоговый вычет и уменьшающих сумму<br/>
                      налога за налоговый период, не превышающая<br/>
                      предельной величины налогового вычета<br/>
                      <span class="explanation">(стр.010 + стр.020 &lt;= стр.090)</span>
                    </td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@РасхОТВыч"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Значение коэффициента Кт
                      <span class="explanation">(Кт &lt;= 0.3)</span>
                    </td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="@КоэфКт"/>
                        <xsl:with-param name="size" select="1"/>
                        <xsl:with-param name="decsize" select="4"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма налога, исчисленного при добыче угля на участке<br/>недр за налоговый период
                    </td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ИсчислУчУг"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Предельная величина налогового вычета
                      <span class="explanation">(стр.080 х стр.070)</span>
                    </td>
                    <td class="text-center">090</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@НалВычПред"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма налога, исчисленного при добыче угля на данном<br/>
                      участке недр за налоговый период с учетом налогового<br/>
                      вычета, подлежащая уплате<br/>
                    </td>
                    <td class="text-center">100</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ИсчислПерУпл"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Остаток неучтенных при определении налогового вычета<br/>
                      расходов, осуществленных (понесенных)<br/>
                      налогоплательщиком и связанных с обеспечением<br/>
                      безопасных условий и охраны труда при добыче угля, на<br/>
                      конец налогового периода<br/>
                      <span class="explanation">(стр.010 + стр.020 - стр.060)</span>
                    </td>
                    <td class="text-center">110</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОстКонПер"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
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
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
            
  </xsl:template>


  <!--4.3-->
  <xsl:template match="РасчНалВыч">
    <!--вызываем раздел 4.3 рекурсивно с блоками по 4 на листе-->
    <xsl:call-template name="pageRecursiveR4.3">
      <xsl:with-param name="CountPage" select="ceiling(count(РасчНалВычУч) div 4)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR4.3">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--выводим по 4 блока на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR4.3">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*4 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR4.3">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR4.3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPWPa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold text-center padding-top5mm">
                4.3. Расчет суммы налоговых вычетов по участку недр
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="57%">Показатели</td>
                    <td width="6%">
                      Код<br/>строки
                    </td>
                    <td width="47%">Значения показателей</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR4.3">
                    <xsl:with-param name="node" select="$node/РасчНалВычУч"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveR4.3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 4) * 4"/>

    <tr>
      <td>
        Месяц и год возникновения права на налоговый вычет
      </td>
      <td class="text-center">
        010
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@НачПравНалВыч"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Сумма налогового вычета, образовавшаяся на месяц и год, указанные в<br/>строке 010
      </td>
      <td class="text-center">
        020
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@НалВычНач"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Сумма налогового вычета, использованная в предыдущие налоговые<br/>периоды
      </td>
      <td class="text-center">
        030
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@НалВычПред"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Сумма налогового вычета, использованная в налоговом периоде
      </td>
      <td class="text-center">
        040
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@НалВычТек"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Остаток суммы налогового вычета на конец налогового периода<br/>
        (стр.020 - стр.030 - стр.040)
      </td>
      <td class="text-center">
        050
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@ОстНалВычКон"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Месяц и год окончания права на налоговый вычет
      </td>
      <td class="text-center">
        060
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@КонПравНалВыч"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td colspan="3">&#160;</td>
    </tr>

    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR4.3">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--Дроби-->
  <xsl:template name="breakDecimal">
    <xsl:param name="input"/>
    <xsl:param name="size">12</xsl:param>
    <xsl:param name="decsize">2</xsl:param>
    <xsl:param name="decZeroPrinted">0</xsl:param>
    <xsl:param name="nullIsPrinted">0</xsl:param>
    <table style="width:auto">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test="contains($input,'.')">
                  <xsl:value-of select="substring(substring-before($input,'.'), 1, $size)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring($input, 1, $size)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="$size"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
        <td style="width: 4mm" class="text-center">.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:value-of select="substring(substring-after($input,'.'), 1, $decsize)"/>
            </xsl:with-param>
            <xsl:with-param name="size" select="$decsize"/>
            <!--<xsl:with-param name="symbol" select="$decZeroPrinted"/>-->
            <xsl:with-param name="nullIsPrinted" select="$decZeroPrinted"/>
          </xsl:call-template>
        </td>
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
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
  
</xsl:stylesheet>