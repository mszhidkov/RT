<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="breakStr.xslt"/>
  <xsl:include href="counter.xslt"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>

  <!--���������� ���, ���, ���� ���������-->
  <xsl:variable name="Kpp" select="����/��������/����/����/@���"/>
  <xsl:variable name="Inn">
    <xsl:value-of select="����/��������/����/����/@�����"/>
    <xsl:value-of select="����/��������/����/����/@�����"/>
  </xsl:variable>
  <xsl:variable name="docDate" select="����/��������/@�������"/>
  
  <xsl:template match="/">
    <xsl:call-template name="InitStyles"/>
    <style>
      .view_container .table-compact td
      {
      padding: 0pt;
      }
    </style>

    <!--�������������� ������ ��������-->
    <xsl:call-template name="InitCounterScript"/>
    
    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates/>
    </div>

  </xsl:template>

  <xsl:template match="��������">
    <!--��������� ���������� �� ������ �� ����������� ��������� (�� 15.10.09)-->
    <!--��� 1151001-->
    <!--NO_NDS-->

    <xsl:call-template name="titlePage"/>
    <xsl:apply-templates select="���"/>

  </xsl:template>

  <xsl:template match="���">
    <!--������ 1: ����� ������,���������� ������ � ������ (���������� �� �������),�� ������ �����������������-->
    <xsl:apply-templates select="��������"/>
    <!--������ 2. ����� ������, ���������� ������ � ������, �� ������ ���������� ������.-->
    <xsl:apply-templates select="��������"/>
    <!--������ 3. ������ ����� ������, ���������� ������ � ������ �� ���������,���������� �� ��������� �������, 
    ��������������� �������� 2-4 ������ 164 ���������� ������� ���������� ���������-->
    <xsl:apply-templates select="������164"/>
    <!--���������� � 1 � ������� 3 ����������* ����� ���, ���������� �������������� � ������ � ������ �� �������� ��� � ���������� �������� ����-->
    <xsl:apply-templates select="������164/���������"/>
    <!--���������� � 2 � ������� 3 ����������* ������ ����� ������, ����������� �� ��������� �� ���������� ������� (�����, �����)...-->
    <xsl:apply-templates select="������164/��������"/>
    <!--������ 4. ������ ����� ������ �� ��������� �� ���������� ������� (�����, �����), �������������� ���������� ��������� ������ 0 ��������� �� ������� ������������� ������������ -->
    <xsl:apply-templates select="��������0"/>
    <!--������ 5. ������ ����� ��������� ������� �� ��������� �� ���������� ������� (�����, �����), �������������� ���������� ��������� ������ 0 ��������� �� ������� ����� ������������� ������������ (�� ������������) -->
    <xsl:apply-templates select="����������0"/>
    <!--������ 6. ������ ����� ������ �� ��������� �� ���������� ������� (�����, �����), ������������� ��������� ������ 0 ��������� �� ������� ������������� �� ������������ -->
    <xsl:apply-templates select="����������0"/>
    <!--������ 7. ��������, �� ���������� ��������������� (������������� �� ���������������); ��������, �� ������������ �������� ���������������; �������� �� ���������� ������� 
    (�����, �����), ������ ���������� ������� �� ���������� ���������� ���������� ���������; � ����� ����� ������, ��������� ������ � ���� ����������� �������� ������� (���������� �����, �������� �����), 
    ������������ ����������������� ����� ������������ ������� ���������� ����� ����� ������� -->
    <xsl:apply-templates select="���������"/>
    <!-- ���������� ������� ������� -->
    <xsl:call-template name="CountPage"/>

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
                    ��������� ����������<br/> �� ������ �� ����������� ���������
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
                      <td class="text-center">
                        <table>
                          <tr>
                            <td>
                              <xsl:call-template name="breakStr">
                                <xsl:with-param name="input"/>
                                <xsl:with-param name="size" select="3"/>
                              </xsl:call-template>
                            </td>
                          </tr>
                        </table>
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
                    <img src="http://testotchet.rus-telecom.ru/images/accounting/forms/fns/no_nds/5_03/print/{$barCode}" />
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
                <xsl:with-param name="barCode">titular.png</xsl:with-param>
                <xsl:with-param name="pageNum">1</xsl:with-param>
              </xsl:call-template>
            </td>
            <!--���������� � 1-->
            <td class="podpis text-right" width="260" style="padding-top: 4mm; padding-right: 4mm; padding-bottom: 0;">
              ���������� � 1 � ������� ������� �� <br/>�� 15.10.09 � 104�
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
                � �����������<br/>��������������<br/>���������� � (���) �� ����� ��
              </td>
              <td class="text-center">
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
    <table style="vertical-align: bottom">
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


  <!--********************* ������ 1 (���� 2) *********************************-->
  <xsl:template match="��������">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter1.png</xsl:with-param>
                  <xsl:with-param name="pageNum">2</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <th class ="nowrap">
                <h2 style="margin-top: 10mm;">
                  ������ 1. ����� ������,<br/>���������� ������ � ������(���������� �� �������),<br/>�� ������ �����������������
                </h2>
              </th>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic" >
                    <td width="40%">����������</td>
                    <td width="5%">��� ������</td>
                    <td width="55%">�������� �����������</td>
                  </tr>
                  <tr>
                    <td style="padding-top:5mm;">��� �� �����</td>
                    <td>010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="11"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">��� ��������� �������������</td>
                    <td>020</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@���"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">����� ������, ����������� � ������ � ������ ������������� � ������� 5 ������ 173 ����������������� ���������� ��������� (���.)</td>
                    <td>030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�����_173.5"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">
                      ����� ������, ����������� � ������ � ������ � ������������ � ������� 1 ������ 173 ����������������� ���������� ��������� (���.)
                      <span class="explanation italic">(�������� ������� ����� ����� 230 ������� 3, 020 ������� 6 ������ ����� 240 ������� 3, 010 ������� 4, 010 ������� 5 (�����3), 010 ������� 5 (����� 5), 030 ������� 6 ������ ��� ���������)</span>
                    </td>
                    <td>040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="@�����_173.1 >= 0">
                            <xsl:value-of select="@�����_173.1"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">
                      ����� ������, ����������� � ���������� �� �������� ������������ � ������� 1 ������ 173 ����������������� ���������� ��������� (���.)
                      <span class="explanation italic">(�������� ������� ����� ����� 230 ������� 3, 020 ������� 6 ������ ����� 240 ������� 3, 010 ������� 4, 010 ������� 5 (�����3), 010 ������� 5 (����� 5), 030 ������� 6 ������ ����)</span>
                    </td>
                    <td>050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@�����_173.1 >= 0)">
                            <xsl:value-of select="substring-after(@�����_173.1,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>
   
   
  </xsl:template>


  <!--********************* ������ 2 (���� 3) *********************************-->
  <xsl:template match="��������">
    <div class="page-break">&#160;</div>
    
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter2.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class="bold text-center" style="margin-top: 10mm;">
                ������ 2. ����� ������, ���������� ������ � ������,<br/>�� ������ ���������� ������
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center" >
                    <td width="40%">
                      <i>����������</i>
                    </td>
                    <td width="5%">
                      <i>��� ������</i>
                    </td>
                    <td width="55%">
                      <i>�������� �����������</i>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:5mm;">��� ������������� ����������� �����������, ��������� �� ����� � ��������� �������</td>
                    <td>010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="9"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">������������ �����������������-��������</td>
                    <td>020</td>
                    <td>
                      <xsl:apply-templates select="����������"/>
                      <xsl:apply-templates select="����������/�������"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">��� ����������������� - ��������</td>
                    <td>030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:value-of select="����������/@���������"/>
                          <xsl:value-of select="����������/@���������"/>
                        </xsl:with-param>
                        <xsl:with-param name="size" select="string-length(����������/@���������) + string-length(����������/@���������)"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">��� ��������� �������������</td>
                    <td>040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@���"/>
                        <xsl:with-param name="size" select="20"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">��� �� �����</td>
                    <td>050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�����"/>
                        <xsl:with-param name="size" select="11"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">����� ������, ����������� � ������ � ������ (���.)</td>
                    <td>060</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@���������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">��� ��������</td>
                    <td>070</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�������"/>
                        <xsl:with-param name="size" select="7"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">����� ������, ����������� ��� �������� ������� (���������� �����, �������� �����, �������� ������������� ����)</td>
                    <td>080</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">����� ������, ����������� ��� ��������� ������, ��������� ������ � ���� ����������� �������� ������� (����������  �����, �������� �����, �������� ������������� ����)</td>
                    <td>090</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-top:2mm;">����� ������, ����������� ��������� ������� � ������, ��������� ������ ��� �������� ������� (����������  �����, �������� �����, �������� ������������� ����) � ���� ���� ������, ��������� ������ </td>
                    <td>100</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@�����������"/>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>

  </xsl:template>

  <xsl:template match="����������">
    <xsl:call-template name="breakStr">
      <xsl:with-param name="input" select="@��������"/>
      <xsl:with-param name="size" select="20"/>
      <xsl:with-param name="line" select="8"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="�������">
    <xsl:call-template name="breakStr">
      <xsl:with-param name="input">
        <xsl:value-of select="@�������"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@���"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@��������"/>
      </xsl:with-param>
      <xsl:with-param name="size" select="20"/>
      <xsl:with-param name="line" select="8"/>
      <xsl:with-param name="symbol">-</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--********************* ������ 3 (���� 4) *********************************-->
  <xsl:template match="������164">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class ="nowrap bold text-center">
                ������ 3. ������ ����� ������, ���������� ������ � ������ �� ���������,<br/>���������� �� ��������� �������, ��������������� �������� 2-4 ������ 164<br/>���������� ������� ���������� ���������
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact" style="font-size: 8pt">
                  <tr class="text-center italic">
                    <td width="36%">���������������� �������</td>
                    <td width="4%">��� ������</td>
                    <td width="28%">��������� ���� (���.)</td>
                    <td width="4%">������ ���</td>
                    <td width="28%">����� ��� (���.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <tr>
                    <td rowspan="4">1. ���������� (�������� ��� ����������� ����) ������� (�����, �����), �������� ������������� ���� �� ��������������� ������� ������, �����</td>
                    <td class="text-center">010</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������18/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������18/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">020</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������10/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">10%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������10/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">030</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������118/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18/118</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������118/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td class="text-center">040</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������110/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">10/110</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�������110/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>2. ���������� ����������� � ����� ��� �������������� ���������</td>
                    <td class="text-center">050</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/����������/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/����������/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>3. ���������� �����������-��������� ����� ��� ������������ �����������</td>
                    <td class="text-center">060</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/���������/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-center">18%</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/���������/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>4. ����� ���������� ������, ��������� ������ � ���� ����������� �������� ������� (���������� �����, �������� �����), �������� ������������� ����</td>
                    <td class="text-center">070</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�����������/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�����������/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>5. �����, ��������� � ��������� �� ������ ���������������� ������� (�����, �����)</td>
                    <td class="text-center">080</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/����������/@�������"/>
                      </xsl:call-template>
                    </td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/����������/@������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>6.����� ������, ���������� ��������������, �����:</td>
                    <td class="text-center">090</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�����������/@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>� ��� �����</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>6.1. ����� ������, ���������� �������������� ��� ���������� ��������, ���������� �� ��������� ������ 0 ���������</td>
                    <td class="text-center">100</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�����������/@����������0"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>6.2. ����� ������, ���������� �������������� � ������������ � ���������� 3 ������ 3 ������ 170 ���������� ������� ���������� ���������</td>
                    <td class="text-center">110</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/�����������/@������170"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>7. ����� ����� ���, ����������� � ������ �������������� ���� ������ (����� ������� ����� 5 ����� 010 - 090)</td>
                    <td class="text-center">120</td>
                    <td></td>
                    <td></td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/@�����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact" style="font-size: 8pt">
                  <tr class="text-center italic">
                    <td width="68%">��������� ������</td>
                    <td width="4%">��� ������</td>
                    <td width="28%">����� ��� (���.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <tr>
                    <td>8. ����� ������, ������������� ����������������� ��� ������������ �� ���������� ���������� ��������� ������� (�����, �����), ������������� ����, ���������� ������ � ������������ � ������� 2 ������ 171 ���������� ������� ���������� ���������, � ����� ����� ������, ���������� ������ � ������������ � ������� 5 ������ 171 ���������� ������� ���������� ���������</td>
                    <td class="text-center">130</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/������171/@������171���"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>8.1.� ��� ����� ������������� ���������� ������������� (�����������-�������������) �� ����������� ������� ��� ���������� ������������ �������������</td>
                    <td class="text-center">140</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/������171/@������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>9. ����� ������, ������������� ����������������� - ���������� ��� ������������ ����� ������, ��������� ������ � ���� ����������� �������� ������� (���������� �����, �������� �����), �������� ������������� ����, ���������� ������ � ����������</td>
                    <td class="text-center">150</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/@������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>10. ����� ������, ����������� ��� ���������� �����������-��������� ����� ��� ������������ �����������, ���������� ������</td>
                    <td class="text-center">160</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/@���������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>11. ����� ������, ���������� ������������������ ��� ����� ������� �� ���������� ���������� ���������� ���������, ���������� ������, �����</td>
                    <td class="text-center">170</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/�����������/@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>� ��� �����:</td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>11.1. ���������� ������� �� �������, ��������� � ���������� ������� ������� ��� ����������� �����������, ���������� ����� � ����������� ��� ���������� ����������</td>
                    <td class="text-center">180</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/�����������/@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>11.2. ��������� ������� ��� ����� ������� � ���������� ���������� ��������</td>
                    <td class="text-center">190</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/�����������/@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>12. ����� ������, ����������� ��������� � ���� ������, ��������� ������, ���������� ������ � �������� � ���� �������� ��������������� ������� (���������� �����, �������� �����)</td>
                    <td class="text-center">200</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/@����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>13. ����� ������, ���������� � ������ ������������������ � �������� ���������� - ���������� ������, ���������� ������</td>
                    <td class="text-center">210</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/@�����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      14. ����� ����� ���, ���������� ������ <span class="explanation">(����� �������, ��������� � ������� 130, 150-170, 200, 210)</span>
                    </td>
                    <td class="text-center">220</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="���������/@���������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      15. ����� ����� ���, ����������� � ������ � ������ �� ������� ������� <span class="explanation">(�������� ������� ����� 120, 220 ������ ��� ����� ����)</span>
                    </td>
                    <td class="text-center">230</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="@�����164>=0" >
                            <xsl:value-of select="@�����164"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      16. ����� ����� ���, ����������� � ���������� �� ������� ������� <span class="explanation">(�������� ������� ����� 120, 220 ������ ����)</span>
                    </td>
                    <td class="text-center">240</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@�����164>=0)" >
                            <xsl:value-of select="substring-after(@�����164,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>
      
  </xsl:template>

  <!--********************* ���������� 1 � ������� 3 (���� 5) *********************************-->

  <xsl:template match="���������">
    <div class="page-break">&#160;</div>

    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3_app1.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class="text-right bold">
                <br/>���������� � 1 � ������� 3 ����������*
              </td>
            </tr>
            <tr>
              <td class ="text-center nowrap bold">
                ����� ���, ���������� �������������� � ������ � ������<br/>
                �� �������� ��� � ���������� �������� ����
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <td width="20%">
                    ������������ ������� ������������<br/><span class="explanation italic">(��� ������ 010)</span>
                  </td>
                  <td width="80%">
                    <xsl:call-template name="breakStr">
                      <xsl:with-param name="input" select="@��������"/>
                      <xsl:with-param name="size" select="33"/>
                      <xsl:with-param name="line" select="3"/>
                      <xsl:with-param name="symbol">-</xsl:with-param>
                    </xsl:call-template>
                  </td>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                ����� ��������������� ������� ������������ <span class="explanation italic">(��� ������ 020)</span>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="20%">�������� ������</td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="��������/@������"/>
                        <xsl:with-param name="size" select="5"/>
                      </xsl:call-template>
                    </td>
                    <td class="text-right">������� ���������� ��������� (���)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="��������/@���������"/>
                        <xsl:with-param name="size" select="2"/>
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
                    <td width="20%">�����</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="��������/@�����"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>�����</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="��������/@�����"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>���������� ����� (����, ������� � �.�.)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="��������/@����������"/>
                        <xsl:with-param name="size" select="33"/>
                        <xsl:with-param name="symbol">-</xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>����� (��������, �������� � �.�.)</td>
                    <td>
                      <xsl:call-template name="breakStr">
                        <xsl:with-param name="input" select="��������/@�����"/>
                        <xsl:with-param name="size" select="33"/>
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
                  <td>
                    ����� ����<br/>(��������)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="��������/@���"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                  <td>
                    ����� �������<br/>(��������)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="��������/@������"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                  <td>
                    ����� ��������<br/>(�����)
                  </td>
                  <td>
                    <xsl:call-template name="breakStrNum12">
                      <xsl:with-param name="input" select="��������/@�����"/>
                      <xsl:with-param name="size" select="8"/>
                    </xsl:call-template>
                  </td>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="75%">
                      ��� �������� �� ������� ������������ <span class="explanation italic">(��� ������ 030)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum12">
                        <xsl:with-param name="input" select="@���������"/>
                        <xsl:with-param name="size" select="7"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ���� ����� ������� ������������ � ������������ ��� ���������� ����������� <span class="explanation italic">(��� ������ 040)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="@����������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ���� ������ ���������� ��������������� ���������� �� ������� ������������ <span class="explanation italic">(��� ������ 050)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakDate">
                        <xsl:with-param name="input" select="@������������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ��������� ������� ������������ �� ���� ����� ������� � ������������ ��� ����� ��� (���.) <span class="explanation italic">(��� ������ 060)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      ����� ���, �������� � ������ �� ������� ������������ (���.) <span class="explanation italic">(��� ������ 070)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@��������"/>
                      </xsl:call-template>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="25%">
                      <span class="explanation">(��� ������ 080)</span><br/><br/>�� �������� ���<br/>(���������� �������� ����)
                    </td>
                    <td width="25%">
                      ���� ������ �������������<br/>������� ������������ ���<br/>��������, ���������<br/>� �.2 ��.170 ����������<br/>������� ���������� ���������
                    </td>
                    <td width="25%">
                      ���� ����������� �������<br/>(�����, �����),<br/>������������� ����, ��<br/>���������� ���, � �����<br/>��������� �������� (%)
                    </td>
                    <td width="25%">
                      ����� ���, ����������<br/>�������������� � ������ �<br/>������ �� ����������� ���<br/>(�������� ����������� ����) (���.)
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="����������"/>
                  <xsl:if test="not(����������)">
                    <tr class="text-center">
                      <td>
                        <xsl:call-template name="breakStrNum10">
                          <xsl:with-param name="input" select="''"/>
                          <xsl:with-param name="size" select="4"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakDate">
                          <xsl:with-param name="input" select="''"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakProc">
                          <xsl:with-param name="input" select="'0.0'"/>
                        </xsl:call-template>
                      </td>
                      <td>
                        <xsl:call-template name="breakStrNum10">
                          <xsl:with-param name="input" select="''"/>
                        </xsl:call-template>
                      </td>
                    </tr>
                  </xsl:if>

                </table>
              </td>
            </tr>
            <tr>
              <td>
                <sup>* �������������� ������������������ ������������ � ��������� ����������� �� ������ �� ����������� ��������� �� ������� 20 ������ ����, ���������� �� �������� ����������� �����</sup>
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

  <xsl:template match="����������">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@������"/>
          <xsl:with-param name="size" select="4"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakDate">
          <xsl:with-param name="input" select="@�������170"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakProc">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@������"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* ���������� 2 � ������� 3 (���� 6) *********************************-->
  <xsl:template match="��������">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter3_app2.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class="text-right bold">
                <br/>���������� � 2 � ������� 3 ����������
              </td>
            </tr>
            <tr>
              <td class ="text-center nowrap bold">
                ������ ����� ������, ����������� �� ��������� �� ���������� ������� (�����, �����), ��������<br/>
                ������������� ���� � ����� ������, ���������� ������, ����������� ������������, ��������������<br/>
                ������������������� ������������ �� ���������� ���������� ��������� ����� ���� �������������<br/>
                (�����������������, ���������)
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td>
                      ��� �������������<br/>����������� �����������,<br/>��������� �� ����� �<br/>��������� �������<br/>���������� ���������
                    </td>
                    <td>
                      ����� ������, ����������� ��<br/>���������, ����������<br/>��������������� (���.)
                    </td>
                    <td>����� ��������� ������� (���.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                  </tr>
                  <xsl:apply-templates select="�����������"/>

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

  <xsl:template match="�����������">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStr">
          <xsl:with-param name="input" select="@�������"/>
          <xsl:with-param name="size" select="9"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum12">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum12">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* ������ 4 (���� 7) *********************************-->
  <xsl:template match="��������0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter4.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class ="text-center nowrap bold">
                ������ 4. ������ ����� ������ �� ��������� �� ���������� ������� (�����, �����), �������������� ����������<br/>
                ��������� ������ 0 ��������� �� ������� ������������� ������������
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center italic">
                    <td width="25%">
                      <table>
                        <tr>
                          <td>
                            <i>
                              ���<br/>��������
                            </i>
                          </td>
                          <td>
                            <i>��������� ����</i>
                          </td>
                        </tr>
                      </table>
                    </td>
                    <td width="25%">
                      ��������� ������ ��<br/>���������, ��������������<br/>���������� ��������� ������<br/>0 ��������� �� �������<br/>������������� ������������
                    </td>
                    <td width="25%">
                      ����� ������, �����<br/>����������� �� ���������,<br/>�������������� ����������<br/>��������� ������ 0 ���������<br/>�� ������� ����� �� ����<br/>������������� ������������
                    </td>
                    <td width="25%">
                      ����� ������, �����<br/>�������� � ������ �<br/>���������� ��������������
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>
                      <table>
                        <tr>
                          <td>1</td>
                          <td>2</td>
                        </tr>
                      </table>
                    </td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                  </tr>
                  <xsl:apply-templates select="�������4"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr>
                    <td width="50%">
                      ����� ����� ������, ����������� � ���������� �� ������� �������<span class="italic">(��� ������ 010)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@�����������"/>
                      </xsl:call-template>
                    </td>
                    <td width="25%">&#160;</td>
                  </tr>
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

  <xsl:template match="�������4">
    <tr>
      <td>
        <xsl:value-of select="@�������"/>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@��������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@��������"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* ������ 5 (���� 8) *********************************-->

  <xsl:template match="����������0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter5.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class ="text-center nowrap bold">
                ������ 5. ������ ����� ��������� ������� �� ��������� �� ���������� ������� (�����, �����), ��������������<br/>
                ���������� ��������� ������ 0 ��������� �� ������� ����� ������������� ������������ (�� ������������)
              </td>
            </tr>
            <tr>
              <td>
                <table style="width: auto;">
                  <tr>
                    <td>�������� ���</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@��������"/>
                        <xsl:with-param name="size" select="4"/>
                      </xsl:call-template>
                    </td>
                    <td width="35"></td>
                    <td>��������� ������ (���)</td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@������"/>
                        <xsl:with-param name="size" select="2"/>
                      </xsl:call-template>
                    </td>
                    <td width="50"></td>
                    <td class="podpis italic">����� � ������</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="10%">
                      ���<br/>��������
                    </td>
                    <td width="45%">
                      �� ���������, �������������� ���������� ��������� ������ 0 ��������� �� ������� ������������� ������������ � ���������� ��������� ��������
                    </td>
                    <td width="45%">
                      �� ���������, �������������� ���������� ��������� ������ 0 ��������� �� ������� ������������� �� ������������ � ���������� ��������� ��������
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr class="text-center">
                    <td width="25%">
                      <table>
                        <tr>
                          <td>1</td>
                          <td>2</td>
                        </tr>
                      </table>
                    </td>
                    <td width="25%">3</td>
                    <td width="25%">4</td>
                    <td width="25%">5</td>
                  </tr>
                  <xsl:apply-templates select="�������5"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table class="table-compact">
                  <tr>
                    <td width="25%">
                      ����� ������, ����������� � ���������� �� ������� �������<span class="italic">(��� ������ 010)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@����������"/>
                      </xsl:call-template>
                    </td>
                    <td width="25%">&#160;</td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@������������"/>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>
   
  </xsl:template>

  <xsl:template match="�������5">
    <tr>
      <td>
        <xsl:value-of select="@�������"/>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@����������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@������������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�����������"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* ������ 6 (���� 9) *********************************-->
  <xsl:template match="����������0">
    <div class="page-break">&#160;</div>
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter6.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class ="text-center nowrap bold">
                ������ 6. ������ ����� ������ �� ��������� �� ���������� ������� (�����, �����), �������������� ����������<br/>
                ��������� ������ 0 ��������� �� ������� ������������� �� ������������
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr class="text-center italic">
                    <td width="16%">��� ��������</td>
                    <td width="28%">��������� ����</td>
                    <td width="28%">����� ���, ����������� �� ��������� �������, ��������������� �������� 2-3 ������ 164 ���������� ������� ���������� ���������</td>
                    <td width="28%">
                      <span class="podpis">����� � ������</span><br/><br/>
                      ����� ��������� ������� �� ��������� �� ���������� ������� (�����, �����), �������������� ���������� ��������� ������ 0 ��������� �� ������� ������������� �� ������������
                    </td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="�������6"/>
                  <tr>
                    <td>
                      ����� <span class="italic explanation">(��� ������ 010)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@���������"/>
                      </xsl:call-template>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@������164��"/>
                      </xsl:call-template>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@�������������"/>
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
                    <td width="72%">
                      �����, ����� ������, ����������� � ������ � ������ �� ������� ������� <span class="italic explanation">(��� ������ 020)</span>
                    </td>
                    <td width="28%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="@�����������>=0">
                            <xsl:value-of select="@�����������"/>
                          </xsl:if>
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      �����, ����� ������, ����������� � ���������� �� ������� ������� <span class="italic explanation">(��� ������ 030)</span>
                    </td>
                    <td>
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input">
                          <xsl:if test="not(@�����������>=0)">
                            <xsl:value-of select="substring-after(@�����������,'-')"/>
                          </xsl:if>
                        </xsl:with-param>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
      
    </table>
     
    
  </xsl:template>

  <xsl:template match="�������6">
    <tr class="text-center">
      <td>
        <xsl:value-of select="@�������"/>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@������164"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�����������"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--********************* ������ 7 (���� 10) *********************************-->
  <xsl:template match="���������">
    <div class="page-break">&#160;</div>
   
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <xsl:call-template name="pageHeader">
                  <xsl:with-param name="barCode">chapter7.png</xsl:with-param>
                </xsl:call-template>
              </td>
            </tr>
            <!--���������-->
            <tr>
              <td class ="text-center nowrap bold">
                ������ 7. �������� , �� ���������� ��������������� (������������� �� ���������������); �������� , ��<br/>
                ������������ �������� ���������������; �������� �� ���������� ������� (�����, �����), ������ ����������<br/>
                ������� �� ���������� ���������� ���������� ���������; � ����� ����� ������, ��������� ������ � ����<br/>
                ����������� �������� ������� (���������� �����, �������� �����), ������������ ����������������� �����<br/>
                ������������ ������� ���������� ����� ����� �������
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="25%" class="italic explanation">(��� ������ 010)</td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                    <td width="25%" class="italic explanation">����� � ������</td>
                  </tr>
                  <tr class="text-center italic">
                    <td>��� ��������</td>
                    <td>��������� ������������� (����������) ������� (�����, �����), ��� ��� (���.)</td>
                    <td>��������� ������������� ������� (�����, �����), ������������ ��� (���.)</td>
                    <td>����� ��� �� ������������� ������� (�������, �������), �� ���������� ������ (���.)</td>
                  </tr>
                  <tr class="text-center">
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                  </tr>
                  <xsl:apply-templates select="�������7"/>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td width="75%">
                      ����� ���������� ������, ��������� ������ � ���� ����������� �������� ������� (���������� �����, �������� �����), ������������ ����������������� ����� ������������ ������� ���������� ����� ����� �������, �� �������, ������������� �������������� ���������� ���������
                      <span class="italic explanation">(��� ������ 020)</span>
                    </td>
                    <td width="25%">
                      <xsl:call-template name="breakStrNum10">
                        <xsl:with-param name="input" select="@���������6���"/>
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
          <xsl:call-template name="�������������������"/>
        </td>
      </tr>
    </table>

    
  </xsl:template>

  <xsl:template match="�������7">
    <tr class="text-center">
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@�������"/>
          <xsl:with-param name="size" select="7"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@���������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@����������"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="breakStrNum10">
          <xsl:with-param name="input" select="@��������"/>
        </xsl:call-template>
      </td>
    </tr>
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
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="nullIsPrinted"></xsl:with-param>

      <!--���� �� ������ ������ - ������ ������ 12-->
      <xsl:with-param name="size">
        <xsl:choose>
          <xsl:when test="$size">
            <xsl:value-of select="$size"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="12"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--���� ������� ����������, � ����������� "-", ������ 10 -->
  <xsl:template name="breakStrNum10">
    <xsl:param name="input"></xsl:param>
    <xsl:param name="size"></xsl:param>

    <xsl:call-template name="breakStr">
      <!--���� �������� 0, �� ������ ������ ��������-->
      <xsl:with-param name="input" select="$input"/>
      <xsl:with-param name="nullIsPrinted"></xsl:with-param>
      <!--���� �� ������ ������ - ������ ������ 10-->
      <xsl:with-param name="size">
        <xsl:choose>
          <xsl:when test="$size">
            <xsl:value-of select="$size"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="10"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
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