<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:include href="Qualifier.xsl"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!-- href="/kilor/xslt/style.css" -->
    <style>
      .label
      {
      font-size:7pt;
      }
      .cell-value
      {
      font-size: 9.0pt;
      border-bottom: 1px solid black;
      height:3mm;
      }
      .border-cell-podpis {
      border-top: 1pt solid black;
      font-size: 7.0pt;
      text-align: center;
      vertical-align:top;

    </style>
    <div class="view_container" style="width: 210mm">
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <xsl:template match="Документ">
    <!--IV-->
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <!--Шапка-->
                <table>
                  <tr>
                    <td class="text-right">
                      Приложение № 2<br/>
                      Код по КНД <xsl:value-of select="@КНД"/><br/>
                    </td>
                  </tr>
                </table>
                <table>
                  <tr>
                    <td width="40%"></td>
                    <td>
                      <table style="font-size:9pt;">
                        <tr style="text-align:center">
                          <td width="60%" style="height:5mm;" class="border-solid"></td>
                          <td width="20%" style="text-align:center" class="border-solid">
                            Код ИФНС
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(ОбращИнф/@ИФНС,1,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(ОбращИнф/@ИФНС,2,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(ОбращИнф/@ИФНС,3,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(ОбращИнф/@ИФНС,4,1)"/>
                          </td>
                        </tr>
                        <tr class="border-solid">
                          <td colspan="6">
                            <table style="border:none">
                              <tr>
                                от&#160;
                                <td class="cell-value" style="font-weight:bold">
                                  <xsl:value-of select="СвНП/НПЮЛ/@НаимОрг"/>
                                  <xsl:apply-templates select="СвНП/НПФЛ/ФИО"/>,
                                  <xsl:value-of select="СвНП/НПЮЛ/@ИННЮЛ"/>
                                  <xsl:value-of select="СвНП/НПФЛ/@ИННФЛ"/>
                                </td>
                              </tr>
                              <tr>
                                <td colspan="2" style="font-size:8pt;">
                                  (Наименование организации, ИНН / Ф.И.О. индивидуального<br/> предпринимателя (физического лица), ИНН (при наличии))
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr style="text-align:center;">
                    <td style="font-weight:bold; padding-top:3mm;">Обращение</td>
                    <td style="padding-top:3mm;">
                      Номер обращения:
                      <xsl:value-of select="ОбращИнф/@НомОбращ"/>
                    </td>
                  </tr>
                </table>
                <xsl:apply-templates select="СвНП"/>
                <xsl:apply-templates select="ОбращИнф"/>
                <xsl:apply-templates select="Подписант"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="СвНП">
    <table style="margin-top:10px;">
      <tr>
        <td>
          <span style="margin-left:20px;"> Реквизиты налогоплательщика:</span>
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" colspan="2">
          1. Наименование организации-налогоплательщика, индивидуального предпринимателя, физического лица:
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" class="cell-value" colspan="2">
          <xsl:value-of select="НПЮЛ/@НаимОрг"/>
          <xsl:apply-templates select="НПФЛ/ФИО"/>
        </td>
      </tr>
      <tr>
        <td style="padding-top:3mm;">
          <strong>
            Адрес местонахождения ЮЛ, место жительства ИП, физического лица:
          </strong><br/>
          (Индекс, код региона, район, город, населенный пункт, улица, дом, корпус, кв.)
        </td>
        <td align="right">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="АдрРФ/@Индекс"/>
            <xsl:with-param name="size" select="6"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" class="cell-value" colspan="2">
          <xsl:apply-templates select="АдрРФ"/>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td width="50%" style="font-weight:bold;">
          ИНН организации<br/>
          (ИП, физического лица):<br/>
          <xsl:choose>
            <xsl:when test="НПЮЛ/@ИННЮЛ">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="НПЮЛ/@ИННЮЛ"/>
                <xsl:with-param name="size" select="12"/>
                <xsl:with-param name="symbol">-</xsl:with-param>
                <xsl:with-param name="classBorder">border-solid</xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="НПФЛ/@ИННФЛ">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="НПФЛ/@ИННФЛ"/>
                <xsl:with-param name="size" select="12"/>
                <xsl:with-param name="symbol">-</xsl:with-param>
                <xsl:with-param name="classBorder">border-solid</xsl:with-param>
              </xsl:call-template>
            </xsl:when>
          </xsl:choose>
        </td>
        <td width="50%" style="font-weight:bold;">
          КПП организации<br/>
          <span style="font-size:7pt">(заполняется в случае необходимости)</span><br/>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="НПЮЛ/@КПП"/>
            <xsl:with-param name="size" select="9"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="ОбращИнф">
    <table>
      <tr>
        <td style="font-weight:bold; width:60%">
          Код инспекции ФНС России, которая формирует письмо
        </td>
        <td style="font-weight:bold;">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ИФНС"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="cell-value" colspan="2" style="padding-top:5mm;">
          <xsl:value-of select="ОбращТекст"/>
        </td>
      </tr>
      <tr>
        <td style="font-size:7pt; text-align:center;" colspan="2">
          (текст обращения)
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td style="font-weight:bold;">
          <table>
            <tr>
              <td width="40%">
                Приложение:&#160;&#160;&#160;количество файлов
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="Прил/@КолФайл"/>
                  <xsl:with-param name="size" select="2"/>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                  <xsl:with-param name="alignRight">true</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;">
          Наименование файлов приложений (при наличии)
        </td>
      </tr>
      <xsl:apply-templates select="Прил/НаимПрил"/>
    </table>
  </xsl:template>

  <xsl:template match="НаимПрил">
    <tr>
      <td style="font-weight:bold;">
    - <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Подписант">
    <table>
      <tr style="font-weight:bold;">
        <td style="font-weight:bold; padding-top:3mm;">
          Обращение представлено уполномоченным представителем налогоплательщика
        </td>
        <td style="font-weight:bold; padding-top:3mm;">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ПрПодп"/>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
        <td style="font-weight:bold; padding-top:3mm; padding-left:3mm;">(ДА- 2, НЕТ - 1).</td>
      </tr>
    </table>
    <table style="font-weight:bold; margin-top:15px;">
      <tr>
        <td width="50%" align="left" style="padding-right: 2mm; vertical-align:bottom;">
          Руководитель организации
        </td>
        <td width="20%" style="text-align:center; vertical-align:bottom;"></td>
        <td width="1" style="vertical-align:bottom;" >/</td>
        <td style="text-align:center; vertical-align:bottom; width:30%">
          <xsl:apply-templates select="ФИО" />
        </td>
        <td width="1" style="vertical-align:bottom;">/</td>
        <td style="width:auto"/>
      </tr>
      <tr>
        <td>
          <span style="font-size:7pt;">
            (индивидуальный предприниматель,
            физическое лицо,<br/> уполномоченный представитель)
          </span>
        </td>
        <td class="border-cell-podpis" >Подпись</td>
        <td/>
        <td class="border-cell-podpis" >Ф.И.О.</td>
        <td/>
        <td/>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="ФИО">
    <xsl:value-of select="concat(@Фамилия,' ', @Имя, ' ', @Отчество)"/>
  </xsl:template>

  <xsl:template match="АдрРФ">
    <xsl:call-template name="NameFromQualifier">
      <xsl:with-param name="Qualifier">RegionsRF</xsl:with-param>
      <xsl:with-param name="Code" select="@КодРегион"/>
    </xsl:call-template>
    <xsl:if test="@КодРегион and not(@КодРегион ='') and not(@КодРегион =' ')">, </xsl:if>
    <xsl:value-of select="@Район"/>
    <xsl:if test="@Район and not(@Район ='') and not(@Район =' ')">, </xsl:if>
    <xsl:value-of select="@Город"/>
    <xsl:if test="@Город and not(@Город ='') and not(@Город =' ')">, </xsl:if>
    <xsl:value-of select="@НаселПункт"/>
    <xsl:if test="@НаселПункт and not(@НаселПункт ='') and not(@НаселПункт =' ')">, </xsl:if>
    <xsl:value-of select="@Улица"/>
    <xsl:if test="@Улица and not(@Улица ='') and not(@Улица =' ')">, </xsl:if>
    <xsl:value-of select="@Дом"/>
    <xsl:if test="@Дом and not(@Дом ='') and not(@Дом =' ')">, </xsl:if>
    <xsl:value-of select="@Корпус"/>
    <xsl:if test="@Корпус and not(@Корпус ='') and not(@Корпус =' ')">, </xsl:if>
    <xsl:value-of select="@Кварт"/>
  </xsl:template>

</xsl:stylesheet>
