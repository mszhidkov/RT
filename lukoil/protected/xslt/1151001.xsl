<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="counter.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--Запоминаем ИНН, КПП, Дату документа-->
  <xsl:variable name="Kpp" select="Файл/Документ/СвНП/НПЮЛ/@КПП"/>
  <xsl:variable name="Inn">
    <xsl:value-of select="Файл/Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
    <xsl:value-of select="Файл/Документ/СвНП/НПФЛ/@ИННФЛ"/>
  </xsl:variable>
  <xsl:variable name="docDate" select="Файл/Документ/@ДатаДок"/>
  
  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <style>
      .view_container .table-compact td
      {
      padding: 0pt;
      }
    </style>

    <!--Инициализируем скрипт счетчика-->
    <xsl:call-template name="InitCounterScript"/>
    
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>

  </xsl:template>

  <xsl:template match="Документ">
    <!--Налоговая декларация по налогу на добавленную стоимость (от 15.10.09)-->
    <!--КНД 1151001-->
    <!--NO_NDS-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="НДС"/>

  </xsl:template>

  <xsl:template match="НДС">
    <!--Раздел 1: Сумма налога,подлежащая уплате в бюджет (возмещению из бюджета),по данным налогоплательщика-->
    <xsl:apply-templates select="СумУплНП"/>
    <!--Раздел 2. Сумма налога, подлежащая уплате в бюджет, по данным налогового агента.-->
    <xsl:apply-templates select="СумУплНА"/>
    <!--Раздел 3. Расчет суммы налога, подлежащей уплате в бюджет по операциям,облагаемым по налоговым ставкам, 
    предусмотренным пунктами 2-4 статьи 164 Налогового кодекса Российской Федерации-->
    <xsl:apply-templates select="СумУпл164"/>
    <!--Приложение № 1 к разделу 3 декларации* Сумма НДС, подлежащая восстановлению и уплате в бюджет за отчетный год и предыдущие отчетные годы-->
    <xsl:apply-templates select="СумУпл164/СумВосУпл"/>
    <!--Приложение № 2 к разделу 3 декларации* Расчет суммы налога, исчисленной по операциям по реализации товаров (работ, услуг)...-->
    <xsl:apply-templates select="СумУпл164/СумВычИн"/>
    <!--Раздел 4. Расчет суммы налога по операциям по реализации товаров (работ, услуг), обоснованность применения налоговой ставки 0 процентов по которым документально подтверждена -->
    <xsl:apply-templates select="НалПодтв0"/>
    <!--Раздел 5. Расчет суммы налоговых вычетов по операциям по реализации товаров (работ, услуг), обоснованность применения налоговой ставки 0 процентов по которым ранее документально подтверждена (не подтверждена) -->
    <xsl:apply-templates select="НалВычПред0"/>
    <!--Раздел 6. Расчет суммы налога по операциям по реализации товаров (работ, услуг), обснованность налоговой ставки 0 процентов по которым документально не подтверждена -->
    <xsl:apply-templates select="НалНеПодтв0"/>
    <!--Раздел 7. Операции, не подлежащие налогообложению (освобождаемые от налогообложения); операции, не признаваемые объектом налогообложения; операции по реализации товаров 
    (работ, услуг), местом реализации которых не признается территория Российской Федерации; а также суммы оплаты, частичной оплаты в счет предстоящих поставок товаров (выполнения работ, оказания услуг), 
    длительность производственного цикла изготовления которых составляет свыше шести месяцев -->
    <xsl:apply-templates select="ОперНеНал"/>
    <!-- Количество страниц выведем -->
    <xsl:call-template name="CountPage"/>

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
                    Налоговая декларация<br/> по налогу на добавленную стоимость
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
                      <td class="text-center">
                        <table>
                          <tr>
                            <td>
                              <xsl:call-template name="breakStr">
                                <xsl:with-param name="input"/>
                                <xsl:with-param name="size" select="3"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </table>
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
                    <img src="http://testotchet.rus-telecom.ru/images/accounting/forms/fns/no_nds/5_03/print/{$barCode}" />
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
                <xsl:with-param name="barCode">titular.png</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="podpis text-right" width="260" style="padding-top: 4mm; padding-right: 4mm; padding-bottom: 0;">
              Приложение № 1 к Приказу Минфина РФ <br/>от 15.10.09 № 104н
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
                с приложением<br/>подтверждающих<br/>документов и (или) их копий на
              </td>
              <td class="text-center">
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
    <table style="vertical-align: bottom">
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


  <!--********************* Раздел 1 (лист 2) *********************************-->
  <xsl:template match="СумУплНП">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter1.png</xsl:with-param>
                  <xsl:with-param name="pageNum">2</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  Раздел 1. Сумма налога,<br/>подлежащая уплате в бюджет(возмещению из бюджета),<br/>по данным налогоплательщика
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="40%">Показатели</td>
                    <td width="5%">Код строки</td>
                    <td width="55%">Значения показателей</td>
                  </tr>
                  <tr>
                    <td style="padding-top:5mm;">Код по ОКАТО</td>
                    <td>010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@ОКАТО"/>
                        <xsl:with-param name="size" select="11"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Код бюджетной классификации</td>
                    <td>020</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@КБК"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Сумма налога, исчисленная к уплате в бюджет всоответствии с пунктом 5 статьи 173 Налоговогокодекса Российской Федерации (руб.)</td>
                    <td>030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@СумПУ_173.5"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">
                      Сумма налога, исчисленная к уплате в бюджет в соответствии с пунктом 1 статьи 173 Налоговогокодекса Российской Федерации (руб.)
                      <span class="explanation italic">(величина разницы суммы строк 230 раздела 3, 020 раздела 6 исуммы строк 240 раздела 3, 010 раздела 4, 010 раздела 5 (графы3), 010 раздела 5 (графы 5), 030 раздела 6 больше или равнанулю)</span>
                    </td>
                    <td>040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="@СумПУ_173.1 >= 0">
                            <xsl:value-of select="@СумПУ_173.1"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">
                      Сумма налога, исчисленная к возмещению из бюджетав соответствии с пунктом 1 статьи 173 Налоговогокодекса Российской Федерации (руб.)
                      <span class="explanation italic">(величина разницы суммы строк 230 раздела 3, 020 раздела 6 исуммы строк 240 раздела 3, 010 раздела 4, 010 раздела 5 (графы3), 010 раздела 5 (графы 5), 030 раздела 6 меньше нуля)</span>
                    </td>
                    <td>050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@СумПУ_173.1 >= 0)">
                            <xsl:value-of select="substring-after(@СумПУ_173.1,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>
   
   
  </xsl:template>


  <!--********************* Раздел 2 (лист 3) *********************************-->
  <xsl:template match="СумУплНА">
    <div class="page-break">&#160;</div>
    
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter2.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class="bold text-center" style="margin-top: 10mm;">
                Раздел 2. Сумма налога, подлежащая уплате в бюджет,<br/>по данным налогового агента
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center" >
                    <td width="40%">
                      <i>Показатели</i>
                    </td>
                    <td width="5%">
                      <i>Код строки</i>
                    </td>
                    <td width="55%">
                      <i>Значения показателей</i>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:5mm;">КПП подразделения иностранной организации, состоящей на учете в налоговых органах</td>
                    <td>010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@КППИно"/>
                        <xsl:with-param name="size" select="9"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Наименование налогоплательщика-продавца</td>
                    <td>020</td>
                    <td>
                      <xsl:apply-templates select="СведПродЮЛ"/>
                      <xsl:apply-templates select="СведПродФЛ/ФИОПрод"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">ИНН налогоплательщика - продавца</td>
                    <td>030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:value-of select="СведПродЮЛ/@ИННЮЛПрод"/>
                          <xsl:value-of select="СведПродФЛ/@ИННФЛПрод"/>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="string-length(СведПродЮЛ/@ИННЮЛПрод) + string-length(СведПродФЛ/@ИННФЛПрод)"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Код бюджетной классификации</td>
                    <td>040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@КБК"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Код по ОКАТО</td>
                    <td>050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@ОКАТО"/>
                        <xsl:with-param name="size" select="11"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Сумма налога, исчисленная к уплате в бюджет (руб.)</td>
                    <td>060</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@СумИсчисл"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Код операции</td>
                    <td>070</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@КодОпер"/>
                        <xsl:with-param name="size" select="7"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Сумма налога, исчисленная при отгрузке товаров (выполнении работ, оказании услуг, передачи имущественных прав)</td>
                    <td>080</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@СумИсчислОтгр"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Сумма налога, исчисленная при получении оплаты, частичной оплаты в счет предстоящей отгрузки товаров (выполнения  работ, оказания услуг, передачи имущественных прав)</td>
                    <td>090</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@СумИсчислОпл"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">Сумма налога, исчисленная налоговым агентом с оплаты, частичной оплаты при отгрузке товаров (выполнении  работ, оказании услуг, передаче имущественных прав) в счет этой оплаты, частичной оплаты </td>
                    <td>100</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@СумИсчислНА"/>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>

  </xsl:template>

  <xsl:template match="СведПродЮЛ">
    <xsl:call-template name="breakStr">
      <xsl:with-param name="input" select="@НаимПрод"/>
      <xsl:with-param name="size" select="20"/>
      <xsl:with-param name="line" select="8"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ФИОПрод">
    <xsl:call-template name="breakStr">
      <xsl:with-param name="input">
        <xsl:value-of select="@Фамилия"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@Имя"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@Отчество"/>
      </xsl:with-param>
      <xsl:with-param name="size" select="20"/>
      <xsl:with-param name="line" select="8"/>
      <xsl:with-param name="symbol">-</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--********************* Раздел 3 (лист 4) *********************************-->
  <xsl:template match="СумУпл164">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class ="nowrap bold text-center">
                Раздел 3. Расчет суммы налога, подлежащей уплате в бюджет по операциям,<br/>облагаемым по налоговым ставкам, предусмотренным пунктами 2-4 статьи 164<br/>Налогового кодекса Российской Федерации
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact" style="font-size: 8pt">
                  <tr class="text-center italic">
                    <td width="36%">Налогооблагаемые объекты</td>
                    <td width="4%">Код строки</td>
                    <td width="28%">Налоговая база (руб.)</td>
                    <td width="4%">Ставка НДС</td>
                    <td width="28%">Сумма НДС (руб.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <tr>
                    <td rowspan="4">1. Реализация (передача для собственных нужд) товаров (работ, услуг), передача имущественных прав по соответствующим ставкам налога, всего</td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов18/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов18/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов10/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">10%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов10/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов118/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18/118</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов118/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов110/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">10/110</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалТов110/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>2. Реализация предприятия в целом как имущественного комплекса</td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалПредИК/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/РеалПредИК/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>3. Выполнение строительно-монтажных работ для собственного потребления</td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ВыпСМРСоб/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ВыпСМРСоб/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>4. Суммы полученной оплаты, частичной оплаты в счет предстоящих поставок товаров (выполнения работ, оказания услуг), передачи имущественных прав</td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ОплПредПост/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ОплПредПост/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>5. Суммы, связанные с расчетами по оплате налогооблагаемых товаров (работ, услуг)</td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ОплНОТовар/@НалБаза"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/ОплНОТовар/@СумНал"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>6.Суммы налога, подлежащие восстановлению, всего:</td>
                    <td class="text-center">090</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/СумНалВосст/@СумНалВс"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>в том числе</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>6.1. суммы налога, подлежащие восстановлению при совершении операций, облагаемых по налоговой ставке 0 процентов</td>
                    <td class="text-center">100</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/СумНалВосст/@СумНалСтав0"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>6.2. суммы налога, подлежащие восстановлению в соответствии с подпунктом 3 пункта 3 статьи 170 Налогового Кодекса Российской Федерации</td>
                    <td class="text-center">110</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/СумНалВосст/@СумНал170"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>7. Общая сумма НДС, исчисленная с учетом восстановления сумм налога (сумма величин графы 5 строк 010 - 090)</td>
                    <td class="text-center">120</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалОб/@НалВосстОбщ"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact" style="font-size: 8pt">
                  <tr class="text-center italic">
                    <td width="68%">Налоговые вычеты</td>
                    <td width="4%">Код строки</td>
                    <td width="28%">Сумма НДС (руб.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <tr>
                    <td>8. Сумма налога, предъявленная налогоплательщику при приобретении на территории Российской Федерации товаров (работ, услуг), имущественных прав, подлежащая вычету в соответствии с пунктом 2 статьи 171 Налогового кодекса Российской Федерации, а также сумма налога, подлежащая вычету в соответствии с пунктом 5 статьи 171 Налогового кодекса Российской Федерации</td>
                    <td class="text-center">130</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/НалВыч171/@НалВыч171Общ"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>8.1.в том числе предъявленная подрядными организациями (заказчиками-застройщиками) по выполненным работам при проведении капитального строительства</td>
                    <td class="text-center">140</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/НалВыч171/@НалВычКапСтр"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>9. Сумма налога, предъявленная налогоплательщику - покупателю при перечислении суммы оплаты, частичной оплаты в счет предстоящих поставок товаров (выполнения работ, оказания услуг), передачи имущественных прав, подлежащая вычету у покупателя</td>
                    <td class="text-center">150</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/@НалПредНППок"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>10. Сумма налога, исчисленная при выполнении строительно-монтажных работ для собственного потребления, подлежащая вычету</td>
                    <td class="text-center">160</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/@НалИсчСМР"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>11. Сумма налога, уплаченная налогоплательщиком при ввозе товаров на таможенную территорию Российской Федерации, подлежащая вычету, всего</td>
                    <td class="text-center">170</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/НалВычТамож/@НалВычВс"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>в том числе:</td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>11.1. таможенным органам по товарам, ввезенным в таможенных режимах выпуска для внутреннего потребления, временного ввоза и переработки вне таможенной территории</td>
                    <td class="text-center">180</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/НалВычТамож/@НалУплТО"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>11.2. налоговым органом при ввозе товаров с территории Республики Беларусь</td>
                    <td class="text-center">190</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/НалВычТамож/@НалУплНО"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>12. Сумма налога, исчисленная продавцом с сумм оплаты, частичной оплаты, подлежащая вычету у продавца с даты отгрузки соответствующих товаров (выполнения работ, оказания услуг)</td>
                    <td class="text-center">200</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/@НалИсчПрод"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>13. Сумма налога, уплаченная в бюджет налогоплательщиком в качестве покупателя - налогового агента, подлежащая вычету</td>
                    <td class="text-center">210</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/@НалУплПокНА"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      14. Общая сумма НДС, подлежащая вычету <span class="explanation">(сумма величин, указанных в строках 130, 150-170, 200, 210)</span>
                    </td>
                    <td class="text-center">220</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="СумНалВыч/@НалВычОбщ"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      15. Итого сумма НДС, исчисленная к уплате в бюджет по данному разделу <span class="explanation">(разность величин строк 120, 220 больше или равна нулю)</span>
                    </td>
                    <td class="text-center">230</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="@НалПУ164>=0" >
                            <xsl:value-of select="@НалПУ164"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      16. Итого сумма НДС, исчисленная к уменьшению по данному разделу <span class="explanation">(разность величин строк 120, 220 меньше нуля)</span>
                    </td>
                    <td class="text-center">240</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@НалПУ164>=0)" >
                            <xsl:value-of select="substring-after(@НалПУ164,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>
      
  </xsl:template>

  <!--********************* Приложение 1 к разделу 3 (лист 5) *********************************-->

  <xsl:template match="СумВосУпл">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3_app1.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class="text-right bold">
                <br/>Приложение № 1 к разделу 3 декларации*
              </td>
            </tr>
            <tr>
              <td class ="text-center nowrap bold">
                Сумма НДС, подлежащая восстановлению и уплате в бюджет<br/>
                за отчетный год и предыдущие отчетные годы
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <td width="20%">
                    Наименование объекта недвижимости<br/><span class="explanation italic">(код строки 010)</span>
                  </td>
                  <td width="80%">
                    <xsl:call-template name="breakStr">
                      <xsl:with-param name="input" select="@НаимНедв"/>
                      <xsl:with-param name="size" select="33"/>
                      <xsl:with-param name="line" select="3"/>
                      <xsl:with-param name="symbol">-</xsl:with-param>
                    </xsl:call-template>
                  </td>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                Адрес местонахождения объекта недвижимости <span class="explanation italic">(код строки 020)</span>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="20%">Почтовый индекс</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="АдрМННед/@Индекс"/>
                        <xsl:with-param name="size" select="5"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-right">Субъект Российской Федерации (код)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="АдрМННед/@КодРегион"/>
                        <xsl:with-param name="size" select="2"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
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
                    <td width="20%">Район</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="АдрМННед/@Район"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Город</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="АдрМННед/@Город"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Населенный пункт (село, поселок и т.п.)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="АдрМННед/@НаселПункт"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Улица (проспект, переулок и т.д.)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="АдрМННед/@Улица"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <td>
                    Номер дома<br/>(владения)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="АдрМННед/@Дом"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                  <td>
                    Номер корпуса<br/>(строения)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="АдрМННед/@Корпус"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                  <td>
                    Номер квартиры<br/>(офиса)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="АдрМННед/@Кварт"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="75%">
                      Код операции по объекту недвижимости <span class="explanation italic">(код строки 030)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@КодОпНедв"/>
                        <xsl:with-param name="size" select="7"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Дата ввода объекта недвижимости в эксплуатацию для исчисления амортизации <span class="explanation italic">(код строки 040)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="@ДатаВводОН"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Дата начала начисления амортизационных отчислений по объекту недвижимости <span class="explanation italic">(код строки 050)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="@ДатаНачАмОтч"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Стоимость объекта недвижимости на дату ввода объекта в эксплуатацию без учета НДС (руб.) <span class="explanation italic">(код строки 060)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СтВводОН"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма НДС, принятая к вычету по объекту недвижимости (руб.) <span class="explanation italic">(код строки 070)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@НалВычОН"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="25%">
                      <span class="explanation">(код строки 080)</span><br/><br/>За отчетный год<br/>(предыдущие отчетные годы)
                    </td>
                    <td width="25%">
                      Дата начала использования<br/>объекта недвижимости для<br/>операций, указанных<br/>в п.2 ст.170 Налогового<br/>кодекса Российской Федерации
                    </td>
                    <td width="25%">
                      Доля отгруженных товаров<br/>(работ, услуг),<br/>имущественных прав, не<br/>облагаемых НДС, в общей<br/>стоимости отгрузки (%)
                    </td>
                    <td width="25%">
                      Сумма НДС, подлежащая<br/>восстановлению и уплате в<br/>бюджет за календарный год<br/>(истекшие календарные годы) (руб.)
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="СведНалГод"/>
                  <xsl:if test="not(СведНалГод)">
                    <tr class="text-center">
                      <td>
                        <xsl:call-template name="breakStrNum10">
                          <xsl:with-param name="input" select="''"/>
                          <xsl:with-param name="size" select="4"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakDate">
                          <xsl:with-param name="input" select="''"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakProc">
                          <xsl:with-param name="input" select="'0.0'"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakStrNum10">
                          <xsl:with-param name="input" select="''"/>
                        </xsl:call-template>
                      </td>
                    </tr>
                  </xsl:if>

                </table>
              </td>
            </tr>
            <tr>
              <td>
                <sup>* представляется налогоплательщиком одновременно с налоговой декларацией по налогу на добавленную стоимость не позднее 20 января года, следующего за истекшим календарным годом</sup>
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

  <xsl:template match="СведНалГод">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@ГодОтч"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDate">
          <xsl:with-param name="input" select="@ДатаИсп170"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakProc">
          <xsl:with-param name="input" select="@ДоляНеОбл"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалГод"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* Приложение 2 к разделу 3 (лист 6) *********************************-->
  <xsl:template match="СумВычИн">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3_app2.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class="text-right bold">
                <br/>Приложение № 2 к разделу 3 декларации
              </td>
            </tr>
            <tr>
              <td class ="text-center nowrap bold">
                Расчет суммы налога, исчисленной по операциям по реализации товаров (работ, услуг), передаче<br/>
                имущественных прав и суммы налога, подлежащей вычету, иностранной организацией, осуществляющей<br/>
                предпринимательскую деятельность на территории Российской Федерации через свои подразделения<br/>
                (представительства, отделения)
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td>
                      КПП подразделений<br/>иностранной организации,<br/>состоящей на учете в<br/>налоговых органах<br/>Российской Федерации
                    </td>
                    <td>
                      Сумма налога, исчисленная по<br/>операциям, подлежащим<br/>налогообложению (руб.)
                    </td>
                    <td>Сумма налоговых вычетов (руб.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <xsl:apply-templates select="СведНалГодИ"/>

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

  <xsl:template match="СведНалГодИ">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@КППИнУч"/>
          <xsl:with-param name="size" select="9"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum12">
          <xsl:with-param name="input" select="@СумНалИсч"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum12">
          <xsl:with-param name="input" select="@СумНалВыч"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* Раздел 4 (лист 7) *********************************-->
  <xsl:template match="НалПодтв0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter4.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class ="text-center nowrap bold">
                Раздел 4. Расчет суммы налога по операциям по реализации товаров (работ, услуг), обоснованность применения<br/>
                налоговой ставки 0 процентов по которым документально подтверждена
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center italic">
                    <td width="25%">
                      <table>
                        <tr>
                          <td>
                            <i>
                              Код<br/>операции
                            </i>
                          </td>
                          <td>
                            <i>Налоговая база</i>
                          </td>
                        </tr>
                      </table>
                    </td>
                    <td width="25%">
                      Налоговые вычеты по<br/>операциям, обоснованность<br/>применения налоговой ставки<br/>0 процентов по которым<br/>документально подтверждена
                    </td>
                    <td width="25%">
                      Сумма налога, ранее<br/>исчисленная по операциям,<br/>обоснованность применения<br/>налоговой ставки 0 процентов<br/>по которым ранее не была<br/>документально подтверждена
                    </td>
                    <td width="25%">
                      Сумма налога, ранее<br/>принятая к вычету и<br/>подлежащая восстановлению
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>
                      <table>
                        <tr>
                          <td>1</td>
                          <td>2</td>
                        </tr>
                      </table>
                    </td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <xsl:apply-templates select="СумОпер4"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr>
                    <td width="50%">
                      Итого сумма налога, исчисленная к уменьшению по данному разделу<span class="italic">(код строки 010)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СумУменИтог"/>
                      </xsl:call-template>
                    </td>
                    <td width="25%">&#160;</td>
                  </tr>
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

  <xsl:template match="СумОпер4">
    <tr>
      <td>
        <xsl:value-of select="@КодОпер"/>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалБаза"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалВычПод"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалНеПод"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалВосст"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* Раздел 5 (лист 8) *********************************-->

  <xsl:template match="НалВычПред0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter5.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class ="text-center nowrap bold">
                Раздел 5. Расчет суммы налоговых вычетов по операциям по реализации товаров (работ, услуг), обоснованность<br/>
                применения налоговой ставки 0 процентов по которым ранее документально подтверждена (не подтверждена)
              </td>
            </tr>
            <tr>
              <td>
                <table style="width: auto;">
                  <tr>
                    <td>Отчетный год</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@ОтчетГод"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <td width="35"></td>
                    <td>Налоговый период (код)</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@Период"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <td width="50"></td>
                    <td class="podpis italic">суммы в рублях</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="10%">
                      Код<br/>операции
                    </td>
                    <td width="45%">
                      По операциям, обоснованность применения налоговой ставки 0 процентов по которым документально подтверждена в предыдущих налоговых периодах
                    </td>
                    <td width="45%">
                      По операциям, обоснованность применения налоговой ставки 0 процентов по которым документально не подтверждена в предыдущих налоговых периодах
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center">
                    <td width="25%">
                      <table>
                        <tr>
                          <td>1</td>
                          <td>2</td>
                        </tr>
                      </table>
                    </td>
                    <td width="25%">3</td>
                    <td width="25%">4</td>
                    <td width="25%">5</td>
                  </tr>
                  <xsl:apply-templates select="СумОпер5"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr>
                    <td width="25%">
                      Сумма налога, исчисленная к уменьшению по данному разделу<span class="italic">(код строки 010)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СумУменПод"/>
                      </xsl:call-template>
                    </td>
                    <td width="25%">&#160;</td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СумУменНеПод"/>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>
   
  </xsl:template>

  <xsl:template match="СумОпер5">
    <tr>
      <td>
        <xsl:value-of select="@КодОпер"/>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалБазаПод"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалВычПод"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалБазаНеПод"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалВычНеПод"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* Раздел 6 (лист 9) *********************************-->
  <xsl:template match="НалНеПодтв0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter6.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class ="text-center nowrap bold">
                Раздел 6. Расчет суммы налога по операциям по реализации товаров (работ, услуг), обоснованность применения<br/>
                налоговой ставки 0 процентов по которым документально не подтверждена
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="16%">Код операции</td>
                    <td width="28%">Налоговая база</td>
                    <td width="28%">Суммы НДС, исчисленные по налоговым ставкам, предусмотренным пунктами 2-3 статьи 164 Налогового кодекса Российской Федерации</td>
                    <td width="28%">
                      <span class="podpis">суммы в рублях</span><br/><br/>
                      Сумма налоговых вычетов по операциям по реализации товаров (работ, услуг), обоснованность применения налоговой ставки 0 процентов по которым документально не подтверждена
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="СумОпер6"/>
                  <tr>
                    <td>
                      Итого <span class="italic explanation">(код строки 010)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@НалБазаИт"/>
                      </xsl:call-template>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СумНал164Ит"/>
                      </xsl:call-template>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@НалВычНеПодИт"/>
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
                    <td width="72%">
                      Итого, сумма налога, исчисленная к уплате в бюджет по данному разделу <span class="italic explanation">(код строки 020)</span>
                    </td>
                    <td width="28%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="@НалИсчислИт>=0">
                            <xsl:value-of select="@НалИсчислИт"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Итого, сумма налога, исчисленная к уменьшению по данному разделу <span class="italic explanation">(код строки 030)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@НалИсчислИт>=0)">
                            <xsl:value-of select="substring-after(@НалИсчислИт,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
      
    </table>
     
    
  </xsl:template>

  <xsl:template match="СумОпер6">
    <tr class="text-center">
      <td>
        <xsl:value-of select="@КодОпер"/>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалБаза"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@СумНал164"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалВычНеПод"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* Раздел 7 (лист 10) *********************************-->
  <xsl:template match="ОперНеНал">
    <div class="page-break">&#160;</div>
   
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter7.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--Заголовок-->
            <tr>
              <td class ="text-center nowrap bold">
                Раздел 7. Операции , не подлежащие налогообложению (освобождаемые от налогообложения); операции , не<br/>
                признаваемые объектом налогообложения; операции по реализации товаров (работ, услуг), местом реализации<br/>
                которых не признается территория Российской Федерации; а также суммы оплаты, частичной оплаты в счет<br/>
                предстоящих поставок товаров (выполнения работ, оказания услуг), длительность производственного цикла<br/>
                изготовления которых составляет свыше шести месяцев
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="25%" class="italic explanation">(код строки 010)</td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                    <td width="25%" class="italic explanation">суммы в рублях</td>
                  </tr>
                  <tr class="text-center italic">
                    <td>Код операции</td>
                    <td>Стоимость реализованных (переданных) товаров (работ, услуг), без НДС (руб.)</td>
                    <td>Стоимость приобретенных товаров (работ, услуг), необлагаемых НДС (руб.)</td>
                    <td>Сумма НДС по приобретенным товарам (работам, услугам), не подлежащая вычету (руб.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="СумОпер7"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="75%">
                      Сумма полученной оплаты, частичной оплаты в счет предстоящих поставок товаров (выполнения работ, оказания услуг), длительность производственного цикла изготовления которых составляет свыше шести месяцев, по перечню, определяемому Правительством Российской Федерации
                      <span class="italic explanation">(код строки 020)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@ОплПостСв6Мес"/>
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
          <xsl:call-template name="СведенияПодтверждаю"/>
        </td>
      </tr>
    </table>

    
  </xsl:template>

  <xsl:template match="СумОпер7">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@КодОпер"/>
          <xsl:with-param name="size" select="7"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@СтРеалТов"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@СтПриобТов"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@НалНеВыч"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!-- Проценты выводим -->
  <xsl:template name="breakProc">
    <xsl:param name="input"></xsl:param>
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:if test="substring-before($input,'.')='0'">
                <xsl:value-of select="''"/>
              </xsl:if>
              <xsl:if test="substring-before($input,'.')!='0'">
                <xsl:value-of select="substring-before($input,'.')"/>
              </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:if test="substring-after($input,'.')='0'">
                <xsl:value-of select="''"/>
              </xsl:if>
              <xsl:if test="substring-after($input,'.')!='0'">
                <xsl:value-of select="substring-after($input,'.')"/>
              </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--Нули выводит прочерками, а разделитель "-", размер 12 -->
  <xsl:template name="breakStrNum12">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"></xsl:param>

    <xsl:call-template name="breakStr">
      <!--Если значение 0, то пустую строку передаем-->
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="nullIsPrinted"></xsl:with-param>

      <!--Если не указан размер - значит размер 12-->
      <xsl:with-param name="size">
        <xsl:choose>
          <xsl:when test="$size">
            <xsl:value-of select="$size"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="12"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--Нули выводит прочерками, а разделитель "-", размер 10 -->
  <xsl:template name="breakStrNum10">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"></xsl:param>

    <xsl:call-template name="breakStr">
      <!--Если значение 0, то пустую строку передаем-->
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="nullIsPrinted"></xsl:with-param>
      <!--Если не указан размер - значит размер 10-->
      <xsl:with-param name="size">
        <xsl:choose>
          <xsl:when test="$size">
            <xsl:value-of select="$size"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="10"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
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