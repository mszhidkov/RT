<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="no_format.xslt"/>
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
    <!-- href="/kilor/xslt/style.css" -->

    <style>
      .border-bottom
      {
      border-bottom: solid 1px black;
      }

    </style>

    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="Документ">
    <!--Налоговая декларация по единому сельскохозяйственному налогу (Приложение № 1 к Приказу Минфина РФ от 22.06.2009 № 57н)-->
    <!--КНД 1151059-->
    <!--NO_ESHN-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="ЕСХН"/>

  </xsl:template>

  <!--Страницы-->

  <!-- Лист 1-->
  <xsl:template name="titlePage">
    <table id="printFormPage1" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table style="height: 100%">
            <xsl:call-template name="titlePageHeader"/>

            <!--Заголовок-->
            <tr>
              <th class ="nowrap">
                <h1>
                  Налоговая декларация по единому сельскохозяйственному налогу
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
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--Налоговый период (код)-->
                    <td class="text-center">Налоговый период (код)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@Период"/>
                        <xsl:with-param name="size" select="2"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--Отчетный год-->
                    <td class="text-center">Отчетный год</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ОтчетГод"/>
                        <xsl:with-param name="size" select="4"/>
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
                    <!--Налоговый орган (код)-->
                    <td class="text-center">Представляется в налоговый орган (код)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@КодНО"/>
                        <xsl:with-param name="size" select="4"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--по месту нахождения (учета) (код)-->
                    <td class="text-center">по месту нахождения (учета) (код)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@ПоМесту"/>
                        <xsl:with-param name="size" select="3"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
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
                  <xsl:with-param name="symbol">-</xsl:with-param>
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
                    <!--число страниц-->
                    <td class="text-right">На</td>
                    <td class="text-center">
                      <table>
                        <tr>
                          <td>
                            <xsl:call-template name="breakStr">
                              <xsl:with-param name="input" select="2+count(ЕСХН/РасчУбытУмНБ)"/>
                              <xsl:with-param name="size" select="3"/>
                              <xsl:with-param name="symbol">-</xsl:with-param>
                            </xsl:call-template>
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
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="''"/>
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
                <table style="height: 100%;">
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
      <xsl:call-template name="Feuilleton"/>
    </table>

  </xsl:template>

  <!-- ********************** лист 2 *************************** -->
  <xsl:template match="ЕСХН">

    <!--Раздел 1. Сумма единого сельскохозяйственного налога, подлежащая уплате,по данным налогоплательщика-->
    <div class="page-break">&#160;</div>
    <table id="printFormPage2" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0180`VPRQa</xsl:with-param>
                  <xsl:with-param name="pageNum">2</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold text-center">
                Раздел 1. Сумма единого сельскохозяйственного налога, подлежащая уплате,<br/>по данным налогоплательщика
              </td>
            </tr>
            <tr>
              <td class="podpis text-right">
                (в рублях)
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="40%">Показатели</td>
                    <td width="7%">
                      Код<br/>строки
                    </td>
                    <td width="53%">Значения показателей</td>
                  </tr>
                  <tr>
                    <td>Код бюджетной классификации</td>
                    <td class="text-center">001</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="size" select="20"/>
                        <xsl:with-param name="input" select="@КБК"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>Код по ОКАТО</td>
                    <td class="text-center">002</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="input" select="@ОКАТО"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма авансового платежа по единому<br/>сельскохозяйственному налогу, исчисленная к<br/>уплате по итогам отчетного периода
                    </td>
                    <td class="text-center">003</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@АвПУ"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма единого сельскохозяйственного налога,<br/>подлежащая уплате по итогам налогового периода<br/><span class="podpis">(стр. 050 Разд. 2 - стр. 003, если стр. 050 Разд. 2 > стр. 003)</span>
                    </td>
                    <td class="text-center">004</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="@НалПУ>=0">
                            <xsl:value-of select="@НалПУ"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Сумма единого сельскохозяйственного налога к<br/>уменьшению за налоговый период<br/><span class="podpis">(стр. 003 - стр. 050 Разд. 2, если стр. 050 Разд. 2 &lt; стр. 003)</span>
                    </td>
                    <td class="text-center">005</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@НалПУ>=0)">
                            <xsl:value-of select="substring-after(@НалПУ,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!--Раздел 2-->
            <xsl:apply-templates select="РасчНал"/>

          </table>
        </td>
      </tr>
      <xsl:call-template name="СведенияПодтверждаю"/>
    </table>

    <!--Раздел 2.1.-->
    <xsl:apply-templates select="РасчУбытУмНБ"/>

  </xsl:template>

  <!--Раздел 2. Расчет единого сельскохозяйственного налога-->
  <xsl:template match="РасчНал">

    <tr>
      <td class="bold text-center">
        Раздел 2. Расчет единого сельскохозяйственного налога
      </td>
    </tr>
    <tr>
      <td class="podpis text-right">
        (в рублях)
      </td>
    </tr>
    <tr>
      <td>
        <table>
          <tr class="text-center italic">
            <td width="50%">Показатели</td>
            <td width="10%">
              Код<br/>строки
            </td>
            <td width="40%">Значения показателей</td>
          </tr>
          <tr>
            <td>
              Сумма доходов за налоговый период, учитываемых<br/>при определении налоговой базы по единому<br/>сельскохозяйственному налогу
            </td>
            <td class="text-center">010</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@СумДоход"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Сумма расходов за налоговый период,<br/>учитываемых при определении налоговой базы по<br/>единому сельскохозяйственному налогу
            </td>
            <td class="text-center">020</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@СумРасход"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Налоговая база по единому сельскохозяйственному<br/>налогу за налоговый период<br/><span class="podpis">(стр. 010 - стр. 020, если стр. 010 > стр. 020)</span>
            </td>
            <td class="text-center">030</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@НалБаза"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Сумма убытка, полученного в предыдущем<br/>(предыдущих) налоговом (налоговых) периоде<br/>(периодах), уменьшающая налоговую базу за<br/>налоговый период
            </td>
            <td class="text-center">040</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@СумУбытУмен"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              Сумма единого сельскохозяйственного налога,<br/>исчисленного за налоговый период<br/><span class="podpis">((стр. 030 - стр. 040) х 6 / 100)</span>
            </td>
            <td class="text-center">050</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@СумНалИсчисл"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </td>
    </tr>

  </xsl:template>

  <!-- ********************** лист 3 *************************** -->

  <!--Раздел 2.1. Расчет суммы убытка, уменьшающей налоговую базупо единому сельскохозяйственному налогу за налоговый период-->
  <xsl:template match="РасчУбытУмНБ">
    <div class="page-break">&#160;</div>
    <table id="printFormPage3" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0180`VPSXa</xsl:with-param>
                  <xsl:with-param name="pageNum">3</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold text-center">
                Раздел 2.1. Расчет суммы убытка, уменьшающей налоговую базу<br/>по единому сельскохозяйственному налогу за налоговый период
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td colspan="3">Показатели</td>
                    <td>
                      Код<br/>строки
                    </td>
                    <td>Значения показателей</td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      Сумма убытков, полученных по итогам предыдущих налоговых периодов,<br/>которые не были перенесены на начало истекшего налогового периода, - всего<br/>
                      <span class="podpis">(сумма строк 020 - 110)</span>
                    </td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="УбытПред/@УбытПредВс"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td width="14%"></td>
                    <td width="12%">
                      в том числе за:
                    </td>
                    <td width="34%"></td>
                    <td width="7%"></td>
                    <td width="23%"></td>
                  </tr>
                  <xsl:apply-templates select="УбытПред/УбытПредГод">
                    <xsl:with-param name="startPos" select="1"/>
                  </xsl:apply-templates>
                  <tr>
                    <td colspan="3">
                      Сумма убытка за истекший налоговый период
                      <span class="podpis">(стр. 020 Разд. 2 - стр. 010 Разд. 2, если стр. 010 Разд. 2 &gt; стр. 020 Разд. 2)</span>
                    </td>
                    <td class="text-center">120</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@СумУбытПер"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      Сумма убытков на начало следующего налогового периода, которые<br/>налогоплательщик вправе перенести на будущие налоговые периоды, всего:
                      <span class="podpis">(стр. 010 - стр. 040 Разд. 2 + стр. 120)</span>
                    </td>
                    <td class="text-center">130</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="УбытСлед/@УбытСледВс"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <xsl:apply-templates select="УбытСлед/УбытСледГод">
                    <xsl:with-param name="startPos" select="13"/>
                  </xsl:apply-templates>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="СведенияПодтверждаю"/>
    </table>

  </xsl:template>

  <xsl:template match="УбытПредГод|УбытСледГод">
    <xsl:param name="startPos"/>
    <tr>
      <td></td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@ГодУбыт"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>год</td>
      <td class="text-center">
        <xsl:value-of select="format-number((position()+$startPos)*10,'000')"/>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@СумУбыт"/>
        </xsl:call-template>
      </td>
    </tr>

  </xsl:template>

  <!--Части страниц-->
  <!--Заголовок для каждой страницы-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageNum"></xsl:param>
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
                  <xsl:with-param name="symbol">-</xsl:with-param>
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
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">Стр.</td>

              <td class="text-left">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="format-number($pageNum,'000')"/>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
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
                <xsl:with-param name="barCode">a0180`VPQTa</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td class="podpis text-right" width="280" style="padding-top: 4mm; padding-bottom: 0;">
              Приложение № 1 к Приказу Минфина РФ от 22.06.2009 № 57н
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

  <!--СведенияПодтверждаю-->
  <xsl:template name="СведенияПодтверждаю">
    <tr>
      <td class="footer" >
        <table>
          <tr>
            <td class="text-center bold" style="font-size: 8pt">Достоверность и полноту сведений, указанных на данной странице, подтверждаю:</td>
          </tr>
          <tr>
            <td class="text-center">
              <table>
                <tr>
                  <td style="width: 10%">&#160;</td>
                  <td class="border-bottom" style="width: 15%">&#160;</td>
                  <td class="explanation" style="width: 5%">&#160;(подпись)</td>
                  <td style="width: 40%">&#160;</td>
                  <td class="border-bottom text-center" style="width: 15%">
                    <xsl:value-of select="$docDate"/>
                  </td>
                  <td class="explanation" style="width: 5%">&#160;(дата)</td>
                  <td style="width: 10%">&#160;</td>
                </tr>
              </table>
            </td>
          </tr>
          <xsl:call-template name="Feuilleton"/>
        </table>
      </td>
    </tr>

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
                с приложением<br/>подтверждающих документов<br/>и (или) их копий на
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
              <td class="text-right">
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
              <td class="text-right">
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
    <table class="vertical-align-bottom margin-top10mm">
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
      <xsl:with-param name="input">
        <xsl:if test="not($input=0)" >
          <xsl:value-of select="$input"/>
        </xsl:if>
        <xsl:if test="$input=0" >
          <xsl:value-of select="''"/>
        </xsl:if>
      </xsl:with-param>

      <!--Если не указан размер - значит размер 12-->
      <xsl:with-param name="size">
        <xsl:if test="$size=''">
          <xsl:value-of select="12"/>
        </xsl:if>
        <xsl:if test="$size!=''">
          <xsl:value-of select="$size"/>
        </xsl:if>
      </xsl:with-param>

      <!--разделитель стандартный-->
      <xsl:with-param name="symbol">-</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--Нули выводит прочерками, разделитель "-", размер 10 -->
  <xsl:template name="breakStrNum10">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size">10</xsl:param>

    <xsl:call-template name="breakStr">
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="size" select="$size"/>
      <xsl:with-param name="nullIsPrinted" select="false"/>
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