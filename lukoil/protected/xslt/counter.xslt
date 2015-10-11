<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>
  
  <!-- �������� ������ � ��������� -->
  <xsl:template name="InitCounterScript">
    <script>
      <![CDATA[
      
// ������� �������
var PageNumScript = 0;
// ������� breakStr - ����� ������� �������
// id - ���������� ������������� �������� (td)
// input, size, line, alignRight, symbol, nullIsPrinted, classBorder, bottomClassBorderl �� �������� � breakStr � xslt
function breakStr(id, input, size, line, alignRight, symbol, nullIsPrinted, classBorder, bottomClassBorder) {
    var i = 0;
    var k = 0;
    var l = 0;
    // ���� ���� �������� �� ����
    if (input == 0 && !nullIsPrinted) input = '';
    
    // ��������� � ������, ���� �����
    var StrNum = input.toString();
    // ���� StrNum ������ line * size, �������� �� symbol ����� ��� ������ � ����������� �� alignRight
    while (StrNum.length < line * size) {
        if (alignRight)
            StrNum = symbol + StrNum;
        else
            StrNum = StrNum + symbol;
    }
    // �����
    var sHTML = '<table>';
    for (l = 0; l < line; l++) {
        sHTML = sHTML + '<tr class="field_filled">'
        // ���� �� size
        for (i = 0; i < size; i++) {
            // ������� ��������� ������
            sHTML = sHTML + '<td class="' + classBorder + '">' + StrNum.substr(i + l * size, 1) + '</td>';
        }
        // ��������� ������
        sHTML = sHTML + '</tr>';
        
        // ���� ���� ������ �������������
        if (bottomClassBorder) {
            sHTML = sHTML + '<tr>'
            // ���� �� size
            for (i = 0; i < size; i++) {
                // ������� ��������� ������
                sHTML = sHTML + '<td class="' + bottomClassBorder + '"></td>';
            }
            // ��������� ������
            sHTML = sHTML + '</tr>';

        }
    }
    // ��������� �������
    sHTML = sHTML + '</table>'
    // alert(sHTML);
    var element = document.getElementById(id);
    if (element)
        element.innerHTML = sHTML;
}
      
      ]]>
    </script>
  </xsl:template>

  <!-- ��������� ������ ������� -->
  <xsl:template name="pageNum">
    <xsl:param name="pageID"/>
    <xsl:param name="classBorder">border-dotted</xsl:param>
    <xsl:param name="size">3</xsl:param>
    <xsl:param name="symbol">-</xsl:param>
    <xsl:param name="alignRight"></xsl:param>
    <!-- ��������� � id ������� 'pageID' �.�. � ������ ����� �������� (������ ����) generate-id() 
    ������ ���� � �� �� �������� ��������� ���� �� -->
    <xsl:variable name="id" select="concat(generate-id(),'pageID',$pageID)"/>
    <td id="{$id}" class="text-left"></td>
    <script type = "text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id"/>', PageNumScript, <xsl:value-of select="$size"/>, 1, '<xsl:value-of select="$alignRight"/>', '<xsl:value-of select="$symbol"/>', 0, '<xsl:value-of select="$classBorder"/>');
    </script>
  </xsl:template>

  <!-- ��������� ���-�� ������� -->
  <xsl:template name="CountPage">
    <xsl:param name="classBorder">border-dotted</xsl:param>
    <xsl:param name="size">3</xsl:param>
    <xsl:param name="symbol">-</xsl:param>
    <xsl:param name="alignRight"></xsl:param>
    <script type = "text/javascript">
      breakStr('CountPage', PageNumScript,  <xsl:value-of select="$size"/>, 1, '<xsl:value-of select="$alignRight"/>', '<xsl:value-of select="$symbol"/>', 0, '<xsl:value-of select="$classBorder"/>');
    </script>
  </xsl:template>
  
</xsl:stylesheet>