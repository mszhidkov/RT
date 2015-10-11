<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="no_format.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--���������� ���, ���, ���� ���������-->
  <xsl:variable name="Kpp" select="����/��������/����/����/@���"/>
  <xsl:variable name="Inn">
    <xsl:value-of select="����/��������/����/����/@�����"/>
    <xsl:value-of select="����/��������/����/����/@�����"/>
  </xsl:variable>
  <xsl:variable name="docDate" select="����/��������/@�������"/>

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

  <xsl:template match="��������">
    <!--��������� ���������� �� ������� ��������������������� ������ (���������� � 1 � ������� ������� �� �� 22.06.2009 � 57�)-->
    <!--��� 1151059-->
    <!--NO_ESHN-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="����"/>

  </xsl:template>

  <!--��������-->

  <!-- ���� 1-->
  <xsl:template name="titlePage">
    <table id="printFormPage1" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table style="height: 100%">
            <xsl:call-template name="titlePageHeader"/>

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h1>
                  ��������� ���������� �� ������� ��������������������� ������
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
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--��������� ������ (���)-->
                    <td class="text-center">��������� ������ (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="2"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--�������� ���-->
                    <td class="text-center">�������� ���</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@��������"/>
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
                    <!--��������� ����� (���)-->
                    <td class="text-center">�������������� � ��������� ����� (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="4"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                    <!--�� ����� ���������� (�����) (���)-->
                    <td class="text-center">�� ����� ���������� (�����) (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�������"/>
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
                    <xsl:value-of select="����/����/@�������"/>
                    <xsl:apply-templates select="����/����/���" mode="one_line"/>
                  </xsl:with-param>
                  <xsl:with-param name="size" select="40"/>
                  <xsl:with-param name="line" select="4"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
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
                    <!--����� �������-->
                    <td class="text-right">��</td>
                    <td class="text-center">
                      <table>
                        <tr>
                          <td>
                            <xsl:call-template name="breakStr">
                              <xsl:with-param name="input" select="2+count(����/������������)"/>
                              <xsl:with-param name="size" select="3"/>
                              <xsl:with-param name="symbol">-</xsl:with-param>
                            </xsl:call-template>
                          </td>
                        </tr>
                      </table>
                    </td>
                    <td  class="text-left">���������</td>
                    <!--����� ����������-->
                    <td class="text-right">� ����������� �������������� ���������� ��� �� ����� ��</td>
                    <td>
                      <xsl:call-template name="noFotmat"/>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="''"/>
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
                <table style="height: 100%;">
                  <tr>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="���������"/>
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

  <!-- ********************** ���� 2 *************************** -->
  <xsl:template match="����">

    <!--������ 1. ����� ������� ��������������������� ������, ���������� ������,�� ������ �����������������-->
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
                ������ 1. ����� ������� ��������������������� ������, ���������� ������,<br/>�� ������ �����������������
              </td>
            </tr>
            <tr>
              <td class="podpis text-right">
                (� ������)
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="40%">����������</td>
                    <td width="7%">
                      ���<br/>������
                    </td>
                    <td width="53%">�������� �����������</td>
                  </tr>
                  <tr>
                    <td>��� ��������� �������������</td>
                    <td class="text-center">001</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="size" select="20"/>
                        <xsl:with-param name="input" select="@���"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>��� �� �����</td>
                    <td class="text-center">002</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="input" select="@�����"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ���������� ������� �� �������<br/>��������������������� ������, ����������� �<br/>������ �� ������ ��������� �������
                    </td>
                    <td class="text-center">003</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@����"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ������� ��������������������� ������,<br/>���������� ������ �� ������ ���������� �������<br/><span class="podpis">(���. 050 ����. 2 - ���. 003, ���� ���. 050 ����. 2 > ���. 003)</span>
                    </td>
                    <td class="text-center">004</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="@�����>=0">
                            <xsl:value-of select="@�����"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ������� ��������������������� ������ �<br/>���������� �� ��������� ������<br/><span class="podpis">(���. 003 - ���. 050 ����. 2, ���� ���. 050 ����. 2 &lt; ���. 003)</span>
                    </td>
                    <td class="text-center">005</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@�����>=0)">
                            <xsl:value-of select="substring-after(@�����,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!--������ 2-->
            <xsl:apply-templates select="�������"/>

          </table>
        </td>
      </tr>
      <xsl:call-template name="�������������������"/>
    </table>

    <!--������ 2.1.-->
    <xsl:apply-templates select="������������"/>

  </xsl:template>

  <!--������ 2. ������ ������� ��������������������� ������-->
  <xsl:template match="�������">

    <tr>
      <td class="bold text-center">
        ������ 2. ������ ������� ��������������������� ������
      </td>
    </tr>
    <tr>
      <td class="podpis text-right">
        (� ������)
      </td>
    </tr>
    <tr>
      <td>
        <table>
          <tr class="text-center italic">
            <td width="50%">����������</td>
            <td width="10%">
              ���<br/>������
            </td>
            <td width="40%">�������� �����������</td>
          </tr>
          <tr>
            <td>
              ����� ������� �� ��������� ������, �����������<br/>��� ����������� ��������� ���� �� �������<br/>��������������������� ������
            </td>
            <td class="text-center">010</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@��������"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� �������� �� ��������� ������,<br/>����������� ��� ����������� ��������� ���� ��<br/>������� ��������������������� ������
            </td>
            <td class="text-center">020</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@���������"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ��������� ���� �� ������� ���������������������<br/>������ �� ��������� ������<br/><span class="podpis">(���. 010 - ���. 020, ���� ���. 010 > ���. 020)</span>
            </td>
            <td class="text-center">030</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@�������"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� ������, ����������� � ����������<br/>(����������) ��������� (���������) �������<br/>(��������), ����������� ��������� ���� ��<br/>��������� ������
            </td>
            <td class="text-center">040</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@�����������"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� ������� ��������������������� ������,<br/>������������ �� ��������� ������<br/><span class="podpis">((���. 030 - ���. 040) � 6 / 100)</span>
            </td>
            <td class="text-center">050</td>
            <td>
              <xsl:call-template name="breakStrNum10">
                <xsl:with-param name="input" select="@������������"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </td>
    </tr>

  </xsl:template>

  <!-- ********************** ���� 3 *************************** -->

  <!--������ 2.1. ������ ����� ������, ����������� ��������� ������ ������� ��������������������� ������ �� ��������� ������-->
  <xsl:template match="������������">
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
                ������ 2.1. ������ ����� ������, ����������� ��������� ����<br/>�� ������� ��������������������� ������ �� ��������� ������
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td colspan="3">����������</td>
                    <td>
                      ���<br/>������
                    </td>
                    <td>�������� �����������</td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      ����� �������, ���������� �� ������ ���������� ��������� ��������,<br/>������� �� ���� ���������� �� ������ ��������� ���������� �������, - �����<br/>
                      <span class="podpis">(����� ����� 020 - 110)</span>
                    </td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="��������/@����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td width="14%"></td>
                    <td width="12%">
                      � ��� ����� ��:
                    </td>
                    <td width="34%"></td>
                    <td width="7%"></td>
                    <td width="23%"></td>
                  </tr>
                  <xsl:apply-templates select="��������/�����������">
                    <xsl:with-param name="startPos" select="1"/>
                  </xsl:apply-templates>
                  <tr>
                    <td colspan="3">
                      ����� ������ �� �������� ��������� ������
                      <span class="podpis">(���. 020 ����. 2 - ���. 010 ����. 2, ���� ���. 010 ����. 2 &gt; ���. 020 ����. 2)</span>
                    </td>
                    <td class="text-center">120</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      ����� ������� �� ������ ���������� ���������� �������, �������<br/>���������������� ������ ��������� �� ������� ��������� �������, �����:
                      <span class="podpis">(���. 010 - ���. 040 ����. 2 + ���. 120)</span>
                    </td>
                    <td class="text-center">130</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="��������/@����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <xsl:apply-templates select="��������/�����������">
                    <xsl:with-param name="startPos" select="13"/>
                  </xsl:apply-templates>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="�������������������"/>
    </table>

  </xsl:template>

  <xsl:template match="�����������|�����������">
    <xsl:param name="startPos"/>
    <tr>
      <td></td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�������"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>���</td>
      <td class="text-center">
        <xsl:value-of select="format-number((position()+$startPos)*10,'000')"/>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�������"/>
        </xsl:call-template>
      </td>
    </tr>

  </xsl:template>

  <!--����� �������-->
  <!--��������� ��� ������ ��������-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageNum"></xsl:param>
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
                  <xsl:with-param name="input" select="$Inn"/>
                  <xsl:with-param name="size" select="12"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <table style="margin-top: 2mm; width: auto;">
            <tr>
              <td class="nowrap" style="width: 10mm;">���</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$Kpp"/>
                  <xsl:with-param name="size" select="9"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">���.</td>

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

  <!--��������� ��� ������ ��������-->
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
            <!--���������� � 1-->
            <td class="podpis text-right" width="280" style="padding-top: 4mm; padding-bottom: 0;">
              ���������� � 1 � ������� ������� �� �� 22.06.2009 � 57�
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

  <!--�������������������-->
  <xsl:template name="�������������������">
    <tr>
      <td class="footer" >
        <table>
          <tr>
            <td class="text-center bold" style="font-size: 8pt">������������� � ������� ��������, ��������� �� ������ ��������, �����������:</td>
          </tr>
          <tr>
            <td class="text-center">
              <table>
                <tr>
                  <td style="width: 10%">&#160;</td>
                  <td class="border-bottom" style="width: 15%">&#160;</td>
                  <td class="explanation" style="width: 5%">&#160;(�������)</td>
                  <td style="width: 40%">&#160;</td>
                  <td class="border-bottom text-center" style="width: 15%">
                    <xsl:value-of select="$docDate"/>
                  </td>
                  <td class="explanation" style="width: 5%">&#160;(����)</td>
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

  <xsl:template match="���������">
    <table>
      <!--���������-->
      <tr>
        <td class="text-center bold">
          ������������� � ������� ��������, ���������<br/>� ��������� ����������, �����������:
        </td>
      </tr>
      <!--�������-->
      <tr>
        <td >
          <table>
            <tr>
              <td width="50mm">&#160;</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@������"/>
                  <xsl:with-param name="size" select="1"/>
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                1 - ����������������,<br/>2 - ������������� �����������������
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--���-->
      <xsl:apply-templates select="���"/>


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
                  <xsl:with-param name="input">
                    <xsl:value-of select="$docDate"/>
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
    <tr>
      <td class="podpis">
        (�������, ���, �������� ���������)
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="���" mode="one_line">
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
                � �����������<br/>�������������� ����������<br/>� (���) �� ����� ��
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
              <td class="text-right">
                ���� �������������<br/>����������
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
    <table class="vertical-align-bottom margin-top10mm">
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




  <!-- �������� ������� -->
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
  <!--���� ������� ����������, � ����������� "-", ������ 12 -->
  <xsl:template name="breakStrNum12">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"></xsl:param>

    <xsl:call-template name="breakStr">
      <!--���� �������� 0, �� ������ ������ ��������-->
      <xsl:with-param name="input">
        <xsl:if test="not($input=0)" >
          <xsl:value-of select="$input"/>
        </xsl:if>
        <xsl:if test="$input=0" >
          <xsl:value-of select="''"/>
        </xsl:if>
      </xsl:with-param>

      <!--���� �� ������ ������ - ������ ������ 12-->
      <xsl:with-param name="size">
        <xsl:if test="$size=''">
          <xsl:value-of select="12"/>
        </xsl:if>
        <xsl:if test="$size!=''">
          <xsl:value-of select="$size"/>
        </xsl:if>
      </xsl:with-param>

      <!--����������� �����������-->
      <xsl:with-param name="symbol">-</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--���� ������� ����������, ����������� "-", ������ 10 -->
  <xsl:template name="breakStrNum10">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size">10</xsl:param>

    <xsl:call-template name="breakStr">
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="size" select="$size"/>
      <xsl:with-param name="nullIsPrinted" select="false"/>
    </xsl:call-template>
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

</xsl:stylesheet>