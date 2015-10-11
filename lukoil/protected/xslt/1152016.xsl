<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:include href="counter.xslt"/>
  <xsl:include href="no_format.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!-- /kilor/xslt/ -->

  <xsl:variable name="INN">
    <xsl:value-of select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
    <xsl:value-of select="Файл/Документ/СвНП/НПФЛ/@ИННФЛ"/>
  </xsl:variable>
  <xsl:variable name="KPP" select="Файл/Документ/СвНП/НПЮЛ/@КПП"/>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!--Инициализируем скрипт счетчика-->
    <xsl:call-template name="InitCounterScript"/>
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="Документ">
    <!--Налоговая декларация по единому налогу на вмененный доход для отдельных видов деятельности NO_ENVD-->
    <!--КНД 1152016-->
    <!--NO_ENVD-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="ЕНВД"/>

    <!-- Количество страниц выведем -->
    <xsl:call-template name="CountPage"/>

  </xsl:template>

  <xsl:template match="ЕНВД">
    <!--Раздел 1. Сумма единого налога на вмененный доход для отдельных видов деятельности, подлежащая уплате в бюджет по данным налогоплательщика-->
    <xsl:apply-templates select="СумНалПУВД"/>
    <!--Раздел 2. Расчет единого налога на вмененный доход для отдельных видов деятельности-->
    <xsl:apply-templates select="СумНалПУВД/СумПУВД/РасчНалВД"/>
    <!--Раздел 3. Расчет суммы единого налога на вмененный доход за налоговый период-->
    <xsl:apply-templates select="СумНалПУ"/>
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
                  Налоговая декларация<br/> по единому налогу на вмененный доход для отдельных видов деятельности
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
                    <td class="text-center">Налоговый период (код)</td>
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
                    <!--по месту учета (код) 	-->
                    <td class="text-right">
                      по месту учета (код)
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
                    <td class="text-right" width="65%">Код вида экономической деятельности по классификатору ОКВЭД&#160;</td>
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
                    <td width="20%" class="text-right">
                      Форма реорганизации<br/>
                      (ликвидации) <span style="font-size:8pt">(код)</span>
                    </td>
                    <td width="9%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/СвРеоргЮЛ/@ФормРеорг"/>
                        <xsl:with-param name="size" select="1"/>
                      </xsl:call-template>
                    </td>
                    <td width="23%" class="text-right">
                      ИНН/КПП реорганизованной<br/>
                      организации
                    </td>
                    <td width="25%">
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
                    <td id="CountPage"></td>
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
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="Подписант"/>
                    </td>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:call-template name="TaxWorker"/>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td style="font-size:8pt">* - Отчество при наличии.</td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--Раздел 1. Сумма единого налога на вмененный доход, подлежащая уплате в бюджет-->
  <xsl:template match="СумНалПУВД">
    <xsl:param name="knd" />
    <xsl:call-template name="pageRecursiveR1">
      <xsl:with-param name="CountPage" select="ceiling(count(СумПУВД) div 8)"/>
      <xsl:with-param name="node" select="."/>
      <xsl:with-param name="knd" select="$knd" />
    </xsl:call-template>
  </xsl:template>

  <!-- Для рекурсивного вывода раздела 1. -->
  <xsl:template name="pageRecursiveR1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>
    <xsl:param name="knd" />
    <!--выводим по 8 блоков на странице-->
    <!--очередная страница-->
    <xsl:call-template name="pageR1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*8 + 1"/>
      <xsl:with-param name="knd" select="$knd" />
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="knd" select="$knd" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--<xsl:template match="СумНалПУВД">-->
  <xsl:template name="pageR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="knd" />
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPRTa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 1. Сумма единого налога на вмененный доход, подлежащая уплатев бюджет
                </h2>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <xsl:call-template name="table1Hat"/>
                  <tr>
                    <td colspan="3">
                      <!--<xsl:apply-templates select="$node/СумПУВД[position() >= $position and  $position + 8 > position()]"/>-->

                      <!-- Выводим блоки-->
                      <xsl:call-template name="OutStrRecursiveR1">
                        <xsl:with-param name="node" select="$node/СумПУВД"/>
                        <xsl:with-param name="position" select="$position"/>
                      </xsl:call-template>
                      
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>


  <xsl:template name="OutStrRecursiveR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 8) * 8"/>

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
      <td>
        Сумма единого налога на вмененный доход,<br/>
        подлежащая уплате за налоговый период (руб.)<br/>
        <span class="explanation">
          (стр. 060 раздела 3 Х (сумма строк 100 всех разделов<br/>
          2 по данному коду ОКАТО / стр. 010 раздела 3))
        </span>
      </td>
      <td class="text-center" valign="center">030</td>
      <td valign="center">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@НалПУ"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
        </xsl:call-template>
      </td>
    </tr>


    <!--Вызываем рекурсивно следующие строки-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>


  <!--Раздел 2. Расчет единого налога на вмененный доход для отдельных видов деятельности-->
  <xsl:template match="СумПУВД/РасчНалВД">
  <xsl:param name="node"/>
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPSQa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 2. Расчет суммы единого налога на вмененный доход для отдельных видов деятельности
                </h2>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <td>
                      Код вида предпринимательской деятельности<span class="explanation"> (код стр. 010)</span>
                    </td>
                    <td style="text-align: left">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КодВД"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <td style="width: 40%"></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>Коды оказываемых услуг по ОКУН <span class="explanation">(код стр. 015)</span>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="outOkun"/>
              </td>
            </tr>
              
            <xsl:apply-templates select="АдрПредДеят"/>
      
            <tr>
              <td>
                <table>
                  <tr>
                    <td style="width: 29%">
                      Код по ОКАТО<span class="explanation"> (код стр. 030)</span>
                    </td>
                    <td style="width: 71%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="../@ОКАТО"/>
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
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

  <!--Раздел 3. Расчет суммы единого налога на вмененный доход за налоговый период-->
  <xsl:template match="СумНалПУ">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPTXa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 3. Расчет суммы единого налога на вмененный доход за налоговый период
                </h2>
              </th>
            </tr>

            <tr>
              <td class ="text-right" style="margin-top: 10mm">
                (в рублях)
              </td>
            </tr>

            <tr>
              <td>
                <xsl:call-template name="section3Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 2-->
  <xsl:template name="section2Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table23Hat"/>

      <tr>
        <td>
          Базовая доходность на единицу физического показателя в месяц<br/>
          <span class="explanation">(руб.)</span>
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@БазДоход"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>Величина физического показателя за 1 месяц налогового периода </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@ФизПокМес1"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="text-right" style="padding-right:4mm">2 месяц налогового периода</td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@ФизПокМес2"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="text-right" style="padding-right:4mm">3 месяц налогового периода </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@ФизПокМес3"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>Корректирующий коэффициент К1</td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakFactor">
            <xsl:with-param name="input" select="РасчНалВДАдр/@К1"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>Корректирующий коэффициент К2</td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakFactor">
            <xsl:with-param name="input" select="РасчНалВДАдр/@К2"/>
            <xsl:with-param name="size" select="3"/>
            <xsl:with-param name="nullIsPrinted" select="1"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Налоговая база (руб.)<br/>
          <span class="explanation">(стр. 040 х стр. 080 х стр. 090 х (стр. 050 + стр. 060 + стр. 070))</span>
        </td>
        <td class="text-center">100</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@НалБаза"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          Сумма исчисленного единого налога на вмененный доход (руб.) за<br/>
          налоговый период <span class="explanation"> (стр. 100 х 15 / 100)</span>
        </td>
        <td class="text-center">110</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="РасчНалВДАдр/@СумНалИсчисл"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Табличная часть Раздела 3-->
  <xsl:template name="section3Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table3Hat"/>

      <tr>
        <td>
          Налоговая база, исчисленная по всем кодам ОКАТО<br/>
          <span class="explanation">(сумма значений стр. 100 всех заполненных разделов 2 декларации)</span>
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@НалБазаОбщ"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          Сумма исчисленного единого налога на вмененный доход<br/>
          <span class="explanation">(сумма значений стр. 110 всех заполненных разделов 2 декларации)</span>
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СумНалИсчислОбщ"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          Сумма страховых взносов на обязательное пенсионное страхование,<br/>
          обязательное социальное страхование на случай временной<br/>
          нетрудоспособности и в связи с материнством, обязательное медицинское<br/>
          страхование, обязательное социальное страхование от несчастных случаев на<br/>
          производстве и профессиональных заболеваний, уплаченных (в пределах<br/>
          исчисленных сумм) за налоговый период в соответствии с законодательством<br/>
          Российской Федерации при выплате налогоплательщиками вознаграждений<br/>
          работникам, занятым в тех сферах деятельности налогоплательщика, по<br/>
          которым уплачивается единый налог, а также сумма страховых взносов в виде<br/>
          фиксированных платежей, уплаченных индивидуальными<br/>
          предпринимателями за свое страхование
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СумУплСВ"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          Сумма выплаченных в течение налогового периода из средств<br/>
          налогоплательщика пособий по временной нетрудоспособности работникам,<br/>
          занятым в сферах деятельности, по которым уплачивается единый налог на<br/>
          вмененный доход
        </td>
        <td class="text-center" valign="top">040</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СумВыплПВН"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          Общая сумма страховых взносов и пособий по временной нетрудоспособности<br/>
          <span class="explanation">(стр. 030 + стр. 040)</span>, уменьшающая (но не более чем на 50%) сумму<br/>
          исчисленного единого налога на вмененный доход <span class="explanation"> (стр. 020)</span>
        </td>
        <td class="text-center" valign="top">050</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@СумУменОбщ"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          Сумма единого налога на вмененный доход, подлежащая уплате за налоговый
          <br/>период <span class="explanation"> (стр. 020 - стр. 050)</span>
        </td>
        <td class="text-center" valign="top">060</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@НалПУ"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--Шапки таблиц для Раздела 1-->
  <xsl:template name="table1Hat">
    <tr>
      <td class="text-center italic" style="width: 45%">Показатели</td>
      <td class="text-center italic" style="width: 5%">Код строки</td>
      <td class="text-center italic" style="width: 50%">Значения показателей</td>
    </tr>
    <tr>
      <td>Код бюджетной классификации</td>
      <td class="text-center">010</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@КБК"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--Шапки таблиц для Раздела 2 -->
  <xsl:template name="table23Hat">
    <tr>
      <td class="text-center italic" style="width: 55%">Показатели</td>
      <td class="text-center italic" style="width: 15%">
        Код<br/>
        строки
      </td>
      <td class="text-center italic" style="width: 30%">Значения показателей</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td class="text-center">3</td>
    </tr>
  </xsl:template>

  <!--Шапки таблиц для Раздела 3-->
  <xsl:template name="table3Hat">
    <tr>
      <td class="text-center italic" style="width: 65%">Показатели</td>
      <td class="text-center italic" style="width: 6%">
        Код<br/>
        строки
      </td>
      <td class="text-center italic" style="width: 29%">Значения показателей</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td class="text-center">3</td>
    </tr>
  </xsl:template>

  <!--Подвал для Разделов 1, 2, 3-->
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
                  <td class="text-center border-bottom" style="width: 15%">
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
    <xsl:param name="pageID"/>
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
                <xsl:with-param name="barCode">a0291`PPQWa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="podpis text-right" style="width: 75mm; padding-top: 4mm; padding-right: 0mm; padding-bottom: 0;">
              Приложение № 1 <br/> к приказу Федеральной налоговой службы <br/> от 23 января 2012 г. № ММВ-7-3/13@
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
    <xsl:param name="pageID"/>
    <table style="margin-top: 2mm; width: auto">
      <tr>
        <td class="nowrap" style="width: 10mm;">ИНН</td>
        <td>

          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$INN"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
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
            <xsl:with-param name="symbol">&#160;</xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">Стр.</td>
        <xsl:call-template name="pageNum">
          <xsl:with-param name="symbol" select="0"/>
          <xsl:with-param name="alignRight">true</xsl:with-param>
          <xsl:with-param name="pageID" select="$pageID"/>
        </xsl:call-template>
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
      <xsl:if test="ФИО">
        <xsl:apply-templates select="ФИО"/>
      </xsl:if>
      <xsl:if test="not(ФИО)">
        <tr>
          <td>
            <xsl:call-template name="breakStr">
              <xsl:with-param name="size" select="20"/>
              <xsl:with-param name="line" select="3"/>
              <xsl:with-param name="symbol">-</xsl:with-param>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>

      <tr>
        <td class="podpis">
          (фамилия, имя, отчество* полностью)
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
              <td align="center">
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
              <td class="text-right" width="50%">
                с приложением<br/>подтверждающихдокументов<br/> или их копий на
              </td>
              <td align="center">
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
        <td class="podpis">Фамилия, И.О.*</td>
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

  <xsl:template match="СумПУВД">
    <tr>
      <td>Код по ОКАТО</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@ОКАТО"/>
          <xsl:with-param name="size" select="11"/>
          <xsl:with-param name="symbol" select="0"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        Сумма единого налога на вмененный доход,<br/>
        подлежащая уплате за налоговый период (руб.)<br/>
        <span class="explanation">
          (стр. 060 раздела 3 Х (сумма строк 100 всех разделов<br/>
          2 по данному коду ОКАТО / стр. 010 раздела 3))
        </span>
      </td>
      <td class="text-center" valign="center">030</td>
      <td valign="center">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@НалПУ"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="outOkun">
    <table>
      <tr>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="1"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="2"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="3"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="4"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="5"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="6"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <xsl:param name="num"/>
    <table>
      <!--выводим 6 x 6-->
      <xsl:call-template name="OutStrRecursiveOkun">
        <!--передаем набор записей который кратен $num (например 1 и 1+6, 2 и 2+6)-->
        <xsl:with-param name="node" select="$node/ОКУН[position() - $num =  6 * ( ceiling(position() div 6) - 1) ]"/>
      </xsl:call-template>
    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveOkun">
    <xsl:param name="node"/>
    <!--количество строк - 1-->
    <xsl:param name="count">5</xsl:param>
    <!--счетчик позиции-->
    <xsl:variable name="pos" select="6 - $count"/>

    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$pos]"/>
          <xsl:with-param name="size" select="6"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > 0">
      <xsl:call-template name="OutStrRecursiveOkun">
        <xsl:with-param name="count" select="$count - 1"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template match="АдрПредДеят">
    <tr>
      <td style="margin-top: 10mm">
        <span class="bold">Адрес места осуществления предпринимательской деятельности </span>
        <span class="explanation"> (код стр. 020)</span>
      </td>
    </tr>

    <tr>
      <td>
        <table>
          <tr>
            <td style="width: 29%">
              Почтовый индекс
            </td>
            <td style="width: 71%">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Индекс"/>
                <xsl:with-param name="size" select="6"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Субъект Российской Федерации<br/>
              <span style="font-size:8pt">(код)</span>
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@КодРегион"/>
                <xsl:with-param name="size" select="2"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Район
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Район"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Город
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Город"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Населенный пункт (село, поселок и<br/>
              т.п.)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@НаселПункт"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Улица (проспект, переулок и т.д.)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Улица"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Номер дома (владения)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Дом"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Номер корпуса (строения)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Корпус"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Номер офиса (квартиры)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@Кварт"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
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

  <xsl:template name="breakFactor">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"/>
    <xsl:param name="nullIsPrinted"/>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 1">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="1"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="$size"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakPartTaxBase">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 3">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="11"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakPercent">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 3">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>