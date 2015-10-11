<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="Qualifier.xsl"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>
  <xsl:decimal-format grouping-separator=" "/>


  <xsl:template match="/">

      <xsl:call-template name="InitStyles"/>

    <style>
      .table-with-border td
      {
        border: 1pt solid black;
        font-size: 8pt;
        vertical-align: top;
      }
    </style>



    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates select="����"/>
    </div>
  </xsl:template>

  <xsl:template match="����">
    <xsl:apply-templates select="��������"/>
  </xsl:template>

  <xsl:template match="��������">
    <!--2-���� - ������� � ������� ����������� ���� �� 2011 ���-->
    <!--��� 1151078-->
    <!--5.02-->

    <!--��������-->
    <xsl:call-template name="Page1"/>
    <!--�������� � ������� ����������� ���� �� ��������� ����� 1�� ��������-->
    <xsl:apply-templates select="�������[position() > 1]"/>

  </xsl:template>

  <xsl:template name="Page1">
    <xsl:if test="position() > 1">
      <div class="page-break">&#160;</div>
    </xsl:if>

   <table class="page page-margin-medium">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td class="explanation">
              ���������� � 1 � ������� ��� ������ �� 17.11.2010 N ���-7-3/611@(� ���. ������� ��� �� �� 06.12.2011 N ���-7-3/909@)
              <div class="bold text-right">����� 2-����</div>
                <div class="text-right">
                  ��� ����� �� ��� <xsl:value-of select="@���"/>
                </div>
              </td>
            </tr>
          </table>

          <xsl:call-template  name="doc">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>

          <table class="margin-top5mm">
            <tr class="explanation">
              <td class='bold'>
                1. ������ � ��������� ������
              </td>
              <td class="text-right">� ���� (���)</td>
              <td class="nowrap border-bottom" width="1%">
                <xsl:value-of select="@�����"/>
              </td>
            </tr>
          </table>

          <!--������ � ��������� ������ -->
          <xsl:apply-templates select="����"/>
          <!--������ � ���������� ���� - ���������� ������-->
          <xsl:apply-templates select="��������"/>
          <!--�������� � ������� ����������� ���� �� 1�� ��������-->
          <xsl:call-template name="outTable3-5">
            <xsl:with-param name="node" select="�������[position() = 1]"/>
          </xsl:call-template>

        </td>
      </tr>
    </table>
       
          <!--<xsl:apply-templates select="�������"/>-->
       
  </xsl:template>
  
  <xsl:template match="�������">
    
   <div class="page-break">&#160;</div>
    <table class="page page-margin-medium">
      <tr>
        <td class="page-content">
          <table style="text-align:right;">
            <tr>
              <td>
                ���. <xsl:value-of select="position()+1"/>
              </td>
            </tr>
          </table>
          <!--������� ���������: ������� � ������� ����������� ���� �� �� ������ ���������-->
          <xsl:call-template  name="doc">
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
          <!--�������� � ������� ����������� ���� �� �� ������ ���������-->
          <xsl:call-template name="outTable3-5">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>
          
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="����">
    <table style="width: auto">
      <tr class="explanation">
        <td>
          1.1. ���/��� ��� ����������� ��� ��� ��� ����������� ����
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="������/@�����"/>
          <xsl:value-of select="������/@�����"/>
        </td>
        <td>/</td>
        <td class="border-bottom bold" width="25%">
          <xsl:value-of select="������/@���"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td>
          1.2. ������������ ����������� / �������, ���, �������� ����������� ����
        </td>
      </tr>
      <tr class="explanation">
        <td class="border-bottom bold">
          <xsl:value-of select="������/@�������"/>
          <xsl:apply-templates select="������/���"/>
        </td>
      </tr>
    </table>

    <table style="width: auto">
      <tr class="explanation">
        <td class="nowrap">
          1.3. ��� �����
        </td>
        <td class="bold border-bottom" width="30%">
          <xsl:apply-templates select="@�����"/>
        </td>
        <td width="15%"></td>
        <td class="text-right nowrap">
          1.4. �������
        </td>
        <td class="bold border-bottom" width="30%">
          <xsl:apply-templates select="@���"/>
        </td>
      </tr>
    </table>
    
  </xsl:template>

  <xsl:template match="��������">
    <table>
      <tr class="explanation">
        <td class="bold" colspan="4">
          2. ������ � ���������� ���� - ���������� ������
        </td>
      </tr>
      <tr class="explanation">
        <td width="5%" class="nowrap">
          2.1. ���
        </td>
        <td class="border-bottom bold" width="15%">
          <xsl:value-of select="@�����"/>
        </td>
        <td class="text-right" width="25%">
          2.2. �������, ���, ��������
        </td>
        <td class="border-bottom bold">
          <xsl:apply-templates select="���"/>
        </td>
      </tr>
    </table>
   
    <table>
      <tr class="explanation">
        <td class="nowrap" width="20%">
          2.3. ������ �����������������
        </td>
        <td class="bold border-bottom" width="3%">
          <xsl:value-of select="@������"/>
        </td>
        <td class="nowrap" width="10%">
          2.4. ���� ��������
        </td>
        <td class="bold border-bottom" width="20%">
          <xsl:value-of select="@��������"/>
        </td>
        <td class="nowrap" width="20%">
          2.5. ����������� (��� ������)
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="@�����"/>
        </td>
      </tr>
    </table>
    
    <table>
      <tr class="explanation">
        <td class="nowrap" width="20%">
          2.6. ��� ���������, �������������� ��������
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="��������/@���������"/>
        </td>
        <td class="nowrap" width="20%">
          2.7. �����, ����� ���������
        </td>
        <td class="bold border-bottom">
          <xsl:value-of select="��������/@���������"/>
        </td>
      </tr>
    </table>
    
    <!--����� � ��-->
    <table>
      <tr class="explanation">
        <td class="nowrap">
          2.8. ����� ����� ���������� � ���������� ���������:
        </td>
        <td class="nowrap" width="10%">
          �������� ������
        </td>
        <td class="bold border-bottom" width="15%">
          <xsl:value-of select="�������/@������"/>
        </td>
        <td class="nowrap" width="10%">
          ��� �������
        </td>
        <td class="bold border-bottom" width="5%">
          <xsl:value-of select="�������/@���������"/>
        </td>
        <td width="10%"></td>
      </tr>
    </table>
    
    <table>
      <tr class="explanation">
        <td class="nowrap padding-left5mm"  width="5%">
          &#160; �����
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="�������/@�����"/>
        </td>
        <td class="nowrap" width="5%">
          �����
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="�������/@�����"/>
        </td>
        <td class="nowrap" width="5%">
          ���������� �����
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="�������/@����������"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td class="nowrap padding-left5mm"  width="5%">
          &#160; �����
        </td>
        <td class="bold border-bottom" width="40%">
          <xsl:value-of select="�������/@�����"/>
        </td>
        <td class="nowrap" width="1%">
          ���
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="�������/@���"/>
        </td>
        <td class="nowrap" width="5%">
          ������
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="�������/@������"/>
        </td>
        <td class="nowrap" width="5%">
          ��������
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="�������/@�����"/>
        </td>
      </tr>
    </table>

    <!--����� �� ��������� ��-->
    <table>
      <tr class="explanation">
        <td class="nowrap"  width="5%">
          2.9. ����� � ������ ����������: ��� ������
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="���������/@������"/>
        </td>
        <td class="nowrap" width="5%">
          �����
        </td>
        <td class="bold border-bottom">
          <xsl:value-of select="�������/@��������"/>
        </td>
      </tr>
      <tr>
        <td colspan="4" class="border-bottom">
          &#160;
        </td>
      </tr>
    </table>
    
  </xsl:template>


  <xsl:template name="outTable3-5">
    <xsl:param name="node"/>

    <table>
      <tr class="explanation bold">
        <td width="15%" class="nowrap">
          3. ������, ���������� �� ������
        </td>
        <td class="border-bottom bold text-center" width="3%">
          <xsl:value-of select="$node/@������"/>
        </td>
        <td class="text-right" width="1%">
          %
        </td>
        <td></td>
      </tr>
    </table>
    <!--���������� ������������ ������ �� ��������: � ������� ��������, � ��������� ��������-->
    <table>
      <tr>
        <td width="49%" class="vertical-align-top">
          <xsl:apply-templates select="$node/������[��������[boolean(position() mod 2) and @����� > 0]]">
            <xsl:with-param name="node" select="$node/������/��������[boolean(position() mod 2)]"/>
          </xsl:apply-templates>
        </td>
        <td></td>
        <td width="49%" class="vertical-align-top">
          <xsl:apply-templates select="$node/������[��������[not(position() mod 2) and @����� > 0 ]]">
            <xsl:with-param name="node" select="$node/������/��������[not(position() mod 2)]"/>
          </xsl:apply-templates>

          <!--���� ������ ���� ������ �������� � ����� ����� ������������, �� � ������ ���� ������ �����-->
          <xsl:if test="count($node/������/��������[@����� > 0]) = 1">
            <table class="table-with-border">
              <xsl:call-template name="haedTable"/>
            </table>
          </xsl:if>
        </td>
      </tr>
    </table>

    <!--4. �����������, ���������� � ������������� ��������� ������-->
    <xsl:apply-templates select="$node/���������"/>

    <!--5. ����� ����� ������ � ������ �� ������ ���������� �������-->
    <xsl:apply-templates select="$node/���������"/>
    <!--�������-->
    <table class="margin-top5mm">
      <tr class="explanation">
        <td width="11%" class="nowrap">
          ��������� �����
        </td>
        <td class="border-bottom text-center" width="20%">

        </td>
        <td width="1%"></td>
        <td class="border-bottom" width="20%">

        </td>
        <td width="1%"></td>
        <td class="border-bottom text-center" width="25%">

        </td>
      </tr>
      <tr>
        <td class="text-right">
          �.�. &#160;&#160;&#160;
        </td>
        <td class="podpis">(���������)</td>
        <td></td>
        <td class="podpis">(�������)</td>
        <td></td>
        <td class="podpis">(�.�.�)</td>
      </tr>
    </table>

    <table>
      <tr>
        <td width="15%" class="border-bottom">&#160;</td>
      </tr>
      <tr>
        <td colspan="2" class="explanation">
          * ��������� ����� ����������� � ��������� ���� ������, ����������� � �������, ����������, ������� � 2011 ����.
        </td>
      </tr>
    </table>
    
  </xsl:template>
  <!--���������: ������� � ������� ����������� ����-->
  <xsl:template name="doc">
    <xsl:param name="node"/>
    <table style="width: auto">
      <tr class="explanation">
        <td width="10%"></td>
        <td class="bold">
          ������� � ������� ����������� ���� ��
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@��������"/>
        </td>
        <td class="bold">���</td>
        <td class="bold">�</td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@������"/>
        </td>
        <td class="bold">��</td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@�������"/>
        </td>
        <td>�������</td>
        <td width="5%" class="border-bottom text-center">
          <xsl:value-of select="$node/@�������"/>
        </td>
        <td width="10%"></td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="haedTable">
    <tr class="text-center">
      <td width="15%">�����</td>
      <td width="15%">
        ���<br/>������
      </td>
      <td>
        �����<br/>������
      </td>
      <td width="15%">
        ���<br/>������
      </td>
      <td>
        �����<br/>������
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="������">
    <xsl:param name="node"/>
    <table class="table-with-border">
      <xsl:call-template name="haedTable"/>
      <xsl:apply-templates select="$node"/>
    </table>
  </xsl:template>
  
  <xsl:template match="��������">
    <tr class="bold">
      <td class="text-center">
        <xsl:value-of select="number(@�����)"/>
      </td>
      <td class="text-center">
        <xsl:value-of select="@��������"/>
      </td>
      <td class="text-right">
        <xsl:call-template name="NumValue">
          <xsl:with-param name="input" select="@��������"/>
        </xsl:call-template>
      </td>
      <xsl:apply-templates select="��������[position()=1]"/>
       
      <xsl:if test="not(��������)">
        <td></td>
        <td></td>
      </xsl:if>
    </tr>
    <xsl:apply-templates select="��������[position()>1]" mode="other" />
      
  </xsl:template>

  <xsl:template match="��������">
        <xsl:call-template name="outValue">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
  </xsl:template>
  <xsl:template match="��������" mode="other">
      <tr class="bold">
          <td></td>
          <td></td>
          <td></td>
          <xsl:call-template name="outValue">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>
        </tr>
 </xsl:template>
  <xsl:template name="outValue">
    <xsl:param name="node"/>
    <td class="text-center">
      <xsl:value-of select="$node/@��������"/>
    </td>
    <td class="text-right">
      <xsl:call-template name="NumValue">
        <xsl:with-param name="input" select="$node/@��������"/>
      </xsl:call-template>
    </td>
  </xsl:template>
  
  <xsl:template match="���������">
    <table>
      <tr class="explanation bold">
        <td>
          4. �����������, ���������� � ������������� ��������� ������
        </td>
      </tr>
      <tr class="explanation">
        <td>
          4.1. ����� ��������������� ����������������� ��������� �������
        </td>
      </tr>
    </table>

    <table>
      <tr>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="1"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="2"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="3"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td width="65%">
          4.2. � �����������, ��������������� ����� �� ������������� ��������� �����
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="�����������/@���������"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td width="10%" class="nowrap">
          4.3. ���� ������ �����������
        </td>
        <td class="border-bottom bold" width="10%">
          <xsl:value-of select="�����������/@��������"/>
        </td>
        <td class="text-right">
          4.4. ��� ���������� ������, ��������� �����������
        </td>
        <td class="border-bottom bold" width="20%">
          <xsl:value-of select="�����������/@��������"/>
        </td>
      </tr>
    </table>

  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <xsl:param name="num"/>
    <table class="table-with-border">
      <xsl:call-template name="headTable4"/>

      <!--������� ������ 4-�� ������-->
      <xsl:apply-templates select="$node/����������[position() - $num =  4 * ( ceiling(position() div 4) - 1) ]"/>
      
    </table>
  </xsl:template>

  <xsl:template match="����������">
    <tr class="bold">
      <xsl:call-template name="outValue">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </tr>
  </xsl:template>
  
  <xsl:template name="headTable4">
    <tr class="text-center">
      <td width="40%">
        ��� ������
      </td>
      <td>
        ����� ������
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="���������">

    <div class="explanation bold">5. ����� ����� ������ � ������ �� ������ ���������� �������</div>
    <table class="table-with-border">
      <tr>
        <td width="80%">
          5.1. ����� ����� ������
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@���������"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.2. ��������� ����
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@�������"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.3. ����� ������ �����������
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@���������"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.4. ����� ������ ����������
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@��������"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.5. ����� ������ �������������*
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@�����������"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.6. ����� ������, ������� ���������� ��������� �������
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@�����������"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.7. ����� ������, �� ���������� ��������� �������
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@����������"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>

  </xsl:template>

  
  <xsl:template match="���">
    <xsl:value-of select="@�������"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@���"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@��������"/>
  </xsl:template>

  <xsl:template name="Podpis">
    <tr>
      <td>
        <table class="margin-top5mm">
          <!--style="margin-top: 5mm;" -->
          <tr>
            <td>������������</td>
            <td class="border-bottom" width="10%">&#160;</td>
            <td width="1%">&#160;</td>
            <td class="border-bottom" width="15%">
              <xsl:apply-templates select="���������[@������=3]"/>
            </td>
            <td width="20%">
              &#160;
            </td>
            <td>������� ���������</td>
            <td class="border-bottom" width="10%">&#160;</td>
            <td width="1%">&#160;</td>
            <td class="border-bottom" width="15%">
              <xsl:apply-templates select="���������[@������=4]"/>
            </td>
          </tr>
          <tr>
            <td></td>
            <td class="podpis">(�������)</td>
            <td></td>
            <td class="podpis">(����������� �������)</td>
            <td></td>
            <td></td>
            <td class="podpis">(�������)</td>
            <td></td>
            <td class="podpis">(����������� �������)</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <table style="width: auto;">
          <tr>
            <td>&quot;</td>
            <td class="border-bottom">
              <xsl:value-of select="number(substring(@�������,1,2))"/>
            </td>
            <td>&quot;</td>
            <td class="border-bottom">
              <xsl:call-template name="�������"/>
            </td>
            <td>&#160;</td>
            <td class="border-bottom">
              <xsl:value-of select="substring(@�������,7,4)"/>
            </td>
            <td>�.</td>
          </tr>
        </table>
      </td>
    </tr>
  </xsl:template>


  

  <!--������� �� ����� ������ 0 �������-->
  <xsl:template name="NumValue">
    <xsl:param name="input"/>
    <xsl:param name="decimal">2</xsl:param>
    <xsl:choose>
      <xsl:when test="number($input) and $decimal">
        <xsl:value-of select="format-number($input,'# ##0.00')"/>
      </xsl:when>
      <xsl:when test="number($input) and not($decimal)">
        <xsl:value-of select="format-number($input,'# ###.##')"/>
      </xsl:when>
      <xsl:otherwise>-</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  



  <!--������� ���� ������ (�����) ��������-->
  <xsl:template name="�������">
    <xsl:variable name="month" select="substring(@�������,4,2)"/>

    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>�������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>�����</xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>���</xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>����</xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>����</xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>�������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>��������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>�������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>������</xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>�������</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>