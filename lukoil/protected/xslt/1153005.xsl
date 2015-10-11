<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt" />
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251" />
  <!--���������� ���, ���, ���� ���������-->
  <xsl:variable name="Kpp" select="����/��������/����/����/@���" />
  <xsl:variable name="Inn">
    <xsl:value-of select="����/��������/����/����/@�����" />
    <xsl:value-of select="����/��������/����/����/@�����" />
  </xsl:variable>
  <xsl:variable name="docDate" select="����/��������/@�������" />
  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!-- href="/kilor/xslt/style.css" -->
    <style>
      .table-compact td
      {
      padding: 0pt;
      }
    </style>

    <!-- ������� ������� ������� -->
    <script type="text/javascript">
      // ������� �������
      var PageNumScript = 0;
      // ������� breakStr - ����� ������� �������
      // id - ���������� ������������� �������� (td)
      // input, size, alignRight, symbol �� �������� � breakStr � xslt
      function breakStr(id, input, size, alignRight, symbol)
      {
      var i = 0;
      var k = 0;
      // �����
      var sHTML = '&lt;table class="field_filled"&gt;&lt;tr&gt;';
      // ��������� � ������, ���� �����
      var StrNum = input.toString();
      // ���� �� size
      while (i &lt; size)
      {
      // ����������� ������ �� ��������� �������
      var smb = symbol;
      if ( (StrNum.length >= size-i &amp;&amp; alignRight) || (StrNum.length > i &amp;&amp; !alignRight))
      {
      smb = StrNum.substring(k, k+1);
      k = k + 1;
      }

      // ������� ��������� ������
      sHTML = sHTML + '&lt;td class="border-dotted"&gt;' + smb + '&lt;/td&gt;';

      i = i + 1;
      }
      // ����� ���������
      var sHTML = sHTML + '&lt;/tr&gt;&lt;/table&gt;';
      //alert(sHTML);
      var element = document.getElementById(id);
      if (element)
      element.innerHTML = sHTML;
      }
    </script>

    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates />
    </div>
  </xsl:template>


  <xsl:template match="����/��������">
    <!--��������� ���������� �� ���������� ������ (�� 16.10.09)-->
    <!--��� 1151001-->
    <!--NO_NDS-->
    <xsl:call-template name="titlePage" />
    <xsl:apply-templates select="��������" />
  </xsl:template>

  <xsl:template match="��������">
    <!--������ 1: ����� ������,���������� ������ � ������ (���������� �� �������),�� ������ �����������������-->
    <xsl:call-template name="Page1" />
    <!--������ 2: -->
    <xsl:apply-templates select="�����" />
    <!-- ���������� ������� ������� -->
    <xsl:call-template name="CountPage" />
  </xsl:template>


  <!--��������-->
  <!--���.1_����01-->
  <xsl:template name="titlePage">
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader" />
            <!--���������-->
            <tr>
              <th class="nowrap">
                <h1>
                  ��������� ���������� �� ���������� ������
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
                        <xsl:with-param name="input" select="@�������" />
                        <xsl:with-param name="size" select="3" />
                      </xsl:call-template>
                    </td>
                    <!--��������� ������ (���)-->
                    <td class="text-center">
                      ��������� ������ <span style="font-size: 8pt">(���)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������" />
                        <xsl:with-param name="size" select="2" />
                      </xsl:call-template>
                    </td>
                    <!--�������� ���-->
                    <td class="text-center">�������� ���</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@��������" />
                        <xsl:with-param name="size" select="4" />
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
                    <td>
                      �������������� � ��������� ����� <span style="font-size: 8pt">(���)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�����" />
                        <xsl:with-param name="size" select="4" />
                      </xsl:call-template>
                    </td>
                    <!--�� ����� ���������� (�����) (���)-->
                    <td class="text-center">
                      �� ����� ���������� (�����) <span style="font-size: 8pt">(���)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�������" />
                        <xsl:with-param name="size" select="3" />
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <!--�������� �����������-->
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input">
                    <xsl:value-of select="����/����/@�������" />
                    <xsl:apply-templates select="����/����/���" mode="one_line" />
                  </xsl:with-param>
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="4" />
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
                        <xsl:with-param name="input" select="����/@�����" />
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
                    <td class="text-right">
                      ����� �������������<br/>(����������) <span style="font-size: 8pt">(���)</span>
                    </td>
                    <td>&#160;</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/����/���������/@���������"/>
                        <xsl:with-param name="size" select="1"/>
                      </xsl:call-template>
                    </td>
                    <td>&#160;&#160;&#160;&#160;&#160;</td>
                    <td class="text-right">
                      ���/��� ����������������<br/>�����������
                    </td>
                    <td>&#160;</td>
                    <td class="text-right">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/����/���������/@�����"/>
                        <xsl:with-param name="size" select="10"/>
                      </xsl:call-template>
                    </td>
                    <td>/</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/����/���������/@���"/>
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
                    <!--����� ����������� ��������-->
                    <td class="text-center">����� ����������� ��������</td>
                    <td class="text-left">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/@���" />
                        <xsl:with-param name="size" select="20" />
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
                    <td width="5%" class="text-">��</td>
                    <td width="8%" id="CountPage"></td>
                    <td width="10%" class="text-right">���������</td>

                    <!--����� ����������-->
                    <td width="57%" class="text-center">&#160;&#160;&#160;� ����������� �������������� ���������� ��� �� ����� ��</td>
                    <td width="10%" style="text-align: center;">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                    <td width="10%" class="text-left">������</td>
                  </tr>

                </table>
              </td>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:apply-templates select="���������" />
                    </td>
                    <td style="border: 1pt solid black; width: 50%; vertical-align: top">
                      <xsl:call-template name="TaxWorker" />
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
          <xsl:call-template name="Feuilleton" />
        </td>
      </tr>
    </table>
    <!-- ��������� id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <!--��������� ��� ������ ��������-->
  <xsl:template name="titlePageHeader">
    <tr>
      <td>
        <table>
          <tr>
            <td>
              <xsl:call-template name="pageHeader">
                <xsl:with-param name="barCode">a0750`TPQSa</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--���������� � 1-->
            <td class="podpis text-right" width="280" style="padding-top: 4mm; padding-right: 4mm; padding-bottom: 0;">
              ���������� � 1 � ������� ��� ������<br/>�� 28.10.2011 � ���-7-11/696@
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="text-right">
        <b>
          ����� �� ��� <xsl:value-of select="@���" />
        </b>
      </td>
    </tr>
  </xsl:template>

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
                  <xsl:value-of select="$barCode" />
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
                  <xsl:with-param name="input" select="$Inn" />
                  <xsl:with-param name="size" select="12" />
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <table style="margin-top: 2mm; width: auto;">
            <tr>
              <td class="nowrap" style="width: 10mm;">���</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$Kpp" />
                  <xsl:with-param name="size" select="9" />
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">���.</td>
              <!-- ����� �������� -->
              <xsl:call-template name="pageNum" />
            </tr>
          </table>
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
            <xsl:with-param name="input" select="substring( $input, 1, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol">-</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="TaxWorker">
    <table>
      <!--���������-->
      <tr>
        <td class="text-center">
          <b>����������� ���������� ���������� ������</b>
        </td>
      </tr>
      <tr>
        <td class="text-center">�������� � ������������� ����������</td>
      </tr>
      <!--���-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="75%" class="text-center">
                ������ ���������� ������������ <span style="font-size: 8pt">(���)</span>
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
          <table class="tble-with-border">
            <tr>
              <td width="15%"></td>
              <td width="15%" class="text-center">��</td>
              <td width="25%" class="text-center">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="3"/>
                  <xsl:with-param name="symbol"> </xsl:with-param>
                </xsl:call-template>
              </td>
              <td width="45%" class="text-left">���������</td>
            </tr>
          </table>
        </td>
      </tr>
      <!--���������� ����������-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="55%" class="text-right">
                � �����������<br/>
                �������������� ����������<br/>� (���) �� ����� ��
              </td>
              <td width="7%"></td>
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
              <td style="padding-left: 5mm">
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
              <td class="text-center"  style="padding-left: 2mm">
                ���������������� �� �
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"></xsl:with-param>
                  <xsl:with-param name="size" select="11"/>
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
        <td width="45%" class="field_text"></td>
        <td width="10%">&#160;</td>
        <td width="45%" class="field_text"></td>
      </tr>
      <tr>
        <td class="podpis">(�������, �.�.)</td>
        <td>&#160;</td>
        <td class="podpis">(�������)</td>
      </tr>
    </table>
  </xsl:template>



  <!--������� ��� �������� �����-->
  <xsl:template name="breakDate">
    <xsl:param name="input"></xsl:param>
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 1, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )" />
            <xsl:with-param name="size" select="2" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 4 )" />
            <xsl:with-param name="size" select="4" />
            <xsl:with-param name="symbol"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--�������������������-->
  <xsl:template name="�������������������">
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
              <td class="border-bottom text-center" style="width: 15%">
                <xsl:value-of select="$docDate" />
              </td>
              <td class="explanation" style="width: 5%">&#160;(����)</td>
              <td style="width: 25%">&#160;</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <xsl:call-template name="Feuilleton" />
  </xsl:template>

  <xsl:template match="���������">
    <table>
      <!--���������-->
      <tr>
        <td class="text-center bold">
          ������������� � ������� ��������, ���������<br />� ��������� ����������, �����������:
        </td>
      </tr>
      <!--�������-->
      <tr>
        <td>
          <table>
            <tr>
              <td width="50mm">&#160;</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@������" />
                  <xsl:with-param name="size" select="1" />
                  <xsl:with-param name="symbol">-</xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="text-left">
                1 - ����������������,<br />2 - ������������� �����������������
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!--���-->
      <xsl:apply-templates select="���" />
      <!--������������ ����������� - ������������� �����������������-->
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������/@�������" />
            <xsl:with-param name="size" select="20" />
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
          <table style='margin-top: 7mm;'>
            <tr>
              <td style='width: 15%'>�������&#160;</td>
              <td class='field_text' style='width: 30%'>&#160;</td>
              <td style='width: 10%'>&#160;����</td>
              <td style='width: 40%'>
                <xsl:call-template name="breakDate">
                  <xsl:with-param name="input">
                    <xsl:value-of select="$docDate" />
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
        <td class="text-center" style="padding-top: 3mm">
          ������������ ���������,<br />��������������� ���������� �������������
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������/@�������" />
            <xsl:with-param name="size" select="20" />
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
          <xsl:with-param name="input" select="@�������" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@��������" />
          <xsl:with-param name="size" select="20" />
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
    <xsl:value-of select="@�������" />
    <xsl:text></xsl:text>
    <xsl:value-of select="@���" />
    <xsl:text></xsl:text>
    <xsl:value-of select="@��������" />
  </xsl:template>

  <!--������-->
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

  <!--********************* ������ 1 (���� 2) *********************************-->
  <xsl:template name="Page1">
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0750`TPRPa</xsl:with-param>
                  <xsl:with-param name="pageNum">2</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <th class="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 1. ����� ���������� ������, ���������� ������ � ������
                </h2>
              </th>
            </tr>
            <tr>
              <td class="text-center italic">
                ������������ ���������� � ������� ��������� (��� ���������� ����, ��������������� � ����������� �� �������� ���)
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@�������" />
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="4" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                <br />
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <!--��������� ������ ��� ���������� ��������� �������������-->
                  <xsl:apply-templates select="�����" mode="page1" />
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="�������������������" />
        </td>
      </tr>
    </table>
    <!-- ��������� id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <!--********************* ������ 2 (���� 3) *********************************-->
  <xsl:template match="�����">
    <xsl:variable name="KBK" select="@���" />
    <xsl:variable name="OKATO" select="@�����" />
    <xsl:for-each select="����������">
      <xsl:call-template name="Page2">
        <xsl:with-param name="KBK" select="$KBK" />
        <xsl:with-param name="OKATO" select="$OKATO" />
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="Page2">
    <xsl:param name="KBK" />
    <xsl:param name="OKATO" />
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td colspan="3">
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0750`TPSWa</xsl:with-param>
                  <xsl:with-param name="pageNum">3</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td colspan="3" class="bold text-center" style="padding-top: 3mm;">
                ������ 2. ������ ��������� ���� � ����� ���������� ������
              </td>
            </tr>
            <tr>
              <td class="text-center italic" colspan="3" style="padding-top: 2mm;">
                ����������� ����� ���������� �������
              </td>
            </tr>
            <tr>
              <td colspan="3">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@������������" />
                  <xsl:with-param name="size" select="40" />
                  <xsl:with-param name="line" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td style="padding-top: 3mm" class="text-center italic" align="center">����������</td>
              <td style="padding-top: 3mm" class="text-center italic" align="center">
                ���<br />������
              </td>
              <td style="padding-top: 3mm" class="text-center italic" align="center">�������� �����������</td>
            </tr>
            <tr>
              <td align="center">1</td>
              <td align="center">2</td>
              <td align="center">3</td>
            </tr>
            <tr>
              <td style="width:45%">��� ��������� �������������</td>
              <td style="width:5%" class="text-center">010</td>
              <td style="width:50%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$KBK" />
                  <xsl:with-param name="size" select="20" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��� �� �����</td>
              <td class="text-center">020</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$OKATO" />
                  <xsl:with-param name="size" select="11" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��������� ������ (���)</td>
              <td class="text-center">030</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@����������" />
                  <xsl:with-param name="size" select="12" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>������ �������������</td>
              <td class="text-center">040</td>
              <td>
                <table>
                  <tr>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������" />
                        <xsl:with-param name="size" select="1" />
                      </xsl:call-template>
                    </td>
                    <td>1 - 3 ����, 2- ����� 3 ���.</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                ����������� ��������� (���� ����������� ���������)<br/>���������� ������� / ����������� ���� ����� (���.)
              </td>
              <td class="text-center">050</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@�����������" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>���� ����������������� � ����� �� ��������� �������</td>
              <td class="text-center">060</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="@������" />
                  <xsl:with-param name="size1" select="10"/>
                  <xsl:with-param name="size2" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td colspan="3">
                <b>I. ����������� ��������� ����</b>
              </td>
            </tr>
            <tr>
              <td>
                ��� ��������� ������ � ���� ������������ �������<br/>�����
              </td>
              <td class="text-center">070</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="����������/�����387_2���/@�����������" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                �� ���������� ������� ����� (���.) <span style="font-size: 7pt">
                  (�. 2 ��. 387<br/>���������� ������� ���������� ��������� (����� - ������))
                </span>
              </td>
              <td class="text-center">080</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����������/�����387_2���/@��������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��� ��������� ������ � ���� �� ���������� ������� �����</td>
              <td class="text-center">090</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����������/�����391_5/@�����������" />
                  <xsl:with-param name="size" select="7" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                �� ���������� ������� ����� (���.) <span style="font-size: 7pt">(�.5 ��.391 �������)</span>
              </td>
              <td class="text-center">100</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����������/�����391_5/@��������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��� ��������� ������ � ���� ���� �� ���������� ������� ���������� �������</td>
              <td class="text-center">110</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="����������/�����387_2��/@�����������" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ���� �� ���������� ������� ���������� �������<br/><span style="font-size: 7pt">(�.2 ��.387 �������)</span>
              </td>
              <td class="text-center">120</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="����������/�����387_2��/@��������" />
                  <xsl:with-param name="size1" select="10"/>
                  <xsl:with-param name="size2" select="10"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��������� ���� (���.)</td>
              <td class="text-center">130</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����������/@�������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold">II. ��������� ������ (%)</td>
              <td class="text-center">140</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="@�������" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold">III. ���������� ����� ���������� ������</td>
            </tr>
            <tr>
              <td>
                ���������� ������ ������� �������� ���������<br/>�������� � ������� ���������� �������
              </td>
              <td class="text-center">150</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/@����������" />
                  <xsl:with-param name="size" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>����������� ��</td>
              <td class="text-center">160</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="������������/@��" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>����� ������������ ������</td>
              <td class="text-center">170</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/@������������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>���������� ������ ������� ������������� ������</td>
              <td class="text-center">180</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/@�����������" />
                  <xsl:with-param name="size" select="2" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>����������� ��</td>
              <td class="text-center">190</td>
              <td>
                <xsl:call-template name="breakFraction1">
                  <xsl:with-param name="input1" select="������������/@��" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ��� ��������� ������ � ���� ������������ ��<br/>���������������
              </td>
              <td class="text-center">200</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="������������/�����387_2���/@�����������" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td style="width:42%">
                ����� ��������� ������ (���.) <span style="font-size: 7pt">(�. 2 ��. 387 �������)</span>
              </td>
              <td class="text-center">210</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/�����387_2���/@������" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ��� ��������� ������ � ���� ������������ ��<br/>���������������
              </td>
              <td class="text-center">220</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/�����395/@�����������" />
                  <xsl:with-param name="size" select="7" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ����� ��������� ������ (���.) <span style="font-size: 7pt">(��. 395, ��.7 �������)</span>
              </td>
              <td class="text-center">230</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/�����395/@������" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>��� ��������� ������ � ���� ���������� ����� ������</td>
              <td class="text-center">240</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="������������/�����387_2�����/@�����������" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ����� ��������� ������ (���.) <span style="font-size: 7pt">(�. 2 ��. 387 �������)</span>
              </td>
              <td class="text-center">250</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/�����387_2�����/@������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ��� ��������� ������ � ���� �������� ���������<br/>������
              </td>
              <td class="text-center">260</td>
              <td>
                <xsl:call-template name="breakFraction">
                  <xsl:with-param name="input" select="������������/�����387_2������/@�����������" />
                  <xsl:with-param name="size1" select="7"/>
                  <xsl:with-param name="size2" select="12"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ����� ��������� ������ (���.) <span style="font-size: 7pt">(�. 2 ��. 387 �������)</span>
              </td>
              <td class="text-center">270</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/�����387_2������/@������" />
                  <xsl:with-param name="size" select="15" />
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>
                ����������� ����� ������, ���������� ������<br/>� ������ �� ��������� ������ (���.)
              </td>
              <td class="text-center">280</td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="������������/@�����������" />
                  <xsl:with-param name="size" select="15" />
                  <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <!-- ��������� id = "printFormPageN" -->
    <xsl:call-template name="printFormPage">
      <xsl:with-param name="id" select="$id" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="�����" mode="page1">
    <tr>
      <td style="width:45%">��� ��������� �������������</td>
      <td style="width:5%" class="text-center">010</td>
      <td style="width:50%">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���" />
          <xsl:with-param name="size" select="20" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>��� �� �����</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�����" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">0</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����������� ����� ������, ���������� ������ �<br/>������ �� ��������� ������ (���.)
      </td>
      <td class="text-center">021</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���������" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">
        � �.�. ����� ��������� ��������, ����������<br/>������ � ������ ��:
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">������ ������� (���.)</td>
      <td class="text-center">023</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@������1" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">������ ������� (���.)</td>
      <td class="text-center">025</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@������2" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td class="padding-left5mm">������ ������� (���.)</td>
      <td class="text-center">027</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@������3" />
          <xsl:with-param name="size" select="11" />
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
        </xsl:call-template>
      </td>
    </tr>
    <xsl:apply-templates select="@�����">
      <xsl:with-param name="strNum1">030</xsl:with-param>
      <xsl:with-param name="strNum2">040</xsl:with-param>
    </xsl:apply-templates>
    <tr>
      <td>
        <br />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="@�����">
    <xsl:param name="strNum1" />
    <xsl:param name="strNum2" />
    <tr>
      <td>����� ������, ���������� ������ � ������ (���.)</td>
      <td class="text-center">
        <xsl:value-of select="$strNum1"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test=".>0">
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input" select="."/>
              <xsl:with-param name="size" select="15"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input"/>
              <xsl:with-param name="size" select="15"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <tr>
      <td>����� ������, ����������� � ���������� (���.)</td>
      <td class="text-center">
        <xsl:value-of select="$strNum2"/>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="substring-after(.,'-')"/>
          <xsl:with-param name="size" select="15"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>




  <!-- ��������� ��� �������� id = "printFormPageN" -->
  <xsl:template name="printFormPage">
    <xsl:param name="id"></xsl:param>
    <script type="text/javascript">
      // ����������� ��������� ��������
      var element = document.getElementById('<xsl:value-of select="$id" />');
      if (element)
      element.setAttribute('id', 'printFormPage' + PageNumScript);
    </script>
  </xsl:template>

  <!-- ��������� ������ ������� -->
  <xsl:template name="pageNum">
    <!-- ��������� � id ������� 'pageNum' �.�. � ������ ����� ��������  generate-id() 
    ������ ���� � �� �� �������� ��� ��������� ��������� DIV � ��������� TD -->
    <xsl:variable name="id" select="concat(generate-id(),'pageNum')" />
    <td id="{$id}" class="text-left"></td>
    <script type="text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id" />', PageNumScript, 3, 1, '0');
    </script>
  </xsl:template>

  <!-- ��������� ���-�� ������� -->
  <xsl:template name="CountPage">
    <script type="text/javascript">
      breakStr('CountPage', PageNumScript, 3, 0, '-');
    </script>
  </xsl:template>

  <xsl:template name="breakFraction">
    <xsl:param name="input" />
    <xsl:param name="size1"/>
    <xsl:param name="size2"/>
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:value-of select="substring-before( $input, '/' )" />
            </xsl:with-param>
            <xsl:with-param name="size" select="$size1" />
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
        <td>/</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '/' )" />
            <xsl:with-param name="size" select="$size2" />
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakFraction1">
    <xsl:param name="input1" />
    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring($input1, 1, 1)" />
            <xsl:with-param name="size" select="1" />
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
        <td style="vertical-align: middle">.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input1, '.' )" />
            <xsl:with-param name="size" select="4" />
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>