<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="Qualifier.xsl"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--Запоминаем код налоговой-->
  <xsl:variable name="KodNalogInsp" select="substring(Файл/@ИдФайл,16,4)"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!-- href="style.css" -->


    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="Документ">
    <!--Сведения о среднесписочной численности работников за предшествующий календарный год (Приложение к Приказу ФНС РФ от 29.03.2007 № ММ-3-25/174@)-->
    <!--КНД 1110018-->
    <!--NO_SRCHIS-->

    <xsl:call-template name="titlePage"/>

  </xsl:template>



  <!--Страницы-->

  <!--стр.1_Лист01-->
  <xsl:template name="titlePage">
    <table class="page page-margin-narrow border-all">
      <tr>
        <td class="page-content">
          <table>

            <xsl:call-template name="titlePageHeader"/>

            <!--Заголовок-->
            <tr>
              <td class="bold text-center padding-top10mm">
                Сведения<br/>о среднесписочной численности работников<br/>за предшествующий календарный год
              </td>
            </tr>
            <tr>
              <td class="padding-top10mm">
                <table>
                  <tr>
                    <td width="16%" class="bold">Представляется в</td>
                    <td width="64%" class="border-bottom">
                      <xsl:call-template name="NameFromQualifier">
                        <xsl:with-param name="Qualifier">TaxAuthorities</xsl:with-param>
                        <xsl:with-param name="Code" select="$KodNalogInsp"/>
                      </xsl:call-template>
                    </td>
                    <td width="8%" class="text-center">Код</td>
                    <td width="12%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="$KodNalogInsp"/>
                        <xsl:with-param name="size" select="4"/>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td class="podpis">(наименование налогового органа)</td>
                    <td></td>
                    <td></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="1%"></td>
                    <td class="border-bottom">
                      <xsl:value-of select="СвНП/НПЮЛ/@НаимОрг"/>
                      <xsl:apply-templates select="СвНП/НПИП/ФИОИП"/>
                    </td>
                    <td width="1%"></td>
                  </tr>
                  <tr>
                    <td class="podpis" colspan="3">
                      (полное наименование организации/ фамилия, имя, отчество индивидуального предпринимателя)
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td class="border-bottom">
                      &#160;
                    </td>
                    <td></td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <td width="50%">Среднесписочная численность по состоянию на</td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="СодПерСвед/@ДатаСредСпЧисл"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td>
                      <sup>(число, месяц, год)*</sup>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table style="width:auto">
                  <tr>
                    <td>составляет</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <!-- добиваем пробелами слева до ширины в 6 символов -->
                          <xsl:value-of select="substring('      ', 1, 6-string-length(СодПерСвед/@КолЧел))"/>
                          <xsl:value-of select="СодПерСвед/@КолЧел"/>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="6"/>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <td>человек</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td class="podpis padding-top10mm">
                <span class="text-left">
                  *В случае представления сведений о среднесписочной численности работников за предшествующий календарный год отражается дата - 1 января текущего года, а в случае создания (реорганизации) организации отражается первое число месяца, следующего за месяцем, в котором организация была создана (реорганизована).
                </span>
              </td>
            </tr>

            <tr>
              <td class="padding-top10mm">
                <table style="height: 100%;">
                  <tr>
                    <td class="border-top border-right" width ="50%" style="vertical-align: top">
                      <xsl:call-template name="Подписант"/>
                    </td>
                    <td class="border-top" width ="50%" style="vertical-align: top">
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
                  <xsl:with-param name="input">
                    <xsl:value-of select="СвНП/НПИП/@ИННИП"/>
                    <xsl:value-of select="СвНП/НПЮЛ/@ИННЮЛ"/>
                  </xsl:with-param>
                  <xsl:with-param name="size" select="12"/>
                  <xsl:with-param name="symbol">0</xsl:with-param>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                  <xsl:with-param name="alignRight">true</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <table style="margin-top: 2mm; width: auto;">
            <tr>
              <td class="nowrap" style="width: 10mm;">КПП</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="СвНП/НПЮЛ/@КПП"/>
                  <xsl:with-param name="size" select="9"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">Стр.</td>

              <td class="text-left">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="'001'"/>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
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
                <xsl:with-param name="barCode">a1110`PQXXa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--Приложение № 1-->
            <td width="200" class="explanation">
              Приложение<br/>к Приказу ФНС РФ<br/>от 29.03.2007 № ММ-3-25/174@
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right bold">
        Форма по КНД <xsl:value-of select="ОписПерСвед/@КНД"/>
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

  <xsl:template name="Подписант">
    <table>
      <!--заголовок-->
      <tr>
        <td class="bold">
          Достоверность и полноту представленных сведений подтверждаю:<br/>Для организации
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td width="30%">
                Руководитель
              </td>
              <td class="border-bottom">
                <xsl:apply-templates select="СвНП/НПЮЛ/СвРукОрг"/>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="podpis">
                (Фамилия, Имя, Отчество (полностью))
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <!--подпись, дата-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>Подпись&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;Дата</td>
              <td style='width: 50%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:if test="СвНП/НПЮЛ/СвРукОрг">
                      <xsl:value-of select="ОписПерСвед/@ДатаДок"/>
                    </xsl:if>
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

      <tr>
        <td class="bold">
          Для индивидуального предпринимателя
        </td>
      </tr>

      <!--подпись, дата-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>Подпись&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;Дата</td>
              <td style='width: 50%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:if test="not(СвНП/НПЮЛ/СвРукОрг)">
                      <xsl:value-of select="ОписПерСвед/@ДатаДок"/>
                    </xsl:if>
                  </xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-center"></td>
              <td></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>

      <tr>
        <td class="bold">
          Представитель
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td class="border-bottom">
                <xsl:apply-templates select="СвНП/НПИП/СвПред/ФИОПред"/>
                <xsl:apply-templates select="СвНП/НПЮЛ/СвПред/ФИОПред"/>
                <xsl:value-of select="СвНП/НПЮЛ/СвПред/НаимОргПред"/>
                <xsl:value-of select="СвНП/НПИП/СвПред/НаимОргПред"/>
                &#160;
              </td>
            </tr>
            <tr>
              <td class="podpis">
                (полное наименование организации/(фамилия, имя, отчество))
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <!--подпись, дата-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>Подпись&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;Дата</td>
              <td style='width: 50%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:value-of select="''"/>
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
        <td>
          <table>
            <tr>
              <td class="border-bottom">
                <xsl:value-of select="СвНП/НПИП/СвПред/@НаимДокПред"/>
                <xsl:value-of select="СвНП/НПЮЛ/СвПред/@НаимДокПред"/>
              </td>
            </tr>
            <tr>
              <td class="podpis">
                (наименование документа, подтверждающего полномочия представителя,<br/>копия прилагается)
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="ФИОИП|СвРукОрг|ФИОПред">
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
        <td class="bold">
          Заполняется работником налогового органа
        </td>
      </tr>


      <!--дата-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                Дата представления
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
                Зарегистрирована за №
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="11"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

    <!--подпись-->
    <table style="vertical-align: bottom" class="margin-top10mm">
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


  <xsl:template name="breakDate">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 1, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>=</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )"/>
            <xsl:with-param name="size" select="2"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>=</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 4 )"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>