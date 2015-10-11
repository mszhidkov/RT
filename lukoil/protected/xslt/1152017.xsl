<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:import href="no_format.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <xsl:variable name="INN">
    <xsl:value-of select="����/��������/����/����/@�����"/>
    <xsl:value-of select="����/��������/����/����/@�����"/>
  </xsl:variable>
  <xsl:variable name="KPP" select="����/��������/����/����/@���"/>
  <xsl:variable name="docDate" select="����/��������/@�������"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="��������">
    <!--��������� ���������� �� ������, ������������� � ����� � ����������� ���������� ������� ��������������� NO_USN-->
    <!--��� 1152017-->
    <!--NO_USN-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="���"/>

  </xsl:template>

  <xsl:template match="���">
    <!--������ 1. ����� ������ �� ����������� ���������, ���������� ������ � ������� ��������� �������, ��������������� �� ���������� ���������� ���������� ���������� ���������� - ������ ����������� �����-->
    <xsl:call-template name="Section1"/>
    <!--������ 2. ����� ������, ���������� ������ � ������ � ��������� ����������� �������,��������������� �� ���������� ���������� ��������� � ���������� ���������� -������ ����������� �����-->
    <xsl:apply-templates select="�������1|����������2"/>
  </xsl:template>

  <!--��������-->

  <!--��������� ����-->
  <xsl:template name="titlePage">
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader"/>

            <!--���������-->
            <tr>
              <th>
                <h1 class="padding-top5mm">
                  ��������� ���������� �� ������, �������������<br/>� ����� � ����������� ���������� ������� ���������������
                </h1>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <!--����� �������������-->
                    <td class="text-left">����� �������������</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�������"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <!--��������� (��������) ������ (���)-->
                    <td class="text-center">��������� (��������) ������ (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <!--�������� ���-->
                    <td class="text-center">�������� ���</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@��������"/>
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
                    <!--��������� ����� (���)-->
                    <td class="text-center">�������������� � ��������� ����� (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <!--�� ����� ���������� (�����) (���)-->
                    <td class="text-center">�� ����� ���������� (�����) (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�������"/>
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
                    <xsl:value-of select="����/����/@�������"/>
                    <xsl:apply-templates select="����/����/���" mode="inLine"/>
                  </xsl:with-param>
                  <xsl:with-param name="size" select="40"/>
                  <xsl:with-param name="line" select="4"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="podpis">(����������������)</td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <!--��� ���� ������������� ������������ �� �������������� �����-->
                    <td class="text-center">��� ���� ������������� ������������ �� �������������� �����</td>
                    <td class="text-left">
                      <xsl:call-template name="breakOKVED">
                        <xsl:with-param name="input" select="����/@�����"/>
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
                    <!--����� ����������� ��������-->
                    <td class="text-center">����� ����������� ��������</td>
                    <td class="text-left">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/@���"/>
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
                    <!--����� �������-->
                    <td class="text-right">��</td>
                    <td class="text-center">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="3"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <td  class="text-left">���������</td>

                    <!--����� ����������-->
                    <td class="text-right">� ����������� �������������� ���������� ��� �� ����� ��</td>
                    <td class="text-center">
                      
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input"/>                        
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template> 
                      
                    </td>
                    <td class="text-left">������</td>
                  </tr>

                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table style="height: 100%; margin-top: 5mm;">
                  <tr>
                    <td style="border: 1pt double black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="���������"/>
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

  <!--������ 1-->
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

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 1. ����� ������, ������������� � ����� � ����������� ���������� ������� ���������������,<br/>� ������������ ������, ���������� ������ � ������,<br/>�� ������ �����������������
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-right italic">(� ������)</td>
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

  <!--������ 2-->
  <xsl:template match="�������1|����������2/�������2">

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

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 2. ������ ������, ������������� � ����� � ����������� ���������� ������� ���������������,<br/>
                  � ������������ ������
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-right italic">(� ������)</td>
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

  <!--��������� ����� ������� 1-->
  <xsl:template name="section1Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table1Hat"/>

      <tr>
        <td>
          ������ ���������������<br/><span class="explanation">
            1 - ������<br/>2 - ������, ����������� �� �������� ��������
          </span>
        </td>
        <td class="text-center">001</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����"/>
            <xsl:with-param name="size" select="1"/>
          </xsl:call-template>
        </td>
      </tr>
      <xsl:apply-templates select="@�����">
        <xsl:with-param name="strNum">010</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@���">
        <xsl:with-param name="strNum">020</xsl:with-param>
      </xsl:apply-templates>
      <tr>
        <td>
          ����� ���������� ������� �� ������, ����������� �<br/>������ ��:
        </td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          ������ �������
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          ���������
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="padding-left: 5mm">
          ������ �������
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����9�"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������, ���������� ������ �� ��������� ������<br/>
          <span style="font-size: 6 pt;">
            ��� ���. 001 = "1": ���. 260 - ���. 280 - ���. 050, ���� ���. 260 - ���. 280 - ���. 050 >= 0<br/>
            ��� ���. 001 = "2": ���. 260 - ���. 050, ���� ���. 260 >= ���. 050 � ���. 260 >= ���. 270
          </span>
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:if test="@�����>0">
                <xsl:value-of  select="@�����"/>
              </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������ � ���������� �� ��������� ������<br/>
          <span style="font-size: 6 pt;">
            ��� ���. 001 = "1": ���. 050 - (���. 260 - ���. 280), ���� ���. 260 - ���. 280 - ���. 050 &lt; 0<br/>
            ��� ���. 001 = "2": ���. 050 - ���. 260, ���� ���. 050 > ���. 260 � ���. 270 &lt;= ���. 260<br/>
            <span class="text-right">��� ���. 050, ���� ���. 260 &lt; ���. 270	</span>
          </span>
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after(@�����,'-')"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>��� ��������� �������������</td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test="����������2/������/@���">
                  <xsl:value-of select="����������2/������/@���"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@���"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param> 
            <xsl:with-param name="size" select="20"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������, ���������� ������ ��<br/>��������� ������<br/>
          <span class="explanation">��� ���. 001 = "2": ���. 270, ���� ���. 270 > ���. 260</span>
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������2/������/@��������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--��������� ����� ������� 2-->
  <xsl:template name="section2Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table2Hat"/>
      <tr>
        <td>
          ������ ������ (%)
        </td>
        <td class="text-center">201</td>
        <td>
          <xsl:call-template name="breakTaxRate">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ���������� ������� �� ��������� ������
        </td>
        <td class="text-center">210</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������� �������� �� ��������� ������<br/><span class="explanation">��� ���. 001 = "2"</span>
        </td>
        <td class="text-center">220</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������, ����������� � ���������� (����������) ��������� (���������)<br/>������� (��������), ����������� ��������� ���� �� ��������� ������<br/>
          <span class="explanation">��� ���. 001 = "2"</span>
        </td>
        <td class="text-center">230</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ��������� ���� ��� ���������� ������ �� ��������� ������<br/>
          <span class="explanation">
            ��� ���. 001 = "1": ����� ���. 210<br/>
            ��� ���. 001 = "2": ���. 210 - ���. 220 - ���. 230, ���� ���. 210 - ���. 220 - ���. 230 > 0
          </span>
        </td>
        <td class="text-center">240</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�������|@�����������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������, ����������� �� ��������� ������<br/>
          <span class="explanation">��� ���. 001 = "2": ���. 220 - ���. 210, ���� ���. 210 &lt; ���. 220</span>
        </td>
        <td class="text-center">250</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after(@�����������,'-')"/>
            <xsl:with-param name="size" select="8"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������ �� ��������� ������<br/>
          <span class="explanation">(���. 240 � ���. 201 / 100)</span>
        </td>
        <td class="text-center">260</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������������ ������ �� ��������� ������ (������ ������ 1%)<br/>
          <span class="explanation">��� ���. 001 = "2": ���. 210 � 1 / 100</span>
        </td>
        <td class="text-center">270</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@���������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ���������� �� ��������� ������ ��������� ������� �� ������������<br/>
          ���������� �����������, ������������ ���������� ����������� �� ������ ���������<br/>
          ������������������ � � ����� � ������������, ������������ �����������<br/>
          �����������, ������������ ���������� ����������� �� ���������� ������� ��<br/>
          ������������ � ���������������� �����������, � ����� ����������� ���������� �<br/>
          ������� ���������� ������� �� ������� ����������������� ������� �� ���������<br/>
          ������������������, ����������� (�� �� ����� ��� �� 50%) ����� ������������ ������<br/>
          <span class="explanation">��� ���. 001 = "1"</span>
        </td>
        <td class="text-center">280</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�������"/>
            <xsl:with-param name="size" select="8"/>
            <xsl:with-param name="nullIsPrinted" select="false()"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>

  </xsl:template>

  <!--����� ������� ��� ������� 1-->
  <xsl:template name="table1Hat">
    <tr>
      <td class="text-center italic" style="width: 50%">����������</td>
      <td class="text-center italic" style="width: 5%">��� ������</td>
      <td class="text-center italic" style="width: 45%">�������� �����������</td>
    </tr>
  </xsl:template>

  <!--����� ������� ��� ������� 2-->
  <xsl:template name="table2Hat">
    <tr>
      <td class="text-center italic" style="width: 73%">����������</td>
      <td class="text-center italic" style="width: 5%">��� ������</td>
      <td class="text-center italic" style="width: 22%">�������� �����������</td>
    </tr>
  </xsl:template>

  <!--������ ��� �������� 1, 2-->
  <xsl:template name="sectionFeuilleton">
    <tr>
      <td class="footer">
        <table>
          <tr>
            <td class="text-center bold" style="font-size: 8pt">������������� � ������� ��������, ��������� �� ������ ��������, �����������:</td>
          </tr>
          <tr>
            <td class="text_center">
              <table>
                <tr>
                  <td style="width: 25%">&#160;</td>
                  <td class="field_text" style="width: 15%">&#160;</td>
                  <td class="explanation" style="width: 5%">&#160;(�������)</td>
                  <td style="width: 10%">&#160;</td>
                  <td class="border-bottom" style="width: 15%">
                    <xsl:value-of select="$docDate"/>
                  </td>
                  <td class="explanation" style="width: 5%">&#160;(����)</td>
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

  <!--����� �������-->
  <!--��������� ��� ������ ��������-->
  <xsl:template name="pageHeader">
    <xsl:param name="pageNumber"/>
    <xsl:param name="barCode"></xsl:param>
    <table>
      <tr>
        <!--�����-���-->
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

        <!--���,���,��������-->
        <td>
          <xsl:call-template name="INN_KPP_Page">
            <xsl:with-param name="pageNumber" select="$pageNumber"/>
          </xsl:call-template>
        </td>

      </tr>
    </table>
  </xsl:template>

  <!--��������� ��� ������ ��������-->
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
            <!--���������� � 1-->
            <td class="text-right vertical-align-top" style="font-size: 6pt; width: 85mm; padding-top: 8mm; padding-right: 0mm; padding-bottom: 0;">
              ���������� � 1 � ������� ������� ���������� ��������� �� 22.06.2009 � 58�<br/>
              (� ���. ������� ��� ������ �� 21.07.2011 � ���-7-6/458@)
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right">
        <b>
          ����� �� ��� <xsl:value-of select="@���"/>
        </b>
      </td>
    </tr>
  </xsl:template>

  <!--��� ������ ���, ���, ��������-->
  <xsl:template name="INN_KPP_Page">
    <xsl:param name="pageNumber"/>
    <table style="margin-top: 2mm; width: auto">
      <tr>
        <td class="nowrap" style="width: 10mm;">���</td>
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
        <td class="nowrap" style="width: 10mm;">���</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$KPP"/>
            <xsl:with-param name="size" select="9"/>
            <xsl:with-param name="symbol"> </xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">���.</td>
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

  <!--����� ��������� �������� �� ���������� � ����������-->
  <xsl:template match="���������">
    <table>
      <!--���������-->
      <tr>
        <td class="text-center">
          <b>
            ������������� � ������� ��������, ���������<br/>� ��������� ����������, �����������:
          </b>
        </td>
      </tr>
      <!--�������-->
      <tr>
        <td class="text-center">
          <table>
            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@������"/>
                  <xsl:with-param name="size" select="1"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left explanation">
                1 - ����������������,<br/>2 - ������������� �����������������
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--���-->
      <xsl:apply-templates select="���"/>
      <tr>
        <td class="podpis">
          (�������, ���, �������� ���������)
        </td>
      </tr>

      <!--������������ ����������� - ������������� �����������������-->
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������/@�������"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="line">8</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="podpis">
          (������������ ����������� - ������������� �����������������)
        </td>
      </tr>
      <!--�������, ����-->
      <tr>
        <td>
          <table style='margin-top: 10mm;'>
            <tr>
              <td style='width: 15%'>�������&#160;</td>
              <td class='field_text' style='width: 30%'>&#160;</td>
              <td style='width: 10%'>&#160;����</td>
              <td style='width: 40%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input" select="$docDate"/>
                  <xsl:with-param name="size" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-center">�.�.</td>
              <td></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>
      <!--������������ ���������, ��������������� ���������� ������������-->
      <tr>
        <td class="text-center">
          ������������ ���������,<br/>��������������� ���������� �������������
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������/@�������"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="line">2</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--����� ��������� ��������, ����������� ��������� �������-->
  <xsl:template name="TaxWorker">
    <table>
      <!--���������-->
      <tr>
        <td class="text-center">
          <b>����������� ���������� ���������� ������</b><br/>�������� � ������������� ����������
        </td>
      </tr>
      <!--���-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-center">
                ������ ���������� ������������ (���)
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
      <!--���������� �������-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                ��
              </td>
              <td class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                ���������
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--���������� ����������-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                � �����������<br/>��������������<br/>���������� ��� �� �����<br/>��
              </td>
              <td class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                ������
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--����-->
      <tr>
        <td>
          <table>
            <tr>
              <td>
                ���� �������������<br/>����������
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
      <!--��������������� �����-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-center">
                ����������������<br/>�� �
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
    <!--�������-->
    <table style="margin-top: 5mm">
      <tr>
        <td class="field_text"></td>
        <td>&#160;</td>
        <td class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">�������, �.�.</td>
        <td>&#160;</td>
        <td class="podpis">�������</td>
      </tr>
    </table>
  </xsl:template>

  <!--������-->
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

  <!--����� ����-->
  <xsl:template match="���">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�������"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@��������"/>
          <xsl:with-param name="size" select="20"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="���" mode="inLine">
    <xsl:value-of select="@�������"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@���"/>
    <xsl:if test="@��������">
      <xsl:text>&#160;</xsl:text>
    </xsl:if>
    <xsl:value-of select="@��������"/>
  </xsl:template>

  <xsl:template match="@�����">
    <xsl:param name="strNum"></xsl:param>
    <tr>
      <td>��� �� �����</td>
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

  <xsl:template match="@���">
    <xsl:param name="strNum"></xsl:param>
    <tr>
      <td>��� ��������� �������������</td>
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

  <!--������� ��� �������� �����-->
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