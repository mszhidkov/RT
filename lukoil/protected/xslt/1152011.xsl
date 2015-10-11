<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="breakStr.xslt"/>
	<xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!-- /kilor/xslt/ -->

  <xsl:variable name="INN" select="����/��������/����/����/@�����"/>
  <xsl:variable name="KPP" select="����/��������/����/����/@���"/>
  <xsl:variable name="docDate" select="����/��������/@�������"/>

  <xsl:template match="/">
    <link rel="stylesheet" type="text/css" href=" /kilor/xslt/style.css"/>
    <!--<link rel="stylesheet" type="text/css" href="http://temp.web-dev.tensor.ru/kilor/xslt/style.css"/>-->
    <!-- ���������� ������ �������� ������� ������� -->
    <!-- ������� ������� ������� -->
    <script type = "text/javascript">
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


    <style>
      .view_container .table-with-border td
      {
      border: solid 1px black;
      font-size: 8pt;
      }
      .view_container .table-with-border2 td
      {
      text-align: center;
      border: solid 1px black;
      font-size: 9pt;
      }
      .view_container .big-h1
      {
      font-size: 11pt;
    </style>

    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="��������">
    <!--��������� ���������� �� ������ �� ������� ������-->
    <!--��� 1152011-->
    <!--NO_IGBISND-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="�������"/>

    <!-- ���������� ������� ������� -->
    <xsl:call-template name="CountPage"/>

  </xsl:template>

  <xsl:template match="�������">
    <!--������ 1: ����� ������, ���������� ������ � ������-->
    <xsl:apply-templates select="��������" mode="section1"/>

    <!--������ 2: ����� ������ � ������-->
    <xsl:apply-templates select="�������" mode="section2"/>

    <!--������ 2.1: ������ ������ �� ������� ������ �� ������� ������-->
    <xsl:apply-templates select="�������/�����������/���������" mode="section3"/>

    <!--������ 3: ������ ������ �� ������� ������ �� ������� ������-->
    <xsl:apply-templates select="�����������" mode="section4"/>

    <!--������ 3.1: ��������� ���������� ������� ������ �� ��������� ������-->
    <xsl:apply-templates select="�����������/����������/��������" mode="section5"/>
  </xsl:template>



  <xsl:template match="Section1">
    <!--������ 1: ����� ������ � ������-->
    <xsl:apply-templates select="��������"/>
  </xsl:template>


  <!--<xsl:template match="��������">
    ������ 1: ����� ������ � ������
    <xsl:call-template name="Section1"/>
  </xsl:template>-->

  <!--��������-->

  <!--���.1_����01-->
  <xsl:template name="titlePage">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <xsl:call-template name="titlePageHeader"/>

            <!--���������-->
            <tr>
              <th>
                <h1 class="padding-top5mm">
                  ��������� ���������� �� ������ �� ������� ������
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
                    <!--��������� ������ (���)-->
                    <td class="text-center">
                      ��������� ������ <span style="font-size: 8pt">(���)</span>
                    </td>
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
                    <td>
                      �������������� � ��������� ����� <span style="font-size: 8pt">(���)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <!--�� ����� ���������� (�����) (���)-->
                    <td class="text-center">
                      �� ����� ���������� (�����) <span style="font-size: 8pt">(���)</span>
                    </td>
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
                  <xsl:with-param name="input" select="����/����/@�������"/>
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

  <!--������ 1:-->
  <xsl:template match="��������" mode="section1">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPRQa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 5mm;">
                  ������ 1. ����� ������, ���������� ������ � ������
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section1Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="SectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--������ 2:-->
  <xsl:template match="�������" mode="section2">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPSXa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                ������ 2. ������ ������ �� ������� ������
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section2Table1"/>
              </td>
            </tr>
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                ����� ������������ ������ �� ������� ������
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section2Table2"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--������ 2.1:-->
  <xsl:template match="���������" mode="section3">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPTUa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                ������ 2.1. ������ ������ �� ������� ������ �� ������� ������ *
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section3Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--������ 3:-->
  <xsl:template match="�����������" mode="section4">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPURa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                ������ 3. ��������� ���������� �������� ��������������� ������� �� ������� ������ �� ��������� ������
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section4Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>
  
  <!--������ 3.1:-->
  <xsl:template match="��������" mode="section5">

    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0210`VPVYa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <td style="padding-top: 1mm;" class="bold text-center">
                ������ 3.1. ��������� ���������� ������� ������ �� ��������� ������ **
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="Section5Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--��������� ����� ������� 1-->
  <xsl:template name="Section1Table">
    <table style="margin-top: 5mm;">
      <tr>
        <td class="text-center italic" style="width: 42%">����������</td>
        <td class="text-center italic" style="width: 8%">
          ���<br/>������
        </td>
        <td class="text-center italic" style="width: 50%">�������� �����������</td>
      </tr>
      <tr>
        <td class="text-center">1</td>
        <td class="text-center">2</td>
        <td class="text-center">3</td>
      </tr>
      <tr>
        <td>
          ��� ��������� �������������
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@���"/>
            <xsl:with-param name="size" select="20"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ��� �����
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����"/>
            <xsl:with-param name="size" select="11"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������, ���������� ������ � ������ (���.)
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����"/>
            <xsl:with-param name="size" select="15"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--��������� �����1 ������� 2-->
  <xsl:template name="Section2Table1">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTable1Razd2"/>
      <tr>
        <td style="font-size: 8pt">
          ���������� ��������, <br/> ���������� ��������������� <br/> (������), �����
        </td>
        <td class="text-center">020</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="bold">
          � ��� �����:
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� ������ ������, <br/> ������������� � <br/> ������������ � ������� 1 <br/> ������ 369 �� ��
        </td>
        <td class="text-center">030</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� 1/2 ������ ������, <br/> ������������� � <br/> ������������ � �������� 3 � 4 <br/> ������ 370 �� ��
        </td>
        <td class="text-center">040</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�����_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� ������ ������, <br/> ������������� � <br/> ������������ � ������� 1 <br/> ������ 369 �� �� � ������ <br/> ������ 2 ������ 1 ������ 370 <br/> �� ��
        </td>
        <td class="text-center">050</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�������_370.1.2"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� 1/2 ������ ������, <br/> ������������� � <br/> ������������ � �������� 3 � 4 <br/> ������ 370 �� �� � ������ <br/> ������ 2 ������ 1 ������ 370 <br/> �� ��
        </td>
        <td class="text-center">060</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�������_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--��������� �����2 ������� 2-->
  <xsl:template name="Section2Table2">
    <table style="margin-top: 5mm;">
      <tr>
        <td class="text-center italic" style="width: 40%">������� ���������������</td>
        <td class="text-center italic" style="width: 10%">
          ���<br/>������
        </td>
        <td class="text-center italic" style="width: 15%">
          ������ ������<br/>(���.)
        </td>
        <td class="text-center italic" style="width: 35%">
          ����� ������������ ������ �� �������<br/>������ (���.)
        </td>
      </tr>
      <tr>
        <td class="text-center">1</td>
        <td class="text-center">2</td>
        <td class="text-center">3</td>
        <td class="text-center">4</td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������� �����, �����
        </td>
        <td class="text-center padding-top5mm">070</td>
        <td>
        </td>
        <td class=" text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������� ��������
        </td>
        <td class="text-center padding-top5mm">080</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          �������������� ������ �������������
        </td>
        <td class="text-center padding-top5mm">090</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�������"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          �������������� ������ ������������ ������
        </td>
        <td class="text-center padding-top5mm">100</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�������"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������ ������ ������ �������������
        </td>
        <td class="text-center padding-top5mm">110</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������ ������ ������ ������������ ������
        </td>
        <td class="text-center padding-top5mm">120</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--��������� ����� ������� 2.1-->
  <xsl:template name="Section3Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTableHat"/>
      <tr>
        <td class="padding-top5mm">
          ���������� ��������� ������� ����� �� ������� �����
        </td>
        <td class="text-center padding-top5mm">010</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������ ������ ������ �� ������� ������ � �����, ������������� ������� <br/> �������� ���������� ��������� � ������������ � ������� 1 ������ 369 <br/> �� �� (���.)
        </td>
        <td class="text-center padding-top5mm">020</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�������_369.1"/>
            <xsl:with-param name="size" select="6"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ������ ������ ������ �� ������� ������ � �����, ������������� � <br/> ������������ � ������� 1 ������ 369 �� �� � ������ ������ 2 ������ 1 <br/> ������ 370 �� �� <br/> (���.020 ��.3 � ���. 010 ��.3)
        </td>
        <td class="text-center padding-top5mm">030</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@���������_370.1.2"/>
            <xsl:with-param name="size" select="7"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ���������� ������� ������, ������� ���������� �����, ��������� � <br/> ���.010 ��.3, ���������� ��������������� (������), �����
        </td>
        <td class="text-center padding-top5mm">040</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm bold">� ��� �����:</td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          �� ������ ������, ������������� � ������������ � ������� 1 ������ 369 <br/> �� ��
        </td>
        <td class="text-center padding-top5mm">050</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������_369.1"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          �� 1/2 ������ ������, ������������� � ������������ � �������� 3 � 4 <br/> ������ 370 �� ��
        </td>
        <td class="text-center padding-top5mm">060</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          �� ������ ������, ������������� � ������������ � ������� 1 ������ 369 <br/> �� �� � ������ ������ 2 ������ 1 ������ 370 �� ��
        </td>
        <td class="text-center padding-top5mm">070</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������_370.1.2"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm padding-left5mm">
          �� 1/2 ������ ������, ������������� � ������������ � �������� 3 � 4 <br/> ������ 370 �� �� � ������ ������ 2 ������ 1 ������ 370 �� ��
        </td>
        <td class="text-center padding-top5mm">080</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������_370.34"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������ �� ������� ������ (���.)
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@���������"/>
            <xsl:with-param name="size" select="10"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
    <div class="italic" style="margin-top: 250pt; font-size: 8pt">
      * ��� ������� ������� ������ � ��������� ����������� ������� ����� ������ 2.1 ����������� ������� ���, ������� ������� ��������� <br/> ���������� ������� ����� �� ������� ������. ��� ���� ������ �� ���������� ������� ������, ������� ���������� ���������� ������� <br/> �����, � ����� ������������ ������ �� ������� ������ �� ������ ������� ������ ������������ � ������� 2.1 �� ����� ��������.
    </div>
  </xsl:template>

  <!--��������� ����� ������� 3-->
  <xsl:template name="Section4Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTable1Razd2"/>
      <tr>
        <td style="font-size: 8pt">
          ���������� ��������<br/>���������������,<br/>������������������ �<br/>��������� ������ (������):
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� ������ ����������<br/>�������
        </td>
        <td class="text-center">010</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          ����������� �� 15 �����
        </td>
        <td class="text-center">020</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          ������ ����� 15 �����
        </td>
        <td class="text-center">030</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          ����������� ����� 15<br/>�����
        </td>
        <td class="text-center">040</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          ������ �� 15 �����
        </td>
        <td class="text-center">050</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-size: 8pt; padding-left: 2mm">
          �� ����� ����������<br/>�������
        </td>
        <td class="text-center">060</td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="���������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
        <td class="text-center">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����������/@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>


  <!--��������� ����� ������� 3.1-->
  <xsl:template name="Section5Table">
    <table style="margin-top: 5mm;">
      <xsl:call-template name="StandartTableHat"/>
      <tr>
        <td class="padding-top5mm">
          ���������� ��������� ������� ����� �� ������� �����
        </td>
        <td class="text-center padding-top5mm">010</td>
        <td class="padding-top5mm">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-top5mm">
          ���������� ������� ������, ������������������ � ��������� ������ <br/> (������):
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          �� ������ ���������� �������
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          ����������� �� 15 �����
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          ������ ����� 15 �����
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          ����������� ����� 15 �����
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          ������ �� 15 �����
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����������15"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="padding-left5mm">
          �� ����� ���������� �������
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����������"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
    <div class="italic" style="margin-top: 400pt; font-size: 8pt">
      ** ��� ������� ������� ������ � ��������� ����������� ������� ����� ������ 3.1 ����������� ������� ���, ������� ������� ��������� <br/> ���������� ������� ����� �� ������� ������. ��� ���� ������ �� ���������� ������� ������, ������� ���������� ���������� ������� <br/> �����, ������������ � ������� 3.1 �� ����� ��������.
    </div>
  </xsl:template>

  <!--����� ��� ������� 1 ������� 2, 3-->
  <xsl:template name="StandartTable1Razd2">
    <tr style="font-size: 8pt">
      <td class="text-center italic" style="width: 23%">����������</td>
      <td class="text-center italic" style="width: 5%">
        ���<br/>������
      </td>
      <td class="text-center italic" style="width: 12%">
        ������� �����,<br/>�����
      </td>
      <td class="text-center italic" style="width: 12%">
        �������<br/>��������
      </td>
      <td class="text-center italic" style="width: 12%">
        ��������������<br/>������<br/>�������������
      </td>
      <td class="text-center italic" style="width: 12%">
        ��������������<br/>������<br/>������������<br/>������
      </td>
      <td class="text-center italic" style="width: 12%">
        ������ ������<br/>������<br/>�������������
      </td>
      <td class="text-center italic" style="width: 12%">
        ������<br/>������<br/>������<br/>������������<br/>������
      </td>
    </tr>
    <tr style="font-size: 8pt">
      <td class="text-center italic">1</td>
      <td class="text-center italic">2</td>
      <td class="text-center italic">3</td>
      <td class="text-center italic">4</td>
      <td class="text-center italic">5</td>
      <td class="text-center italic">6</td>
      <td class="text-center italic">7</td>
      <td class="text-center italic">8</td>
    </tr>
  </xsl:template>

    <!--����� ������ ��� �������� 2.1, 3.1-->
  <xsl:template name="StandartTableHat">
    <tr>
      <td class="text-center italic" style="width: 60%">����������</td>
      <td class="text-center italic" style="width: 10%">
        ���<br/>������
      </td>
      <td class="text-left italic" style="width: 30%">�������� �����������</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td style="padding-left: 50pt">3</td>
    </tr>
  </xsl:template>

  <!--������ ��� ��������-->
  <xsl:template name="SectionFeuilleton">
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
                  <td class="border-bottom text-center" style="width: 15%">
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

  <!--��������� ��� ������ ��������-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageID"></xsl:param>
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
            <xsl:with-param name="pageID" select="$pageID"/>
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
                <xsl:with-param name="barCode">a0210`VPQTa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--���������� � 1-->
            <td class="podpis text-right" style="width: 50mm; padding-top: 4mm; padding-right: 0mm; padding-bottom: 0;">
              ���������� � 1 � ������� ��� ������<br/>
              �� 28.12.2011 N ���-7-3/985@
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

  <xsl:template name="INN_KPP_Page">
    <xsl:param name="pageID"/>
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
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">���.</td>
        <xsl:call-template name="pageNum">
          <xsl:with-param name="pageID" select="$pageID"/>
        </xsl:call-template>
      </tr>
    </table>
  </xsl:template>

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
              <td style="width: 15%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="@������"/>
                  <xsl:with-param name="size" select="1"/>
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
          <table style='margin-top: 7mm;'>
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
        <td class="text-center" style="padding-top: 3mm">
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
                �������������� ����������<br/> ��� �� ����� ��
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
                ���������������� <br/>�� �
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
        <td class="podpis">�������, �.�.</td>
        <td>&#160;</td>
        <td class="podpis">�������</td>
      </tr>
    </table>
  </xsl:template>

  <!--����� ����-->
  <xsl:template match="���">
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�������"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@��������"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
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
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--������� ������-->
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
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 4, 2 )"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring( $input, 7, 2 )"/>
            <xsl:with-param name="size" select="2"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- ��������� ������ ������� -->
  <xsl:template name="pageNum">
    <xsl:param name="pageID"/>
    <!-- ��������� � id ������� 'pageID' �.�. � ������ ����� �������� (������ ����) generate-id() 
    ������ ���� � �� �� �������� ��������� ���� �� -->
    <xsl:variable name="id" select="concat(generate-id(),'pageID',$pageID)"/>
    <td id="{$id}" class="text-left"></td>
    <script type = "text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id"/>', PageNumScript, 3, 1, '0');
    </script>
  </xsl:template>

  <!-- ��������� ���-�� ������� -->
  <xsl:template name="CountPage">
    <script type = "text/javascript">
      breakStr('CountPage', PageNumScript, 3, 0, '-');
    </script>
  </xsl:template>

</xsl:stylesheet>