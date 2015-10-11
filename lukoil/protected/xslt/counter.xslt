<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>
  
  <!-- печатает скрипт в документе -->
  <xsl:template name="InitCounterScript">
    <script>
      <![CDATA[
      
// счетчик страниц
var PageNumScript = 0;
// функция breakStr - вывод номеров страниц
// id - уникальный идентификатор элемента (td)
// input, size, line, alignRight, symbol, nullIsPrinted, classBorder, bottomClassBorderl по аналогии с breakStr в xslt
function breakStr(id, input, size, line, alignRight, symbol, nullIsPrinted, classBorder, bottomClassBorder) {
    var i = 0;
    var k = 0;
    var l = 0;
    // если ноль печатать не надо
    if (input == 0 && !nullIsPrinted) input = '';
    
    // переводим в строку, если число
    var StrNum = input.toString();
    // если StrNum меньше line * size, добиваем ее symbol слева или справа в зависимости от alignRight
    while (StrNum.length < line * size) {
        if (alignRight)
            StrNum = symbol + StrNum;
        else
            StrNum = StrNum + symbol;
    }
    // шапка
    var sHTML = '<table>';
    for (l = 0; l < line; l++) {
        sHTML = sHTML + '<tr class="field_filled">'
        // цикл по size
        for (i = 0; i < size; i++) {
            // выводим очередную ячейку
            sHTML = sHTML + '<td class="' + classBorder + '">' + StrNum.substr(i + l * size, 1) + '</td>';
        }
        // закрываем строку
        sHTML = sHTML + '</tr>';
        
        // если есть нижнее подчеркивание
        if (bottomClassBorder) {
            sHTML = sHTML + '<tr>'
            // цикл по size
            for (i = 0; i < size; i++) {
                // выводим очередную ячейку
                sHTML = sHTML + '<td class="' + bottomClassBorder + '"></td>';
            }
            // закрываем строку
            sHTML = sHTML + '</tr>';

        }
    }
    // закрываем таблицу
    sHTML = sHTML + '</table>'
    // alert(sHTML);
    var element = document.getElementById(id);
    if (element)
        element.innerHTML = sHTML;
}
      
      ]]>
    </script>
  </xsl:template>

  <!-- Формируем номера страниц -->
  <xsl:template name="pageNum">
    <xsl:param name="pageID"/>
    <xsl:param name="classBorder">border-dotted</xsl:param>
    <xsl:param name="size">3</xsl:param>
    <xsl:param name="symbol">-</xsl:param>
    <xsl:param name="alignRight"></xsl:param>
    <!-- добавляем к id строчку 'pageID' т.к. в рамках одной страницы (одного узла) generate-id() 
    выдает одно и то же значение разделяем сами их -->
    <xsl:variable name="id" select="concat(generate-id(),'pageID',$pageID)"/>
    <td id="{$id}" class="text-left"></td>
    <script type = "text/javascript">
      PageNumScript = PageNumScript + 1;
      breakStr('<xsl:value-of select="$id"/>', PageNumScript, <xsl:value-of select="$size"/>, 1, '<xsl:value-of select="$alignRight"/>', '<xsl:value-of select="$symbol"/>', 0, '<xsl:value-of select="$classBorder"/>');
    </script>
  </xsl:template>

  <!-- Формируем кол-во страниц -->
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