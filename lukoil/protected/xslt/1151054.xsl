<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="no_format.xslt"/>
  <xsl:include href="counter.xslt"/>
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

    <style>
      .view_container .table-compact td
      {
      padding: 0.5pt;
      }
    </style>
    
    <!--�������� ������ � ���� ���������!-->
    <xsl:call-template name="InitCounterScript"/>
    
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>

  </xsl:template>

  <xsl:template match="��������">
    <!--�� �� ������ �� ������ �������� ���������� (�� 16.12.11)-->
    <!--��� 1151054-->
    <!--5.02-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="����"/>
    
    <!-- ���������� ������� ������� -->
    <xsl:call-template name="CountPage"/>
    
  </xsl:template>

  <xsl:template match="����">
    <!--������ 1. ����� ������, ���������� ������ � ������, �� ������ �����������������-->
    <xsl:apply-templates select="��������"/>
    <!--������ 2. ������, �������� ���������� ��� ���������� � ������ ������, �� ����������� ����-->
    <xsl:apply-templates select="���������"/>
    <!--������ 3. ����������� ��������� ������� �������� ��������� ����������� ������ �� ��������� ���������-->
    <xsl:apply-templates select="����������"/>
    <!--������ 4. ������, �������� ���������� ��� ���������� � ������ ������, ��� ������ ���� �� ������� ����-->
    <xsl:apply-templates select="�����������"/>
  </xsl:template>

  <!--��������-->

  <!--���.1_����01-->
  <xsl:template name="titlePage">

      <table class="page page-margin-narrow">
        <tr>
          <td class="page-content">
            <table>
              <xsl:call-template name="titlePageHeader"/>
              <!--���������-->
              <tr>
                <th class ="nowrap">
                  <h1>
                    ��������� ����������<br/>�� ������ �� ������ �������� ����������
                  </h1>
                </th>
              </tr>

              <tr>
                <td>
                  <table>
                    <tr>
                      <!--����� �������������-->
                      <td class="text-left nowrap" width="10%">����� �������������</td>
                      <td>
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="@�������"/>
                          <xsl:with-param name="size" select="3"/>
                        </xsl:call-template>
                      </td>
                      <!--��������� ������ (���)-->
                      <td class="text-right">��������� ������ <span class="explanation">(���)</span></td>
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
                      <td class="text-center">�������������� � ��������� ����� <span class="explanation">(���)</span></td>
                      <td>
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="@�����"/>
                          <xsl:with-param name="size" select="4"/>
                        </xsl:call-template>
                      </td>
                      <!--�� ����� ���������� (�����) (���)-->
                      <td class="text-center">�� ����� ���������� (�����) <span class="explanation">(���)</span></td>
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
                      <xsl:apply-templates select="����/����/���" mode="one_line"/>
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
                      <td class="text-right">��� ���� ������������� ������������ �� �������������� �����</td>
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
                      <!--����� �������������(����������) (���)-->
                      <td class="text-right">
                        ����� �������������<br/>(����������) <span class="explanation">(���)</span>
                      </td>
                      <td width="5%">
                        <xsl:call-template name="breakStr">
                          <xsl:with-param name="input" select="����/����/���������/@���������"/>
                          <xsl:with-param name="size" select="1"/>
                        </xsl:call-template>
                      </td>
                      <td class="text-right">���/��� ����������������<br/>�����������</td>
                      <td>
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
                      <td class="text-center">
                        <table>
                          <tr>
                            <td id="CountPage">
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
                  <table>
                    <tr>
                      <td width="50%" class="border-right border-top vertical-align-top">
                        <xsl:apply-templates select="���������"/>
                      </td>
                      <td width="50%" class="border-top vertical-align-top">
                        <xsl:call-template name="TaxWorker"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

            </table>
          </td>
        </tr>
        <tr>
          <td class="footer" >
            <xsl:call-template name="Feuilleton"/>
          </td>
        </tr>
    </table>
    
  </xsl:template>

  <!--����� �������-->
  <!--��������� ��� ������ ��������-->
  <xsl:template name="pageHeader">
    <xsl:param name="barCode"></xsl:param>
    <xsl:param name="pageID"></xsl:param>
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
                </xsl:call-template>
              </td>
              <td class="nowrap text-center" style="width: 10mm;">���.</td>

              <!-- ����� �������� -->
              <xsl:call-template name="pageNum">
                <xsl:with-param name="pageID" select="$pageID"/>
                <xsl:with-param name="alignRight">true</xsl:with-param>
                <xsl:with-param name="symbol">0</xsl:with-param>
              </xsl:call-template>
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
                <xsl:with-param name="barCode">a0100`VPQXa</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--���������� � 1-->
            <td class="text-right vertical-align-top padding-top5mm" width="40%" style="font-size: 6pt;">
              ���������� � 1 � ������� ��� �� �� 16.12.2011 � ���-7-3/928@
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
                <td class="field_text" style="width: 15%">
                  <xsl:value-of select="$docDate"/>
                </td>
                <td class="explanation" style="width: 5%">&#160;(����)</td>
                <td style="width: 25%">&#160;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <xsl:call-template name="Feuilleton"/>

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
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@���"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@��������"/>
          <xsl:with-param name="symbol">-</xsl:with-param>
          <xsl:with-param name="size" select="20"/>
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
          <b>����������� ���������� ���������� ������</b><br/><br/>�������� � ������������� ����������
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
              <td class="text-center">
                ��
              </td>
              <td class="text-center" width="20%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
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
                � �����������<br/>�������������� ����������<br/>��� �� ����� ��
              </td>
              <td width="5%"></td>
              <td width="20%">
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
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
              <td class="text-left">
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
              <td class="text-center">
                ����������������<br/>�� �
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input"/>
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
    <table class="margin-top5mm">
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


  <!--********************* ������ 1 (���� 2 ) *********************************-->

  <xsl:template match="��������">
    <xsl:call-template name="pageRecursiveR1">
      <xsl:with-param name="CountPage" select="ceiling(count(�����) div 8)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--������� �� 8 ������ �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*8 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  
  <xsl:template name="pageR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPRUa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 class="margin-top5mm">
                  ������ 1. ����� ������, ���������� ������ � ������
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="42%">����������</td>
                    <td width="5%">���<br/>������</td>
                    <td width="53%">�������� �����������</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>

                  <!-- ������� �����-->
                  <xsl:call-template name="OutStrRecursiveR1">
                    <xsl:with-param name="node" select="$node/�����"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>

                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>
    
    
  </xsl:template>

  <xsl:template name="OutStrRecursiveR1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 8) * 8"/>

    <tr>
      <td>��� ��������� �������������</td>
      <td class="text-center">010</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@���"/>
          <xsl:with-param name="size" select="20"/>
        </xsl:call-template>
      </td>
    </tr>
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
      <td>����� ������, ���������� ������ � ������ (���.)</td>
      <td class="text-center">030</td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@�����"/>
          <xsl:with-param name="size" select="15"/>
          <xsl:with-param name="nullIsPrinted"></xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>&#160;</td>
    </tr>
    
    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--********************* ������ 2 (���� 3 ) *********************************-->
  <xsl:template match="���������">
    <xsl:call-template name="pageRecursiveR2">
      <xsl:with-param name="CountPage" select="ceiling(count(������/��������) div 3)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR2">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--������� �� 3 ����� �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR2">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*3 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR2">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR2">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPSRa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 class="margin-top5mm">
                  ������ 2. ������, �������� ���������� ��� ���������� � ������ ������, �� ����������� ����
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="42%">����������</td>
                    <td width="5%">���<br/>������</td>
                    <td width="53%">�������� �����������</td>
                  </tr>
                  <tr>
                    <td>��� ���� �������� ��������� �����������</td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="5"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>��� ��������� �������������</td>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@���"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>��� ������� ��������� ���������� �������� ��������� ����������� �� ����</td>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@����"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="30%">
                      ��� �� ����� /<br/>�����, ����� � ��� �������� ��<br/>����������� �������
                    </td>
                    <td width="15%">
                      ��� ���������<br/>���������������
                    </td>
                    <td width="40%">
                      ���������� �������� ��������� �����������,<br/>����������� ���������������
                    </td>
                    <td width="15%">
                      ��������<br/>������������ ��<br/><span class="podpis">
                        (����������� ���<br/>������ �����)
                      </span>
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1/2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <!--������� �����-->
                  <xsl:call-template name="OutStrRecursiveR2">
                    <xsl:with-param name="node" select="$node/������/��������"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="48%">����������</td>
                    <td width="7%">���<br/>������</td>
                    <td width="45%">�������� �����������</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <tr>
                    <td>��������� ������� �������� ��������� �����������</td>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@����������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>���� ���������� ��������� ������� ������������ ������� � ������� �������� ����������</td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@������������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="1"/>
                        <xsl:with-param name="decsize" select="10"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>���������� �������������� �������� ��������� �����������</td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@����������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="11"/>
                        <xsl:with-param name="decsize" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>������� �� ���������� �������� ��������� �����������</td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@����������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>��������� ����</td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@�������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>����� ���������� ������</td>
                    <td class="text-center">085</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>����� ������������ ������</td>
                    <td class="text-center">090</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input">
                          <xsl:if test="$position = 1">
                            <xsl:value-of select="$node/@���������"/>
                          </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
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
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>


  </xsl:template>

  <xsl:template name="OutStrRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 3) * 3"/>

    <tr>
      <td class="vertical-align-top">
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@�����"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
        <table style="width: auto; margin-top: 2pt;">
          <tr>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@����������"/>
                <xsl:with-param name="size" select="3"/>
              </xsl:call-template>
            </td>
            <td width="3%"></td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@����������"/>
                <xsl:with-param name="size" select="5"/>
              </xsl:call-template>
            </td>
            <td width="3%"></td>
            <td>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="$node[$position]/@����������"/>
                <xsl:with-param name="size" select="2"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </td>
      <td colspan="2">
        <xsl:call-template name="outColR2">
          <xsl:with-param name="node" select="$node[$position]"/>
        </xsl:call-template>
      </td>
      <!--
      <td class="vertical-align-top">
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@������"/>
          <xsl:with-param name="size" select="1"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
      -->
      <td>
        <xsl:call-template name="outColKoefR2">
          <xsl:with-param name="node" select="$node[$position]"/>
        </xsl:call-template>
      </td>
    </tr>
    
    <tr>
      <td colspan="5"></td>
    </tr>

    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="outColR2">
    <xsl:param name="node"/>
    <!-- ������� ��������� ���� 5 ����� ���� ����������-->
    <table>
      <xsl:call-template name="outColRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="count">
          <xsl:choose>
            <xsl:when test="count($node/���������) > 5">
              <xsl:value-of select="count($node/���������)"/>
            </xsl:when>
            <xsl:otherwise>
              5
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template> 
    </table>
  </xsl:template>

  <xsl:template name="outColRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="pos">1</xsl:param>
    <xsl:param name="count"/>

    <tr>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node/���������[$pos]/@��������"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node/���������[$pos]/@������"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > $pos">
      <xsl:call-template name="outColRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="pos" select="$pos + 1"/>
        <xsl:with-param name="count" select="$count"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--������������-->
  <xsl:template name="outColKoefR2">
    <xsl:param name="node"/>
    <!-- ������� ��������� ���� 5 ����� ���� ����������-->
    <table>
      <xsl:call-template name="outColKoefRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="count">
          <xsl:choose>
            <xsl:when test="count($node/����) > 5">
              <xsl:value-of select="count($node/����)"/>
            </xsl:when>
            <xsl:otherwise>
              5
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </table>
  </xsl:template>

  <xsl:template name="outColKoefRecursiveR2">
    <xsl:param name="node"/>
    <xsl:param name="pos">1</xsl:param>
    <xsl:param name="count"/>

    <tr>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node/����[$pos]"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>

    <xsl:if test="$count > $pos">
      <xsl:call-template name="outColKoefRecursiveR2">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="pos" select="$pos + 1"/>
        <xsl:with-param name="count" select="$count"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  

  <!--********************* ������ 3 (���� 4 ) *********************************-->

  <xsl:template match="����������">
    <xsl:call-template name="pageRecursiveR3">
      <xsl:with-param name="CountPage" select="ceiling(count(�������������/�������������) div 7)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR3">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--������� �� 7 ������ �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR3">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*7 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR3">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPTYa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--������ 3 � 3.1-->
            <tr>
              <td>
                <xsl:if test="$position = 1">
                  <xsl:call-template name="outTable3.1">
                    <xsl:with-param name="node" select="$node"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            
            <!--������ 3.2-->
            <tr>
              <td class="bold text-center padding-top5mm">
                <!--������ ��� ���� ������� ����� ������-->
                <xsl:if test="$position != 1">
                  <div style="margin-top: 50mm"></div>
                </xsl:if>
                3.2. ����������� ����� �������� �� ��������� ������� �������� ����������
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="50%">��� ������� ��������� ���������� �� ����<span class="podpis">(������ 110)</span></td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="$node/�������������/@����"/>
                        <xsl:with-param name="size" select="3"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
           
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center italic explanation" >
                    <td width="14%">
                      ��� ��������<br/>���������<br/>�����������
                    </td>
                    <td width="38%">
                      ���������� ��������<br/>��������� �����������
                    </td>
                    <td width="17%">
                      ���� ��������<br/>��������� �����������<br/>� ����� ����������<br/>������� ��������<br/>����������
                    </td>
                    <td width="31%">
                      ����� �������� �� ������ ���������<br/>����������� (���.)
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR3">
                    <xsl:with-param name="node" select="$node/�������������/�������������"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable3.1">
    <xsl:param name="node"/>
    <table>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          ������ 3. ����������� ��������� ������� �������� ��������� ����������� ������ �� ��������� ���������
        </td>
      </tr>
      <tr>
        <td class="text-right italic explanation" colspan="3">
          ������ 3 ����������� � ���������� � ������ ��������� ����������<br/>
          ������ � ������ ������ ��������� ������-���� �������� ���������<br/>
          ����������� ������ �� ��������� ���������
        </td>
      </tr>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          3.1. ����������� ����� ����� �������� �� ������ �������� ����������
        </td>
      </tr>
      <tr class="text-center italic" >
        <td width="50%">����������</td>
        <td width="10%">���<br/>������</td>
        <td width="40%">�������� �����������</td>
      </tr>
      <tr>
        <td>
          ������ ������� �� ������ �������� ����������,<br/>������������� � ��������� �������
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ������� �������������� ������������ �� ������<br/>���������� �������
        </td>
        <td class="text-center">020</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@�����������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ������� �������������� ������������ �� �����<br/>��������� �������
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@�����������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">����� ������ ��������, ����������� � ������� �<br/>��������� ������� �������� ����������</div>
          <div class="podpis text-left">(���.010 + ���.020 - ���.030)</div>
        </td>
        <td class="text-center">040</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����������������� �������, ����������� � �������<br/>�������� ���������� (� ������������ � ����������� 6, 7<br/>������ 4 ������ 340 ��)
        </td>
        <td class="text-center">050</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@��������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ��������� �������, ����������� � ������� ��������<br/>����������
        </td>
        <td class="text-center">060</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@�����������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ��������� �������, ��������� � ������� ��������<br/>���������� � ������� ������ ������������
        </td>
        <td class="text-center">070</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@����������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          ����� ����� ������ ��������, ������������� � �������<br/>���������� ������� �� ���� ����� ������������
        </td>
        <td class="text-center">080</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">
            ����� ��������� � ���� ��������, ����������� �<br/>������� � ��������� ������� �������� ����������
          </div>
          <div class="podpis text-left">(���.050 + ���.060 + ���.070 � ���.010 : ���. 080)</div>
        </td>
        <td class="text-center">090</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@�������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          <div class="bold">
            ����� ����� �������� �� ������ ��������<br/>����������, ������������� � ��������� �������
          </div>
          <div class="podpis text-left">(���.040 + ���.090)</div>
        </td>
        <td class="text-center">100</td>
        <td>
          <xsl:call-template name="breakDecimal">
            <xsl:with-param name="input" select="$node/�������������/@�������������"/>
            <xsl:with-param name="size" select="15"/>
            <xsl:with-param name="decsize" select="2"/>
            <xsl:with-param name="nullIsPrinted"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>

    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveR3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 7) * 7"/>

    <tr align="center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@������"/>
          <xsl:with-param name="size" select="5"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@��������"/>
          <xsl:with-param name="size" select="11"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@�������������"/>
          <xsl:with-param name="size" select="1"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@������������"/>
          <xsl:with-param name="size" select="13"/>
          <xsl:with-param name="decsize" select="2"/>
          <xsl:with-param name="nullIsPrinted"></xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>

    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR3">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--********************* ������ 4 (���� 5,6,7 ) *********************************-->
  <xsl:template match="�����������">
    <!--�������� ������ 4.1 ���������� � ������� �� 10 �� �����-->
    <xsl:call-template name="pageRecursiveR4.1">
      <xsl:with-param name="CountPage" select="ceiling(count(��������/����������) div 10)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
    
    <!--4.2-->
    <xsl:apply-templates select="����������"/>

    <!--4.3-->
    <xsl:apply-templates select="����������"/>
  </xsl:template>

  <!--4.1-->
  
  <xsl:template name="pageRecursiveR4.1">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--������� �� 10 ������ �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR4.1">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*10 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR4.1">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR4.1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPUVa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <!--������ 4 -->
            <tr>
              <td>
                <xsl:if test="$position = 1">
                  <xsl:call-template name="outTable4">
                    <xsl:with-param name="node" select="$node"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td class="bold text-center padding-top5mm">
                4.1. ������ � ���������� �������� ��������� ����������� �� ������� ����
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="33%" rowspan="2">
                      ��� �� ����� /<br/>��� ���� �������� ��������� �����������
                    </td>
                    <td colspan="2">
                      ���������� �������� ��������� �����������, ����������� ���������������:<br/>
                      �� ��������� ������ 0% (������) /<br/>
                      �� ����������������� ������
                    </td>
                  </tr>
                  <tr class="text-center italic">
                    <td>
                      ��� ��������� ���������������
                    </td>
                    <td>
                      ����������
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1/2</td>
                    <td width="27%">3/4</td>
                    <td width="40%">5/6</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR4.1">
                    <xsl:with-param name="node" select="$node/��������/����������"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <table>
      <tr>
        <td class="bold text-center padding-top5mm" colspan="3">
          ������ 4. ������, �������� ���������� ��� ���������� � ������ ������, ��� ������ ���� �� ������� ����
        </td>
      </tr>
      <tr class="text-center italic" >
        <td width="47%">����������</td>
        <td width="3%">
          ���<br/>������
        </td>
        <td width="50%">�������� �����������</td>
      </tr>
      <tr>
        <td>
          ��� ��������� �������������
        </td>
        <td class="text-center">010</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$node/@���"/>
            <xsl:with-param name="size" select="20"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          �����, ����� � ��� �������� �� ����������� �������
        </td>
        <td class="text-center">020</td>
        <td>
          <table style="width: auto; margin-top: 2pt;">
            <tr>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@����������"/>
                  <xsl:with-param name="size" select="3"/>
                </xsl:call-template>
              </td>
              <td width="3%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@����������"/>
                  <xsl:with-param name="size" select="5"/>
                </xsl:call-template>
              </td>
              <td width="3%"></td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="$node/@����������"/>
                  <xsl:with-param name="size" select="2"/>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          ��� ������� ��������� ���������� �������� ���������<br/>����������� �� ����
        </td>
        <td class="text-center">030</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="$node/@����"/>
            <xsl:with-param name="size" select="3"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template name="OutStrRecursiveR4.1">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 10) * 10"/>

    <tr align="center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@�����"/>
          <xsl:with-param name="size" select="11"/>
        </xsl:call-template>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@������"/>
          <xsl:with-param name="size" select="5"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/������_0/@��������"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/���������/@��������"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/������_0/@������"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/���������/@������"/>
          <xsl:with-param name="size" select="12"/>
          <xsl:with-param name="decsize" select="3"/>
        </xsl:call-template>
      </td>
    </tr>

    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR4.1">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--4.2-->
  <xsl:template match="����������">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPVSa</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="text-center bold padding-top5mm">
                4.2. ������ ����� ������, ���������� ������ � ������, �� ������� ����
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="50%">����������</td>
                    <td width="10%">
                      ���<br/>������
                    </td>
                    <td width="40%">�������� �����������</td>
                  </tr>
                  <tr>
                    <td>
                      ������� ���������� ��� ����������� ���������� ������<br/>�������� �� ������ ���������� �������
                    </td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@���������"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ��������, �������������� (����������)<br/>
                      ������������������ � ��������� ������� � ��������� �<br/>
                      ������������ ���������� ������� � ������ ����� ���<br/>
                      ������ ���� � ������� ��������� ������� �����<br/>
                      <span class="explanation">(���.030+���.040+���.050)</span>
                    </td>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="���������/@�����������"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      � ��� �����:<br/><br/>������������ �������
                    </td>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="���������/@�������"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      ������� ����������������� �� ������������ � (���)<br/>�������� ��������������� ���������
                    </td>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="���������/@����������"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="padding-left5mm">
                      �������, �������������� (����������)<br/>
                      ������������������ � ������� ���������,<br/>
                      ��������������, �������������, ������������,<br/>
                      ������������ �������������� �������� ��������<br/>�������
                    </td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="���������/@���������"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="decsize" select="2"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ��������, �������������� (����������)<br/>
                      ������������������ � ��������� � ������������<br/>
                      ���������� ������� � ������ ����� ��� ������ ����,<br/>
                      ���������� � ��������� ����� � ����������� �����<br/>
                      ������ �� ��������� ������, �� �����������<br/>
                      ���������� �������� ���������� ������<br/>
                      <span class="explanation">(���.010 + ���.020 &lt;= ���.090)</span>
                    </td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@���������"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      �������� ������������ ��
                      <span class="explanation">(�� &lt;= 0.3)</span>
                    </td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakDecimal">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="1"/>
                        <xsl:with-param name="decsize" select="4"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ������, ������������ ��� ������ ���� �� �������<br/>���� �� ��������� ������
                    </td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@����������"/>
                        <xsl:with-param name="size" select="15"/>
                        <xsl:with-param name="nullIsPrinted"></xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ���������� �������� ���������� ������
                      <span class="explanation">(���.080 � ���.070)</span>
                    </td>
                    <td class="text-center">090</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@����������"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ������, ������������ ��� ������ ���� �� ������<br/>
                      ������� ���� �� ��������� ������ � ������ ����������<br/>
                      ������, ���������� ������<br/>
                    </td>
                    <td class="text-center">100</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@������������"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ������� ���������� ��� ����������� ���������� ������<br/>
                      ��������, �������������� (����������)<br/>
                      ������������������ � ��������� � ������������<br/>
                      ���������� ������� � ������ ����� ��� ������ ����, ��<br/>
                      ����� ���������� �������<br/>
                      <span class="explanation">(���.010 + ���.020 - ���.060)</span>
                    </td>
                    <td class="text-center">110</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="@���������"/>
                        <xsl:with-param name="size" select="15"/>
                      </xsl:call-template>
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
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
            
  </xsl:template>


  <!--4.3-->
  <xsl:template match="����������">
    <!--�������� ������ 4.3 ���������� � ������� �� 4 �� �����-->
    <xsl:call-template name="pageRecursiveR4.3">
      <xsl:with-param name="CountPage" select="ceiling(count(������������) div 4)"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="pageRecursiveR4.3">
    <xsl:param name="CountPage"/>
    <xsl:param name="NumPage">1</xsl:param>
    <xsl:param name="node"/>

    <!--������� �� 4 ����� �� ��������-->
    <!--��������� ��������-->
    <xsl:call-template name="pageR4.3">
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="position" select="($NumPage - 1)*4 + 1"/>
      <xsl:with-param name="last" select="$CountPage - $NumPage"/>
    </xsl:call-template>

    <xsl:if test="$CountPage > $NumPage">
      <xsl:call-template name="pageRecursiveR4.3">
        <xsl:with-param name="NumPage" select="$NumPage + 1"/>
        <xsl:with-param name="CountPage" select="$CountPage"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pageR4.3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>
    <xsl:param name="last"/>
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">a0100`VPWPa</xsl:with-param>
                  <xsl:with-param name="pageID" select="$position"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td class="bold text-center padding-top5mm">
                4.3. ������ ����� ��������� ������� �� ������� ����
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="57%">����������</td>
                    <td width="6%">
                      ���<br/>������
                    </td>
                    <td width="47%">�������� �����������</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <xsl:call-template name="OutStrRecursiveR4.3">
                    <xsl:with-param name="node" select="$node/������������"/>
                    <xsl:with-param name="position" select="$position"/>
                  </xsl:call-template>
                </table>
              </td>
            </tr>

          </table>
        </td>
      </tr>
      <tr>
        <td class="footer">
          <xsl:call-template name="Feuilleton"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutStrRecursiveR4.3">
    <xsl:param name="node"/>
    <xsl:param name="position"/>

    <xsl:variable name="pos" select="$position - floor($position div 4) * 4"/>

    <tr>
      <td>
        ����� � ��� ������������� ����� �� ��������� �����
      </td>
      <td class="text-center">
        010
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@�������������"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� ���������� ������, �������������� �� ����� � ���, ��������� �<br/>������ 010
      </td>
      <td class="text-center">
        020
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@���������"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� ���������� ������, �������������� � ���������� ���������<br/>�������
      </td>
      <td class="text-center">
        030
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@����������"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� ���������� ������, �������������� � ��������� �������
      </td>
      <td class="text-center">
        040
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@���������"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ������� ����� ���������� ������ �� ����� ���������� �������<br/>
        (���.020 - ���.030 - ���.040)
      </td>
      <td class="text-center">
        050
      </td>
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="$node[$position]/@������������"/>
          <xsl:with-param name="size" select="15"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td>
        ����� � ��� ��������� ����� �� ��������� �����
      </td>
      <td class="text-center">
        060
      </td>
      <td>
        <xsl:call-template name="breakDecimal">
          <xsl:with-param name="input" select="$node[$position]/@�������������"/>
          <xsl:with-param name="size" select="2"/>
          <xsl:with-param name="decsize" select="4"/>
        </xsl:call-template>
      </td>
    </tr>
    <tr>
      <td colspan="3">&#160;</td>
    </tr>

    <!--�������� ���������� ��������� ������-->
    <xsl:if test="$pos !=0">
      <xsl:call-template name="OutStrRecursiveR4.3">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="position" select="$position + 1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!--�����-->
  <xsl:template name="breakDecimal">
    <xsl:param name="input"/>
    <xsl:param name="size">12</xsl:param>
    <xsl:param name="decsize">2</xsl:param>
    <xsl:param name="decZeroPrinted">0</xsl:param>
    <xsl:param name="nullIsPrinted">0</xsl:param>
    <table style="width:auto">
      <tr>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:choose>
                <xsl:when test="contains($input,'.')">
                  <xsl:value-of select="substring(substring-before($input,'.'), 1, $size)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring($input, 1, $size)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="size" select="$size"/>
            <xsl:with-param name="nullIsPrinted" select="$nullIsPrinted"/>
          </xsl:call-template>
        </td>
        <td style="width: 4mm" class="text-center">.</td>
        <td>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input">
              <xsl:value-of select="substring(substring-after($input,'.'), 1, $decsize)"/>
            </xsl:with-param>
            <xsl:with-param name="size" select="$decsize"/>
            <!--<xsl:with-param name="symbol" select="$decZeroPrinted"/>-->
            <xsl:with-param name="nullIsPrinted" select="$decZeroPrinted"/>
          </xsl:call-template>
        </td>
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