<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251" />
  <xsl:include href="Qualifier.xsl"/>
  <xsl:include href="style.xslt"/>
  <xsl:variable name="KodNalogInsp" select="substring(Файл/@ИдФайл,9,4)"/>
  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    
    <style>
      .table-with-border td
      {
        border: 1pt solid black;
        padding-left: 2pt;
        vertical-align: bottom;
        text-align: center;
      }
      
      .no-border td
      {
        border: none;
      }

    </style>
     <div class="view_container" style="width: 210mm">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <xsl:template match="Документ">
    <xsl:call-template name="Page"/>
  </xsl:template>
  <xsl:template name="Page">
    <table class="page page-margin-narrow" >
      <tr>
        <td class="page-content">
          <table style="text-align:right">
            <tr>
              <td>
                Код по КНД 1166101
              </td>
            </tr>
          </table>
          
          <table width="100%">
            <tr>
              <td width="50%" style="border: 0mm"></td>
              <td width="50%" style="border: 0mm">
                <table class="table-with-border">
                  <tr>
                    <td width="40%"></td>
                    <td width="30%">Код ИФНС</td>
                    <td width="7.5%">
                      <xsl:value-of select="number(substring($KodNalogInsp,1,1))"/>
                    </td>
                    <td width="7.5%">
                      <xsl:value-of select="number(substring($KodNalogInsp,2,1))"/>
                    </td>
                    <td width="7.5%">
                      <xsl:value-of select="number(substring($KodNalogInsp,3,1))"/>
                    </td>
                    <td width="7.5%">
                      <xsl:value-of select="number(substring($KodNalogInsp,4,1))"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6">
                      <table width="100%" class="no-border">
                        <tr>
                          <td width="2%"></td>
                          <td width="5%">от</td>
                          <td style="border-bottom:1pt solid black; text-align:left">
                            <xsl:choose>
                              <xsl:when test="СвОтпр/СвОтпрЮЛ">
                                <xsl:value-of select="СвОтпр/СвОтпрЮЛ/@НаимОрг"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="СвОтпр/СвОтпрЮЛ/@ИННЮЛ"/>
                              </xsl:when>
                              <xsl:when test="СвОтпр/СвОтпрФЛ">
                                <xsl:apply-templates select="СвОтпр/СвОтпрФЛ/ФИО" mode="inLine"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="СвОтпр/СвОтпрФЛ/@ИННФЛ"/>
                              </xsl:when>
                            </xsl:choose>
                          </td>
                          <td width="2%"></td>
                        </tr>
                        <tr>
                          <td></td>
                          <td style="border-bottom:1pt solid black" colspan="2">
                            <xsl:text>&#160;</xsl:text>
                          </td>
                          <td></td>
                        </tr>
                      </table>
                      
                      <table width="100%" class="no-border">
                        <tr>
                          <td width="1%"></td>
                          <td style="border-bottom:2pt solid black; height:1mm"></td>
                          <td width="1%"></td>
                        </tr>
                        <tr>
                          <td></td>
                          <td class="podpis" style="text-align:left">
                            (Наименование организации, ИНН / Ф.И.О. индивидуального<br/>предпринимателя (физического лица), ИНН)
                          </td>
                          <td></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>

          <table width="100%" style="margin-top:15px;">
            <tr>
              <td style="font-size:15px" class="text-center bold">
                Запрос
              </td>
            </tr>
            <tr>
              <td style="padding-left:8mm; padding-top:15px">
                Прошу предоставить данные в рамках информационного обслуживания налогоплательщиков.<br/>Реквизиты налогоплательщика:
              </td>
            </tr>
            <tr>
              <td style="padding-top:15px" class="bold">
                <xsl:text>&#160;&#160;&#160;</xsl:text>
                4  Наименование организации-налогоплательщика, индивидуального предпринимателя,<br/>физического лица:
              </td>
            </tr>
            <tr>
              <td style="border-bottom:1pt solid black; text-align:left">
                <xsl:choose>
                  <xsl:when test="СвНП/НПЮЛ">
                    <xsl:value-of select="СвНП/НПЮЛ/@НаимОрг"/>
                  </xsl:when>
                  <xsl:when test="СвНП/НПФЛ/ФИО">
                    <xsl:apply-templates select="СвНП/НПФЛ/ФИО" mode="inLine"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>&#160;</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
            <tr>
              <td style="border-bottom:1pt solid black; text-align:left">
                <xsl:text>&#160;</xsl:text>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:apply-templates select="СвНП/АдрРФ"/>
              </td>
            </tr>
            <tr>
              <td>
                <table style="margin-top:5mm">
                  <tr>
                    <td width="50%">
                      <span class="bold">
                        ИНН организации<br/>(ИП, физического лица)<br/>
                      </span>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/@ИННЮЛ"/>
                        <!--<xsl:with-param name="input" select="СвНП/НПФЛ/@ИННФЛ"/>-->
                        <xsl:with-param name="size" select="12"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <td >
                      <span class="bold">
                        КПП организации<br/><span class="podpis">(заполняется в случае необходимости)</span><br/>
                      </span>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="СвНП/НПЮЛ/@КПП"/>
                        <xsl:with-param name="size" select="9"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table style="margin-top:3mm">
                  <tr>
                    <td width="55%" class="bold">
                        Код инспекции ФНС России, в которой формируется ответ:
                    </td>
                    <td width="15%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="$KodNalogInsp"/>
                        <xsl:with-param name="size" select="4"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <td>
                      <xsl:text>&#160;</xsl:text>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:apply-templates select="ЗапрИнфУсл"/>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:apply-templates select="Подписант"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>


  <xsl:template match="ЗапрИнфУсл">
    <table style="margin-top:3mm">
      <tr>
        <td width="13%" class="bold" style="vertical-align:top; padding-top:1mm">
          Код запроса:
        </td>
        <td width="5%" style="vertical-align:top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@КодЗапр"/>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="bold" style="padding-left:7mm">
          1 - справка о состоянии расчетов по налогам, сборам, пеням и штрафам<br/>
          2 - выписка операций по расчетам с бюджетом<br/>
          3 - перечень налоговых деклараций (расчетов) и бухгалтерской отчетности<br/>
          4 - акт сверки расчетов по налогам, сборам, пеням и штрафам
        </td>
      </tr>
      <tr>
        <td colspan="3">
          <xsl:apply-templates select="СпрРасБюд"/>
          <xsl:apply-templates select="ВыпОперРас"/>
          <xsl:apply-templates select="ПеречНалДекл"/>
          <xsl:apply-templates select="АктСвер"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="СпрРасБюд|ВыпОперРас|ПеречНалДекл|АктСвер">
    <table style="margin-top:3mm" class="table-with-border">
      <tr>
        <td width="33%" style="text-align:left">
          <xsl:choose>
            <xsl:when test="@УслФорВып">
              Условие формирования выписки<br/>операций по расчетам с бюджетом
            </xsl:when>
            <xsl:when test="@УслВыбОтч">
              Условие выбора отчётности
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>&#160;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td width="33%" style="vertical-align:middle">
          <xsl:choose>
            <xsl:when test="@УслФорВып">
              <xsl:if test="@УслФорВып=1">
                1 - группировать по видам платежа
              </xsl:if>
              <xsl:if test="@УслФорВып=2">
                2 - не группировать по видам платежа
              </xsl:if>
            </xsl:when>
            <xsl:when test="@УслВыбОтч">
              <xsl:if test="@УслВыбОтч=1">
                1 – все виды деклараций
              </xsl:if>
              <xsl:if test="@УслВыбОтч=2">
                2 – первичные
              </xsl:if>
              <xsl:if test="@УслВыбОтч=3">
                3 – корректирующие (последняя коррекция)
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>&#160;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
    </table>

    <table style="margin-top:3mm">
      <tr>
        <td width="40%" style="text-align:left; vertical-align:top">
          <span class="bold">
            Формат представления ответа:<br/>
          </span>
          <span style="padding-left:5mm">
            (отметить нужное)
          </span>
        </td>
        <td width="20%">
          <table class="table-with-border">
            <tr>
              <td width="50%" style="vertical-align:top; padding-bottom:5mm" class="bold">
                RTF
              </td>
              <td width="50%" style="vertical-align:middle">
                <xsl:if test="//@ФормОтв='RTF'">
                  V
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td style="vertical-align:top; padding-bottom:5mm" class="bold">
                XML
              </td>
              <td style="vertical-align:middle">
                <xsl:if test="//@ФормОтв='XML'">
                  V
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td style="vertical-align:top; padding-bottom:5mm" class="bold">
                Excel
              </td>
              <td style="vertical-align:middle">
                <xsl:if test="//@ФормОтв='XLS'">
                  V
                </xsl:if>
              </td>
            </tr>
          </table>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
    </table>

    <table style="margin-top:3mm">
      <tr>
        <td width="17%">
          Отчетный год <xsl:text>&#60;</xsl:text>*<xsl:text>&#62;</xsl:text>:
        </td>
        <td width="15%">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="//ВыпОперРас/@Год"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
    </table>
    
    <table>
      <tr>
        <td width="15%" style="padding-top:2mm">
          Период <xsl:text>&#60;</xsl:text>**<xsl:text>&#62;</xsl:text>:
        </td>
        <td width="35%" style="padding-top:2mm">
          с <xsl:text>&#60;</xsl:text>
          <xsl:call-template name="formatData">
            <xsl:with-param name="input" select="@ДатаНач"/>
          </xsl:call-template>
          <xsl:text>&#62;</xsl:text> по <xsl:text>&#60;</xsl:text>
          <xsl:call-template name="formatData">
            <xsl:with-param name="input" select="@ДатаКон"/>
          </xsl:call-template>
          <xsl:text>&#62;</xsl:text>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
      <tr>
        <td style="padding-top:2mm">
          Период <xsl:text>&#60;</xsl:text>***<xsl:text>&#62;</xsl:text>:
        </td>
        <td style="padding-top:2mm">
          на <xsl:text>&#60;</xsl:text>
          <xsl:call-template name="formatData">
            <xsl:with-param name="input" select="//СпрРасБюд/@НаДату"/>
          </xsl:call-template>
          <xsl:text>&#62;</xsl:text>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
      <tr>
        <td style="padding-top:2mm">
          Период <xsl:text>&#60;</xsl:text>****<xsl:text>&#62;</xsl:text>:
        </td>
        <td style="padding-top:2mm">
          год <xsl:text>&#60;</xsl:text>
          <xsl:call-template name="formatYear">
            <xsl:with-param name="input" select="//АктСвер/@Год"/>
          </xsl:call-template>
          <xsl:text>&#62;</xsl:text> на <xsl:text>&#60;</xsl:text>
          <xsl:call-template name="formatData">
            <xsl:with-param name="input" select="//АктСвер/@НаДату"/>
            <xsl:with-param name="year" select="//АктСвер/@Год"/>
          </xsl:call-template>
          <xsl:text>&#62;</xsl:text>
        </td>
        <td>
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
    </table>

    <table style="margin-top:2mm" width="100%">
      <tr>
        <td class="bold" style="text-align:left">
          Дополнительные реквизиты запроса <xsl:text>&#60;</xsl:text>*****<xsl:text>&#62;</xsl:text>:
        </td>
      </tr>
      <tr>
        <td>
          <table width="100%" class="table-with-border">
            <tr>
              <td width="22%" class="bold">
                КБК
              </td>
              <td width="15%" class="bold">
                ОКАТО
              </td>
              <td class="bold">
                Наименование налога (сбора)
              </td>
            </tr>
            <xsl:choose>
              <xsl:when test="СвНалог">
                <xsl:for-each select="СвНалог">
                  <xsl:call-template name="OutStrTable1">
                    <xsl:with-param name="node" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="OutStrTable1">
                  <xsl:with-param name="node" select="."/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="Подписант">
    <table style="margin-top:2mm" width="100%">
      <tr>
        <td class="bold" style="text-align:left" width="70%">
          Запрос представлен уполномоченным представителем налогоплательщика
        </td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@ПрПодп"/>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="bold" style="text-align:left">
          (ДА - 2, НЕТ - 1).
        </td>
      </tr>
      <tr>
        <td class="bold" colspan="3" style="text-align:justify; font-size:6pt">
          <xsl:text>&#60;</xsl:text>*<xsl:text>&#62;</xsl:text> - заполняется в запросе на предоставлении выписки,<br/>
          <xsl:text>&#60;</xsl:text>**<xsl:text>&#62;</xsl:text> - заполняется в запросе на предоставлении перечня,<br/>
          <xsl:text>&#60;</xsl:text>***<xsl:text>&#62;</xsl:text> - заполняется в запросе на предоставлении справки,<br/>
          <xsl:text>&#60;</xsl:text>****<xsl:text>&#62;</xsl:text> - заполняется в запросе на предоставлении акта сверки,<br/>
          <xsl:text>&#60;</xsl:text>*****<xsl:text>&#62;</xsl:text> - обязательны для запроса на получение Акта совместной сверки расчетов по налогам, сборам, пеням и штрафам (II раздела); для Перечня налоговых деклараций (расчетов) и бухгалтерской отчетности и Справки о состоянии расчетов по налогам, сборам и взносам не заполняются.
        </td>
      </tr>
    </table>

    <table style="margin-top:3mm" width="100%">
      <tr>
        <td class="bold" style="text-align:left" width="45%">
          <table>
            <tr>
              <td style="border-bottom:1pt solid black; text-align:center" width="15%">
                <xsl:value-of select="substring(//Документ/@ДатаДок,1,2)"/>
              </td>
              <td width="2%">
                <xsl:text>&#160;</xsl:text>
              </td>
              <td style="border-bottom:1pt solid black; text-align:center" width="45%">
                <xsl:call-template name="ДатаДок"/>
              </td>
              <td style="text-align:right" width="7%">
                20
              </td>
              <td style="border-bottom:1pt solid black; text-align:center" width="8%">
                <xsl:value-of select="substring(//Документ/@ДатаДок,9,2)"/>
              </td>
              <td style="text-align:left; padding-left:1mm">
                г.
              </td>
            </tr>
          </table>
        </td>
        <td>
          <table>
            <tr>
              <td width="25%" class="bold" style="text-align:left">
                Руководитель:
              </td>
              <td width="2%">
                <xsl:text>&#160;</xsl:text>
              </td>
              <td width="35%" style="border-bottom:1pt solid black">
                <xsl:text>&#160;</xsl:text>
              </td>
              <td width="1%">
                /
              </td>
              <td style="border-bottom:1pt solid black; text-align:center">
                <xsl:value-of select="concat(ФИО/@Фамилия,' ',substring(ФИО/@Имя,1,1), '.')"/>
                <xsl:if test="ФИО/@Отчество">
                  <xsl:value-of select="concat(' ',substring(ФИО/@Отчество,1,1), '.')"/>
                </xsl:if>
                </td>
              <td width="1%">
                /
              </td>
            </tr>
            <tr>
              <td colspan="6" class="bold" style="text-align:left">
                организации (ИП, физическое лицо, уполномоченный<br/>представитель)
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutStrTable1">
    <xsl:param name="node"/>
    <tr>
      <td style="vertical-align:middle">
        <xsl:value-of select="$node/@КБК"/>
        <xsl:text>&#160;</xsl:text>
      </td>
      <td style="vertical-align:middle">
        <xsl:value-of select="$node/@ОКАТО"/>
      </td>
      <td style="text-align:left">
        <xsl:call-template name="NameFromQualifier">
          <xsl:with-param name="Qualifier">KBK182</xsl:with-param>
          <xsl:with-param name="Code" select="concat(substring($node/@КБК,1,13),1,substring($node/@КБК,15,6))"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="formatData">
    <xsl:param name="input"/>
    <xsl:param name="year"/>
    <xsl:choose>
      <xsl:when test="$input">
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,1,2)"/>
        </span>
        <span style="vertical-align:bottom">
          <xsl:text>.</xsl:text>
        </span>
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,4,2)"/>
        </span>
        <span style="vertical-align:bottom">
          <xsl:text>.</xsl:text>
        </span>
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,7,4)"/>
          <xsl:value-of select="$year"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        __.__.____
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="formatYear">
    <xsl:param name="input"/>
    <xsl:choose>
      <xsl:when test="$input">
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,1,1)"/>
        </span>
        <span style="vertical-align:bottom">
          <xsl:text>.</xsl:text>
        </span>
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,2,1)"/>
        </span>
        <span style="vertical-align:bottom">
          <xsl:text>.</xsl:text>
        </span>
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,3,1)"/>
        </span>
        <span style="vertical-align:bottom">
          <xsl:text>.</xsl:text>
        </span>
        <span style="text-decoration: underline">
          <xsl:value-of select="substring($input,4,1)"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        _._._._
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="СвНП/АдрРФ">
    <table>
      <tr>
        <td style="border:0; text-align:left">
          <span class="bold">
            Адрес местонахождения ЮЛ, место регистрации ИП, физического лица:<br/>
          </span>
          <span class="podpis">
            (Индекс, код региона, район, город, населенный пункт, улица, дом, корпус, кв.)
          </span>
        </td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@Индекс"/>
            <xsl:with-param name="size" select="6"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td colspan="2" style="border-bottom:1pt solid black">
          <xsl:value-of select="concat(@КодРегион,', ', @Район, ', ', @Город, ', ', @НаселПункт, ', ', @Улица, ', ', @Дом, ', ', @Корпус, ', ', @Кварт)"/>
        </td>
      </tr>
      <tr>
        <td colspan="2" style="border-bottom:1pt solid black">
          <xsl:text>&#160;</xsl:text>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="СвОтпр/СвОтпрФЛ/ФИО|СвНП/НПФЛ/ФИО" mode="inLine">
    <xsl:value-of select="@Фамилия"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Имя"/>
    <xsl:if test="@Отчество">
      <xsl:text>&#160;</xsl:text>
    </xsl:if>
    <xsl:value-of select="@Отчество"/>
  </xsl:template>

  <!--Выводит дату отчета (месяц) прописью-->
  <xsl:template name="ДатаДок">
    <xsl:variable name="month" select="substring(//Документ/@ДатаДок,4,2)"/>
    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>января</xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>февраля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>марта</xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>апреля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>мая</xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>июня</xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>июля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>августа</xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>сентября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>октября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>ноября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>декабря</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
    
</xsl:stylesheet>