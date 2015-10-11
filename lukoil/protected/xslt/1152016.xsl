<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="breakStr.xslt"/>
  <xsl:include href="counter.xslt"/>
  <xsl:include href="no_format.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!-- /kilor/xslt/ -->

  <xsl:variable name="INN">
    <xsl:value-of select="����/��������/����/����/@�����"/>
    <xsl:value-of select="����/��������/����/����/@�����"/>
  </xsl:variable>
  <xsl:variable name="KPP" select="����/��������/����/����/@���"/>
  <xsl:variable name="docDate" select="����/��������/@�������"/>

  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <!--�������������� ������ ��������-->
    <xsl:call-template name="InitCounterScript"/>
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="��������">
    <!--��������� ���������� �� ������� ������ �� ��������� ����� ��� ��������� ����� ������������ NO_ENVD-->
    <!--��� 1152016-->
    <!--NO_ENVD-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="����"/>

    <!-- ���������� ������� ������� -->
    <xsl:call-template name="CountPage"/>

  </xsl:template>

  <xsl:template match="����">
    <!--������ 1. ����� ������� ������ �� ��������� ����� ��� ��������� ����� ������������, ���������� ������ � ������ �� ������ �����������������-->
    <xsl:apply-templates select="����������"/>
    <!--������ 2. ������ ������� ������ �� ��������� ����� ��� ��������� ����� ������������-->
    <xsl:apply-templates select="����������/�������/���������"/>
    <!--������ 3. ������ ����� ������� ������ �� ��������� ����� �� ��������� ������-->
    <xsl:apply-templates select="��������"/>
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
                  ��������� ����������<br/> �� ������� ������ �� ��������� ����� ��� ��������� ����� ������������
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
                    <td class="text-center">��������� ������ (���)</td>
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
                    <!--�� ����� ����� (���) 	-->
                    <td class="text-right">
                      �� ����� ����� (���)
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
                    <td class="text-right" width="65%">��� ���� ������������� ������������ �� �������������� �����&#160;</td>
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
                    <td width="20%" class="text-right">
                      ����� �������������<br/>
                      (����������) <span style="font-size:8pt">(���)</span>
                    </td>
                    <td width="9%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/����/���������/@���������"/>
                        <xsl:with-param name="size" select="1"/>
                      </xsl:call-template>
                    </td>
                    <td width="23%" class="text-right">
                      ���/��� ����������������<br/>
                      �����������
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="����/����/���������/@�����"/>
                        <xsl:with-param name="size" select="10"/>
                      </xsl:call-template>
                    </td>
                    <td width="1%">/</td>
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
                    <td class="text-right">��</td>
                    <td id="CountPage"></td>
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
            <tr>
              <td style="font-size:8pt">* - �������� ��� �������.</td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="Feuilleton"/>
    </table>
  </xsl:template>

  <!--������ 1. ����� ������� ������ �� ��������� �����, ���������� ������ � ������-->
  <xsl:template match="����������">
    <xsl:param name="knd" />
    <xsl:call-template name="pageRecursiveR1">
      <xsl:with-param name="CountPage" select="ceiling(count(�������) div 8)"/>
      <xsl:with-param name="node" select="."/>
      <xsl:with-param name="knd" select="$knd" />
    </xsl:call-template>
  </xsl:template>

  <!-- ��� ������������ ������ ������� 1. -->
  <xsl:template name="pageRecursiveR1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>
    <xsl:param name="knd" />
    <!--������� �� 8 ������ �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*8 + 1"/>
      <xsl:with-param name="knd" select="$knd" />
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="knd" select="$knd" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--<xsl:template match="����������">-->
  <xsl:template name="pageR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="knd" />
    <div class="page-break">&#160;</div>
    <xsl:variable name="id" select="generate-id()" />
    <table id="{$id}" class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPRTa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 1. ����� ������� ������ �� ��������� �����, ���������� ������� ������
                </h2>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <xsl:call-template name="table1Hat"/>
                  <tr>
                    <td colspan="3">
                      <!--<xsl:apply-templates select="$node/�������[position() >= $position and  $position + 8 > position()]"/>-->

                      <!-- ������� �����-->
                      <xsl:call-template name="OutStrRecursiveR1">
                        <xsl:with-param name="node" select="$node/�������"/>
                        <xsl:with-param name="position" select="$position"/>
                      </xsl:call-template>
                      
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>


  <xsl:template name="OutStrRecursiveR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 8) * 8"/>

    <tr>
      <td>��� �� �����</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@�����"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� ������� ������ �� ��������� �����,<br/>
        ���������� ������ �� ��������� ������ (���.)<br/>
        <span class="explanation">
          (���. 060 ������� 3 � (����� ����� 100 ���� ��������<br/>
          2 �� ������� ���� ����� / ���. 010 ������� 3))
        </span>
      </td>
      <td class="text-center" valign="center">030</td>
      <td valign="center">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@�����"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
        </xsl:call-template>
      </td>
    </tr>


    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>


  <!--������ 2. ������ ������� ������ �� ��������� ����� ��� ��������� ����� ������������-->
  <xsl:template match="�������/���������">
  <xsl:param name="node"/>
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPSQa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 2. ������ ����� ������� ������ �� ��������� ����� ��� ��������� ����� ������������
                </h2>
              </th>
            </tr>

            <tr>
              <td>
                <table>
                  <tr>
                    <td>
                      ��� ���� ������������������� ������������<span class="explanation"> (��� ���. 010)</span>
                    </td>
                    <td style="text-align: left">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <td style="width: 40%"></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>���� ����������� ����� �� ���� <span class="explanation">(��� ���. 015)</span>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:call-template name="outOkun"/>
              </td>
            </tr>
              
            <xsl:apply-templates select="�����������"/>
      
            <tr>
              <td>
                <table>
                  <tr>
                    <td style="width: 29%">
                      ��� �� �����<span class="explanation"> (��� ���. 030)</span>
                    </td>
                    <td style="width: 71%">
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="../@�����"/>
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
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

  <!--������ 3. ������ ����� ������� ������ �� ��������� ����� �� ��������� ������-->
  <xsl:template match="��������">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0291`PPTXa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>

            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 3. ������ ����� ������� ������ �� ��������� ����� �� ��������� ������
                </h2>
              </th>
            </tr>

            <tr>
              <td class ="text-right" style="margin-top: 10mm">
                (� ������)
              </td>
            </tr>

            <tr>
              <td>
                <xsl:call-template name="section3Table"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <xsl:call-template name="sectionFeuilleton"/>
    </table>
  </xsl:template>

  <!--��������� ����� ������� 2-->
  <xsl:template name="section2Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table23Hat"/>

      <tr>
        <td>
          ������� ���������� �� ������� ����������� ���������� � �����<br/>
          <span class="explanation">(���.)</span>
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@��������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>�������� ����������� ���������� �� 1 ����� ���������� ������� </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������1"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="text-right" style="padding-right:4mm">2 ����� ���������� �������</td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������2"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="text-right" style="padding-right:4mm">3 ����� ���������� ������� </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@���������3"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>�������������� ����������� �1</td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakFactor">
            <xsl:with-param name="input" select="������������/@�1"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>�������������� ����������� �2</td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakFactor">
            <xsl:with-param name="input" select="������������/@�2"/>
            <xsl:with-param name="size" select="3"/>
            <xsl:with-param name="nullIsPrinted" select="1"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ��������� ���� (���.)<br/>
          <span class="explanation">(���. 040 � ���. 080 � ���. 090 � (���. 050 + ���. 060 + ���. 070))</span>
        </td>
        <td class="text-center">100</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@�������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������� ������ �� ��������� ����� (���.) ��<br/>
          ��������� ������ <span class="explanation"> (���. 100 � 15 / 100)</span>
        </td>
        <td class="text-center">110</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="������������/@������������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--��������� ����� ������� 3-->
  <xsl:template name="section3Table">
    <table style="margin-top: 10mm;">
      <xsl:call-template name="table3Hat"/>

      <tr>
        <td>
          ��������� ����, ����������� �� ���� ����� �����<br/>
          <span class="explanation">(����� �������� ���. 100 ���� ����������� �������� 2 ����������)</span>
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          ����� ������������ ������� ������ �� ��������� �����<br/>
          <span class="explanation">(����� �������� ���. 110 ���� ����������� �������� 2 ����������)</span>
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@���������������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          ����� ��������� ������� �� ������������ ���������� �����������,<br/>
          ������������ ���������� ����������� �� ������ ���������<br/>
          ������������������ � � ����� � ������������, ������������ �����������<br/>
          �����������, ������������ ���������� ����������� �� ���������� ������� ��<br/>
          ������������ � ���������������� �����������, ���������� (� ��������<br/>
          ����������� ����) �� ��������� ������ � ������������ � �����������������<br/>
          ���������� ��������� ��� ������� ������������������� ��������������<br/>
          ����������, ������� � ��� ������ ������������ �����������������, ��<br/>
          ������� ������������ ������ �����, � ����� ����� ��������� ������� � ����<br/>
          ������������� ��������, ���������� ���������������<br/>
          ����������������� �� ���� �����������
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@��������"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          ����� ����������� � ������� ���������� ������� �� �������<br/>
          ����������������� ������� �� ��������� ������������������ ����������,<br/>
          ������� � ������ ������������, �� ������� ������������ ������ ����� ��<br/>
          ��������� �����
        </td>
        <td class="text-center" valign="top">040</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����������"/>
            <xsl:with-param name="size" select="12"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          ����� ����� ��������� ������� � ������� �� ��������� ������������������<br/>
          <span class="explanation">(���. 030 + ���. 040)</span>, ����������� (�� �� ����� ��� �� 50%) �����<br/>
          ������������ ������� ������ �� ��������� ����� <span class="explanation"> (���. 020)</span>
        </td>
        <td class="text-center" valign="top">050</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����������"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td height="10mm"></td>
      </tr>
      <tr>
        <td>
          ����� ������� ������ �� ��������� �����, ���������� ������ �� ���������
          <br/>������ <span class="explanation"> (���. 020 - ���. 050)</span>
        </td>
        <td class="text-center" valign="top">060</td>
        <td valign="top">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@�����"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--����� ������ ��� ������� 1-->
  <xsl:template name="table1Hat">
    <tr>
      <td class="text-center italic" style="width: 45%">����������</td>
      <td class="text-center italic" style="width: 5%">��� ������</td>
      <td class="text-center italic" style="width: 50%">�������� �����������</td>
    </tr>
    <tr>
      <td>��� ��������� �������������</td>
      <td class="text-center">010</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--����� ������ ��� ������� 2 -->
  <xsl:template name="table23Hat">
    <tr>
      <td class="text-center italic" style="width: 55%">����������</td>
      <td class="text-center italic" style="width: 15%">
        ���<br/>
        ������
      </td>
      <td class="text-center italic" style="width: 30%">�������� �����������</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td class="text-center">3</td>
    </tr>
  </xsl:template>

  <!--����� ������ ��� ������� 3-->
  <xsl:template name="table3Hat">
    <tr>
      <td class="text-center italic" style="width: 65%">����������</td>
      <td class="text-center italic" style="width: 6%">
        ���<br/>
        ������
      </td>
      <td class="text-center italic" style="width: 29%">�������� �����������</td>
    </tr>
    <tr>
      <td class="text-center">1</td>
      <td class="text-center">2</td>
      <td class="text-center">3</td>
    </tr>
  </xsl:template>

  <!--������ ��� �������� 1, 2, 3-->
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
                  <td class="text-center border-bottom" style="width: 15%">
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
    <xsl:param name="pageID"/>
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
                <xsl:with-param name="barCode">a0291`PPQWa</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--���������� � 1-->
            <td class="podpis text-right" style="width: 75mm; padding-top: 4mm; padding-right: 0mm; padding-bottom: 0;">
              ���������� � 1 <br/> � ������� ����������� ��������� ������ <br/> �� 23 ������ 2012 �. � ���-7-3/13@
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
    <xsl:param name="pageID"/>
    <table style="margin-top: 2mm; width: auto">
      <tr>
        <td class="nowrap" style="width: 10mm;">���</td>
        <td>

          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$INN"/>
            <xsl:with-param name="size" select="12"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
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
            <xsl:with-param name="symbol">&#160;</xsl:with-param>
          </xsl:call-template>
        </td>
        <td class="nowrap" style="width: 10mm; text-align: center;">���.</td>
        <xsl:call-template name="pageNum">
          <xsl:with-param name="symbol" select="0"/>
          <xsl:with-param name="alignRight">true</xsl:with-param>
          <xsl:with-param name="pageID" select="$pageID"/>
        </xsl:call-template>
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
      <xsl:if test="���">
        <xsl:apply-templates select="���"/>
      </xsl:if>
      <xsl:if test="not(���)">
        <tr>
          <td>
            <xsl:call-template name="breakStr">
              <xsl:with-param name="size" select="20"/>
              <xsl:with-param name="line" select="3"/>
              <xsl:with-param name="symbol">-</xsl:with-param>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>

      <tr>
        <td class="podpis">
          (�������, ���, ��������* ���������)
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
              <td align="center">
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
              <td class="text-right" width="50%">
                � �����������<br/>������������������������<br/> ��� �� ����� ��
              </td>
              <td align="center">
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
        <td class="podpis">�������, �.�.*</td>
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

  <xsl:template match="�������">
    <tr>
      <td>��� �� �����</td>
      <td class="text-center">020</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�����"/>
          <xsl:with-param name="size" select="11"/>
          <xsl:with-param name="symbol" select="0"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� ������� ������ �� ��������� �����,<br/>
        ���������� ������ �� ��������� ������ (���.)<br/>
        <span class="explanation">
          (���. 060 ������� 3 � (����� ����� 100 ���� ��������<br/>
          2 �� ������� ���� ����� / ���. 010 ������� 3))
        </span>
      </td>
      <td class="text-center" valign="center">030</td>
      <td valign="center">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�����"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="nullIsPrinted" select="boolean(false)"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="outOkun">
    <table>
      <tr>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="1"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="2"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="3"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="4"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="5"/>
          </xsl:call-template>
        </td>
        <td width="16%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="6"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <xsl:param name="num"/>
    <table>
      <!--������� 6 x 6-->
      <xsl:call-template name="OutStrRecursiveOkun">
        <!--�������� ����� ������� ������� ������ $num (�������� 1 � 1+6, 2 � 2+6)-->
        <xsl:with-param name="node" select="$node/����[position() - $num =  6 * ( ceiling(position() div 6) - 1) ]"/>
      </xsl:call-template>
    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveOkun">
    <xsl:param name="node"/>
    <!--���������� ����� - 1-->
    <xsl:param name="count">5</xsl:param>
    <!--������� �������-->
    <xsl:variable name="pos" select="6 - $count"/>

    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$pos]"/>
          <xsl:with-param name="size" select="6"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > 0">
      <xsl:call-template name="OutStrRecursiveOkun">
        <xsl:with-param name="count" select="$count - 1"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template match="�����������">
    <tr>
      <td style="margin-top: 10mm">
        <span class="bold">����� ����� ������������� ������������������� ������������ </span>
        <span class="explanation"> (��� ���. 020)</span>
      </td>
    </tr>

    <tr>
      <td>
        <table>
          <tr>
            <td style="width: 29%">
              �������� ������
            </td>
            <td style="width: 71%">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@������"/>
                <xsl:with-param name="size" select="6"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ������� ���������� ���������<br/>
              <span style="font-size:8pt">(���)</span>
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@���������"/>
                <xsl:with-param name="size" select="2"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              �����
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@�����"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              �����
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@�����"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ���������� ����� (����, ������� �<br/>
              �.�.)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@����������"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� (��������, �������� � �.�.)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@�����"/>
                <xsl:with-param name="size" select="30"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� ���� (��������)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@���"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� ������� (��������)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@������"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td>
              ����� ����� (��������)
            </td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="@�����"/>
                <xsl:with-param name="size" select="8"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
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

  <xsl:template name="breakFactor">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"/>
    <xsl:param name="nullIsPrinted"/>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 1">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="1"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="$size"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakPartTaxBase">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 3">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="11"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="breakPercent">
    <xsl:param name="input"></xsl:param>

    <table style="width: auto; height: auto;">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test ="string-length( $input ) > 3">
                  <xsl:value-of select="substring-before( $input, '.' )"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$input"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
        <td>.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="substring-after( $input, '.' )"/>
            <xsl:with-param name="size" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>