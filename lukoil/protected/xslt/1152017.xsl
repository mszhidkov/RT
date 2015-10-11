<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:import href="no_format.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <xsl:variable name="INN">
    <xsl:value-of select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
    <xsl:value-of select="Файл/Документ/СвНП/НПФЛ/@ИННФЛ"/>
  </xsl:variable>
  <xsl:variable name="KPP" select="Файл/Документ/СвНП/НПЮЛ/@КПП"/>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="Документ">
    <!--Налоговая декларация по налогу, уплачиваемому в связи с применением упрощенной системы налогообложения NO_USN-->
    <!--КНД 1152017-->
    <!--NO_USN-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="УСН"/>

  </xsl:template>

  <xsl:template match="УСН">
    <!--Раздел 1. Сумма налога на добавленную стоимость, подлежащая уплате в бюджетв отношении товаров, импортированных на территорию Российской Федерациис территории государств - членов таможенного союза-->
    <xsl:call-template name="Section1"/>
    <!--Раздел 2. Сумма акциза, подлежащая уплате в бюджет в отношении подакцизных товаров,импортированных на территорию Российской Федерации с территории государств -членов таможенного союза-->
    <xsl:apply-templates select="РасчНал1|НалМинРасч2"/>
  </xsl:template>

  <!--Страницы-->

  <!--Титульный лист-->
  <xsl:template name="titlePage">
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader"/>

            <!--Заголовок-->
            <tr>
              <th>
                <h1 class="padding-top5mm">
                  Налоговая декларация по налогу, уплачиваемому<br/>в связи с применением упрощенной системы налогообложения
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
                    <!--Налоговый (отчетный) период (код)-->
                    <td class="text-center">Налоговый (отчетный) период (код)</td>
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
                    <td class="text-center">Представляется в налоговый орган (код)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КодНО"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <!--по месту нахождения (учета) (код)-->
                    <td class="text-center">по месту нахождения (учета) (код)</td>
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
                    <xsl:apply-templates select="СвНП/НПФЛ/ФИО" mode="inLine"/>
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
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="3"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <td  class="text-left">страницах</td>

                    <!--число приложений-->
                    <td class="text-right">с приложением подтверждающих документов или их копий на</td>
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

  <!--Раздел 1-->
  <xsl:template name="Section1">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="pageNumber" select="2"/>
                  <xsl:with-param name="barCode">a0300`XPRWa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 1. Сумма налога, уплачиваемого в связи с применением упрощенной системы налогообложения,<br/>и минимального налога, подлежащая уплате в бюджет,<br/>по данным налогоплательщика
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-right italic">(в рублях)</td>
            </tr>

            <tr>
              <td>
                <xsl:call-template name="section1Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 2-->
  <xsl:template match="РасчНал1|НалМинРасч2/РасчНал2">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="pageNumber" select="3"/>
                  <xsl:with-param name="barCode">a0300`XPSTa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 2. Расчет налога, уплачиваемого в связи с применением упрощенной системы налогообложения,<br/>
                  и минимального налога
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-right italic">(в рублях)</td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="section2Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 1-->
  <xsl:template name="section1Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table1Hat"/>

      <tr>
        <td>
          Объект налогообложения<br/><span class="explanation">
            1 - доходы<br/>2 - доходы, уменьшенные на величину расходов
          </span>
        </td>
        <td class="text-center">001</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ОбНал"/>
            <xsl:with-param name="size" select="1"/>
          </xsl:call-template>
        </td>
      </tr>
      <xsl:apply-templates select="@ОКАТО">
        <xsl:with-param name="strNum">010</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@КБК">
        <xsl:with-param name="strNum">020</xsl:with-param>
      </xsl:apply-templates>
      <tr>
        <td>
          Сумма авансового платежа по налогу, исчисленная к<br/>уплате за:
        </td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          первый квартал
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@АвПУКв"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          полугодие
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@АвПУПг"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          девять месяцев
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@АвПУ9м"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма налога, подлежащая уплате за налоговый период<br/>
          <span style="font-size: 6 pt;">
            для стр. 001 = "1": стр. 260 - стр. 280 - стр. 050, если стр. 260 - стр. 280 - стр. 050 >= 0<br/>
            для стр. 001 = "2": стр. 260 - стр. 050, если стр. 260 >= стр. 050 и стр. 260 >= стр. 270
          </span>
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:if test="@НалПУ>0">
                <xsl:value-of  select="@НалПУ"/>
              </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма налога к уменьшению за налоговый период<br/>
          <span style="font-size: 6 pt;">
            для стр. 001 = "1": стр. 050 - (стр. 260 - стр. 280), если стр. 260 - стр. 280 - стр. 050 &lt; 0<br/>
            для стр. 001 = "2": стр. 050 - стр. 260, если стр. 050 > стр. 260 и стр. 270 &lt;= стр. 260<br/>
            <span class="text-right">или стр. 050, если стр. 260 &lt; стр. 270	</span>
          </span>
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after(@НалПУ,'-')"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>Код бюджетной классификации</td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test="НалМинРасч2/НалМин/@КБК">
                  <xsl:value-of select="НалМинРасч2/НалМин/@КБК"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@КБК"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param> 
            <xsl:with-param name="size" select="20"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма минимального налога, подлежащая уплате за<br/>налоговый период<br/>
          <span class="explanation">для стр. 001 = "2": стр. 270, если стр. 270 > стр. 260</span>
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="НалМинРасч2/НалМин/@НалПУМин"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 2-->
  <xsl:template name="section2Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table2Hat"/>
      <tr>
        <td>
          Ставка налога (%)
        </td>
        <td class="text-center">201</td>
        <td>
          <xsl:call-template name="breakTaxRate">
            <xsl:with-param name="input" select="@Ставка"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма полученных доходов за налоговый период
        </td>
        <td class="text-center">210</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@Доход"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма произведенных расходов за налоговый период<br/><span class="explanation">для стр. 001 = "2"</span>
        </td>
        <td class="text-center">220</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@Расход"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма убытка, полученного в предыдущем (предыдущих) налоговом (налоговых)<br/>периоде (периодах), уменьшающая налоговую базу за налоговый период<br/>
          <span class="explanation">для стр. 001 = "2"</span>
        </td>
        <td class="text-center">230</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@УбытПред"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Налоговая база для исчисления налога за налоговый период<br/>
          <span class="explanation">
            для стр. 001 = "1": равно стр. 210<br/>
            для стр. 001 = "2": стр. 210 - стр. 220 - стр. 230, если стр. 210 - стр. 220 - стр. 230 > 0
          </span>
        </td>
        <td class="text-center">240</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@НалБаза|@НалБазаУбыт"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма убытка, полученного за налоговый период<br/>
          <span class="explanation">для стр. 001 = "2": стр. 220 - стр. 210, если стр. 210 &lt; стр. 220</span>
        </td>
        <td class="text-center">250</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after(@НалБазаУбыт,'-')"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма исчисленного налога за налоговый период<br/>
          <span class="explanation">(стр. 240 х стр. 201 / 100)</span>
        </td>
        <td class="text-center">260</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@Исчисл"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма исчисленного минимального налога за налоговый период (ставка налога 1%)<br/>
          <span class="explanation">для стр. 001 = "2": стр. 210 х 1 / 100</span>
        </td>
        <td class="text-center">270</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ИсчислМин"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма уплаченных за налоговый период страховых взносов на обязательное<br/>
          пенсионное страхование, обязательное социальное страхование на случай временной<br/>
          нетрудоспособности и в связи с материнством, обязательное медицинское<br/>
          страхование, обязательное социальное страхование от несчастных случаев на<br/>
          производстве и профессиональных заболеваний, а также выплаченных работникам в<br/>
          течение налогового периода из средств налогоплательщика пособий по временной<br/>
          нетрудоспособности, уменьшающая (но не более чем на 50%) сумму исчисленного налога<br/>
          <span class="explanation">для стр. 001 = "1"</span>
        </td>
        <td class="text-center">280</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@УменНал"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>

  </xsl:template>

  <!--Шапка таблицы для Раздела 1-->
  <xsl:template name="table1Hat">
    <tr>
      <td class="text-center italic" style="width: 50%">Показатели</td>
      <td class="text-center italic" style="width: 5%">Код строки</td>
      <td class="text-center italic" style="width: 45%">Значения показателей</td>
    </tr>
  </xsl:template>

  <!--Шапка таблицы для Раздела 2-->
  <xsl:template name="table2Hat">
    <tr>
      <td class="text-center italic" style="width: 73%">Показатели</td>
      <td class="text-center italic" style="width: 5%">Код строки</td>
      <td class="text-center italic" style="width: 22%">Значения показателей</td>
    </tr>
  </xsl:template>

  <!--Подвал для Разделов 1, 2-->
  <xsl:template name="sectionFeuilleton">
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
                  <td class="border-bottom" style="width: 15%">
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

  <!--Части страниц-->
  <!--Заголовок для каждой страницы-->
  <xsl:template name="pageHeader">
    <xsl:param name="pageNumber"/>
    <xsl:param name="barCode"></xsl:param>
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
            <xsl:with-param name="pageNumber" select="$pageNumber"/>
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
                <xsl:with-param name="pageNumber" select="1"/>
                <xsl:with-param name="barCode">a0300`XPQPa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="text-right vertical-align-top" style="font-size: 6pt; width: 85mm; padding-top: 8mm; padding-right: 0mm; padding-bottom: 0;">
              Приложение № 1 к Приказу Минфина Российской Федерации от 22.06.2009 № 58н<br/>
              (в ред. Приказа ФНС России от 21.07.2011 № ММВ-7-6/458@)
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

  <!--Для печати ИНН, КПП, страницы-->
  <xsl:template name="INN_KPP_Page">
    <xsl:param name="pageNumber"/>
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
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">Стр.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:value-of select="format-number($pageNumber,'000')"/>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Часть титульной страницы со сведениями о подписанте-->
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
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@ПрПодп"/>
                  <xsl:with-param name="size" select="1"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
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
          <table style='margin-top: 10mm;'>
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

  <!--Часть титульной страницы, заполняемой налоговым органом-->
  <xsl:template name="TaxWorker">
    <table>
      <!--заголовок-->
      <tr>
        <td class="text-center">
          <b>Заполняется работником налогового органа</b><br/>Сведения о представлении декларации
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
              <td class="text-right">
                на
              </td>
              <td class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
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
                с приложением<br/>подтверждающих<br/>документов или их копий<br/>на
              </td>
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
              <td>
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
              <td class="text-center">
                Зарегистрирована<br/>за №
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
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
    <table style="margin-top: 5mm">
      <tr>
        <td class="field_text"></td>
        <td>&#160;</td>
        <td class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">Фамилия, И.О.</td>
        <td>&#160;</td>
        <td class="podpis">Подпись</td>
      </tr>
    </table>
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

  <!--Общие теги-->
  <xsl:template match="ФИО">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Фамилия"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Имя"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@Отчество"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="ФИО" mode="inLine">
    <xsl:value-of select="@Фамилия"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Имя"/>
    <xsl:if test="@Отчество">
      <xsl:text>&#160;</xsl:text>
    </xsl:if>
    <xsl:value-of select="@Отчество"/>
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
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
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

  <xsl:template name="breakTaxRate">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="nullIsPrinted"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="contains( $input, '.' )">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>