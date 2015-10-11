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


  <xsl:template match="��������">
    <!--IV-->
    <table class="page page-margin-narrow">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td>
                <!--�����-->
                <table>
                  <tr>
                    <td class="text-right">
                      ���������� � 2<br/>
                      ��� �� ��� <xsl:value-of select="@���"/><br/>
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
                            ��� ����
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(��������/@����,1,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(��������/@����,2,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(��������/@����,3,1)"/>
                          </td>
                          <td width="5%" class="border-solid" style="font-weight:bold">
                            <xsl:value-of select="substring(��������/@����,4,1)"/>
                          </td>
                        </tr>
                        <tr class="border-solid">
                          <td colspan="6">
                            <table style="border:none">
                              <tr>
                                ��&#160;
                                <td class="cell-value" style="font-weight:bold">
                                  <xsl:value-of select="����/����/@�������"/>
                                  <xsl:apply-templates select="����/����/���"/>,
                                  <xsl:value-of select="����/����/@�����"/>
                                  <xsl:value-of select="����/����/@�����"/>
                                </td>
                              </tr>
                              <tr>
                                <td colspan="2" style="font-size:8pt;">
                                  (������������ �����������, ��� / �.�.�. ���������������<br/> ��������������� (����������� ����), ��� (��� �������))
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr style="text-align:center;">
                    <td style="font-weight:bold; padding-top:3mm;">���������</td>
                    <td style="padding-top:3mm;">
                      ����� ���������:
                      <xsl:value-of select="��������/@��������"/>
                    </td>
                  </tr>
                </table>
                <xsl:apply-templates select="����"/>
                <xsl:apply-templates select="��������"/>
                <xsl:apply-templates select="���������"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="����">
    <table style="margin-top:10px;">
      <tr>
        <td>
          <span style="margin-left:20px;"> ��������� �����������������:</span>
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" colspan="2">
          1. ������������ �����������-�����������������, ��������������� ���������������, ����������� ����:
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" class="cell-value" colspan="2">
          <xsl:value-of select="����/@�������"/>
          <xsl:apply-templates select="����/���"/>
        </td>
      </tr>
      <tr>
        <td style="padding-top:3mm;">
          <strong>
            ����� ��������������� ��, ����� ���������� ��, ����������� ����:
          </strong><br/>
          (������, ��� �������, �����, �����, ���������� �����, �����, ���, ������, ��.)
        </td>
        <td align="right">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="�����/@������"/>
            <xsl:with-param name="size" select="6"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td style="font-weight:bold; padding-top:3mm;" class="cell-value" colspan="2">
          <xsl:apply-templates select="�����"/>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td width="50%" style="font-weight:bold;">
          ��� �����������<br/>
          (��, ����������� ����):<br/>
          <xsl:choose>
            <xsl:when test="����/@�����">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="����/@�����"/>
                <xsl:with-param name="size" select="12"/>
                <xsl:with-param name="symbol">-</xsl:with-param>
                <xsl:with-param name="classBorder">border-solid</xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="����/@�����">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input" select="����/@�����"/>
                <xsl:with-param name="size" select="12"/>
                <xsl:with-param name="symbol">-</xsl:with-param>
                <xsl:with-param name="classBorder">border-solid</xsl:with-param>
              </xsl:call-template>
            </xsl:when>
          </xsl:choose>
        </td>
        <td width="50%" style="font-weight:bold;">
          ��� �����������<br/>
          <span style="font-size:7pt">(����������� � ������ �������������)</span><br/>
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="����/@���"/>
            <xsl:with-param name="size" select="9"/>
            <xsl:with-param name="symbol">-</xsl:with-param>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="��������">
    <table>
      <tr>
        <td style="font-weight:bold; width:60%">
          ��� ��������� ��� ������, ������� ��������� ������
        </td>
        <td style="font-weight:bold;">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@����"/>
            <xsl:with-param name="size" select="4"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="cell-value" colspan="2" style="padding-top:5mm;">
          <xsl:value-of select="����������"/>
        </td>
      </tr>
      <tr>
        <td style="font-size:7pt; text-align:center;" colspan="2">
          (����� ���������)
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td style="font-weight:bold;">
          <table>
            <tr>
              <td width="40%">
                ����������:&#160;&#160;&#160;���������� ������
              </td>
              <td>
                <xsl:call-template name="breakStr">
                  <xsl:with-param name="input" select="����/@�������"/>
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
          ������������ ������ ���������� (��� �������)
        </td>
      </tr>
      <xsl:apply-templates select="����/��������"/>
    </table>
  </xsl:template>

  <xsl:template match="��������">
    <tr>
      <td style="font-weight:bold;">
    - <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="���������">
    <table>
      <tr style="font-weight:bold;">
        <td style="font-weight:bold; padding-top:3mm;">
          ��������� ������������ �������������� �������������� �����������������
        </td>
        <td style="font-weight:bold; padding-top:3mm;">
          <xsl:call-template name="breakStr">
            <xsl:with-param name="input" select="@������"/>
            <xsl:with-param name="size" select="1"/>
            <xsl:with-param name="classBorder">border-solid</xsl:with-param>
          </xsl:call-template>
        </td>
        <td style="font-weight:bold; padding-top:3mm; padding-left:3mm;">(��- 2, ��� - 1).</td>
      </tr>
    </table>
    <table style="font-weight:bold; margin-top:15px;">
      <tr>
        <td width="50%" align="left" style="padding-right: 2mm; vertical-align:bottom;">
          ������������ �����������
        </td>
        <td width="20%" style="text-align:center; vertical-align:bottom;"></td>
        <td width="1" style="vertical-align:bottom;" >/</td>
        <td style="text-align:center; vertical-align:bottom; width:30%">
          <xsl:apply-templates select="���" />
        </td>
        <td width="1" style="vertical-align:bottom;">/</td>
        <td style="width:auto"/>
      </tr>
      <tr>
        <td>
          <span style="font-size:7pt;">
            (�������������� ���������������,
            ���������� ����,<br/> �������������� �������������)
          </span>
        </td>
        <td class="border-cell-podpis" >�������</td>
        <td/>
        <td class="border-cell-podpis" >�.�.�.</td>
        <td/>
        <td/>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="���">
    <xsl:value-of select="concat(@�������,' ', @���, ' ', @��������)"/>
  </xsl:template>

  <xsl:template match="�����">
    <xsl:call-template name="NameFromQualifier">
      <xsl:with-param name="Qualifier">RegionsRF</xsl:with-param>
      <xsl:with-param name="Code" select="@���������"/>
    </xsl:call-template>
    <xsl:if test="@��������� and not(@��������� ='') and not(@��������� =' ')">, </xsl:if>
    <xsl:value-of select="@�����"/>
    <xsl:if test="@����� and not(@����� ='') and not(@����� =' ')">, </xsl:if>
    <xsl:value-of select="@�����"/>
    <xsl:if test="@����� and not(@����� ='') and not(@����� =' ')">, </xsl:if>
    <xsl:value-of select="@����������"/>
    <xsl:if test="@���������� and not(@���������� ='') and not(@���������� =' ')">, </xsl:if>
    <xsl:value-of select="@�����"/>
    <xsl:if test="@����� and not(@����� ='') and not(@����� =' ')">, </xsl:if>
    <xsl:value-of select="@���"/>
    <xsl:if test="@��� and not(@��� ='') and not(@��� =' ')">, </xsl:if>
    <xsl:value-of select="@������"/>
    <xsl:if test="@������ and not(@������ ='') and not(@������ =' ')">, </xsl:if>
    <xsl:value-of select="@�����"/>
  </xsl:template>

</xsl:stylesheet>
