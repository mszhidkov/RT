<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="Qualifier.xsl"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--���������� ��� ���������-->
  <xsl:variable name="KodNalogInsp" select="substring(����/@������,16,4)"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!-- href="style.css" -->


    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="��������">
    <!--�������� � ��������������� ����������� ���������� �� �������������� ����������� ��� (���������� � ������� ��� �� �� 29.03.2007 � ��-3-25/174@)-->
    <!--��� 1110018-->
    <!--NO_SRCHIS-->

    <xsl:call-template name="titlePage"/>

  </xsl:template>



  <!--��������-->

  <!--���.1_����01-->
  <xsl:template name="titlePage">
    <table class="page page-margin-narrow border-all">
      <tr>
        <td class="page-content">
          <table>

            <xsl:call-template name="titlePageHeader"/>

            <!--���������-->
            <tr>
              <td class="bold text-center padding-top10mm">
                ��������<br/>� ��������������� ����������� ����������<br/>�� �������������� ����������� ���
              </td>
            </tr>
            <tr>
              <td class="padding-top10mm">
                <table>
                  <tr>
                    <td width="16%" class="bold">�������������� �</td>
                    <td width="64%" class="border-bottom">
                      <xsl:call-template name="NameFromQualifier">
                        <xsl:with-param name="Qualifier">TaxAuthorities</xsl:with-param>
                        <xsl:with-param name="Code" select="$KodNalogInsp"/>
                      </xsl:call-template>
                    </td>
                    <td width="8%" class="text-center">���</td>
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
                    <td class="podpis">(������������ ���������� ������)</td>
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
                      <xsl:value-of select="����/����/@�������"/>
                      <xsl:apply-templates select="����/����/�����"/>
                    </td>
                    <td width="1%"></td>
                  </tr>
                  <tr>
                    <td class="podpis" colspan="3">
                      (������ ������������ �����������/ �������, ���, �������� ��������������� ���������������)
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
                    <td width="50%">��������������� ����������� �� ��������� ��</td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="����������/@��������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td>
                      <sup>(�����, �����, ���)*</sup>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table style="width:auto">
                  <tr>
                    <td>����������</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <!-- �������� ��������� ����� �� ������ � 6 �������� -->
                          <xsl:value-of select="substring('      ', 1, 6-string-length(����������/@������))"/>
                          <xsl:value-of select="����������/@������"/>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="6"/>
                        <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <td>�������</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td class="podpis padding-top10mm">
                <span class="text-left">
                  *� ������ ������������� �������� � ��������������� ����������� ���������� �� �������������� ����������� ��� ���������� ���� - 1 ������ �������� ����, � � ������ �������� (�������������) ����������� ���������� ������ ����� ������, ���������� �� �������, � ������� ����������� ���� ������� (��������������).
                </span>
              </td>
            </tr>

            <tr>
              <td class="padding-top10mm">
                <table style="height: 100%;">
                  <tr>
                    <td class="border-top border-right" width ="50%" style="vertical-align: top">
                      <xsl:call-template name="���������"/>
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

  <!--����� �������-->
  <!--��������� ��� ������ ��������-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <table>
      <tr>
        <!--�����-���-->
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

        <!--���,���,��������-->
        <td>
          <table style="margin-top: 2mm;">
            <tr>
              <td class="nowrap" style="width: 10mm;">���</td>
              <td>

                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input">
                    <xsl:value-of select="����/����/@�����"/>
                    <xsl:value-of select="����/����/@�����"/>
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
              <td class="nowrap" style="width: 10mm;">���</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����/����/@���"/>
                  <xsl:with-param name="size" select="9"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                  <xsl:with-param name="classBorder">border-solid</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">���.</td>

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

  <!--��������� ��� ������ ��������-->
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
            <!--���������� � 1-->
            <td width="200" class="explanation">
              ����������<br/>� ������� ��� ��<br/>�� 29.03.2007 � ��-3-25/174@
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right bold">
        ����� �� ��� <xsl:value-of select="�����������/@���"/>
      </td>
    </tr>
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

  <xsl:template name="���������">
    <table>
      <!--���������-->
      <tr>
        <td class="bold">
          ������������� � ������� �������������� �������� �����������:<br/>��� �����������
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td width="30%">
                ������������
              </td>
              <td class="border-bottom">
                <xsl:apply-templates select="����/����/��������"/>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="podpis">
                (�������, ���, �������� (���������))
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <!--�������, ����-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>�������&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;����</td>
              <td style='width: 50%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:if test="����/����/��������">
                      <xsl:value-of select="�����������/@�������"/>
                    </xsl:if>
                  </xsl:with-param>
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

      <tr>
        <td class="bold">
          ��� ��������������� ���������������
        </td>
      </tr>

      <!--�������, ����-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>�������&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;����</td>
              <td style='width: 50%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:if test="not(����/����/��������)">
                      <xsl:value-of select="�����������/@�������"/>
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
          �������������
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td class="border-bottom">
                <xsl:apply-templates select="����/����/������/�������"/>
                <xsl:apply-templates select="����/����/������/�������"/>
                <xsl:value-of select="����/����/������/�����������"/>
                <xsl:value-of select="����/����/������/�����������"/>
                &#160;
              </td>
            </tr>
            <tr>
              <td class="podpis">
                (������ ������������ �����������/(�������, ���, ��������))
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <!--�������, ����-->
      <tr>
        <td>
          <table>
            <tr>
              <td style='width: 15%'>�������&#160;</td>
              <td class='field_text' style='width: 20%'>&#160;</td>
              <td style='width: 10%'>&#160;����</td>
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
              <td class="text-center">�.�.</td>
              <td></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>

      <!--������������ ���������, ��������������� ���������� ������������-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="border-bottom">
                <xsl:value-of select="����/����/������/@�����������"/>
                <xsl:value-of select="����/����/������/@�����������"/>
              </td>
            </tr>
            <tr>
              <td class="podpis">
                (������������ ���������, ��������������� ���������� �������������,<br/>����� �����������)
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="�����|��������|�������">
    <xsl:value-of select="@�������"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@���"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@��������"/>
  </xsl:template>

  <xsl:template name="TaxWorker">
    <table>
      <!--���������-->
      <tr>
        <td class="bold">
          ����������� ���������� ���������� ������
        </td>
      </tr>


      <!--����-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                ���� �������������
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
      <!--��������������� �����-->
      <tr>
        <td>
          <table>
            <tr>
              <td class="text-right">
                ���������������� �� �
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

    <!--�������-->
    <table style="vertical-align: bottom" class="margin-top10mm">
      <tr>
        <td class="field_text"></td>
        <td>&#160;</td>
        <td class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">(�������, �.�.)</td>
        <td>&#160;</td>
        <td class="podpis">(�������)</td>
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