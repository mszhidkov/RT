<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>

  <!--функции для разбивки строк-->
  <xsl:template name="breakRecursive">
    <xsl:param name="input"/>
    <xsl:param name="size" select="string-length($input)"/>
    <xsl:param name="classBorder"></xsl:param>
    <xsl:param name="bottomClassBorder"></xsl:param>

    <!--еще не вся строка разобрана-->
    <xsl:if test="$size>0">
      <td>
        <xsl:choose>
          <!-- для подчеркивания - пустя ячейка -->
          <xsl:when test="$bottomClassBorder">
            <xsl:attribute name="class">
              <xsl:value-of select="$bottomClassBorder"/>
            </xsl:attribute>
            <xsl:value-of select="' '"/>
          </xsl:when>
          <!-- для обычных ячеек - очередной сивол -->
          <xsl:otherwise>
            <xsl:attribute name="class">
              <xsl:value-of select="$classBorder"/>
            </xsl:attribute>
            <xsl:value-of select="substring($input,1,1)"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>

      <!--рекусивный вызов-->
      <xsl:call-template name="breakRecursive">
        <xsl:with-param name="input" select="substring($input,2,$size - 1)"/>
        <xsl:with-param name="classBorder" select="$classBorder"/>
        <xsl:with-param name="bottomClassBorder" select="$bottomClassBorder"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="symbolRecursive">
    <xsl:param name="symbol"></xsl:param>
    <xsl:param name="size"></xsl:param>
    <xsl:param name="classBorder"></xsl:param>

    <xsl:choose>
      <!--еще не вся строка разобрана-->
      <xsl:when test="$size>0">
        <td>
          <xsl:attribute name="class">
            <xsl:value-of select="$classBorder"/>
          </xsl:attribute>
          <xsl:value-of select="$symbol"/>
        </td>
        <!--рекусивный вызов-->
        <xsl:call-template name="symbolRecursive">
          <xsl:with-param name="symbol" select="$symbol"/>
          <xsl:with-param name="size" select="$size - 1"/>
          <xsl:with-param name="classBorder" select="$classBorder"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="symbolLeftRecursive">
    <xsl:param name="symbol"></xsl:param>
    <xsl:param name="count"></xsl:param>

    <xsl:if test="$count > 0">
      <xsl:value-of select="$symbol"/>
      <xsl:call-template name="symbolLeftRecursive">
        <xsl:with-param name="count" select="$count - 1"/>
        <xsl:with-param name="symbol" select="$symbol"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="breakStr">
    <!--строка, которую осталось разбить-->
    <xsl:param name="input"></xsl:param>
    <!--размер строки-->
    <xsl:param name="size"></xsl:param>
    <!--количество строк-->
    <xsl:param name="line">1</xsl:param>
    <!--символ, которым заполнить оставшуюся часть строки-->
    <xsl:param name="symbol">-</xsl:param>
    <!--символ-разделитель-->
    <xsl:param name="nullIsPrinted">true</xsl:param>
    <!--класс бордюра-->
    <xsl:param name="classBorder">border-dotted</xsl:param>
    <!--класс бордюра - подчеркивание под символами -->
    <xsl:param name="bottomClassBorder"></xsl:param>
    <!--выравнивание по правому краю-->
    <xsl:param name="alignRight"></xsl:param>
    
    <!--если сторока поместится в size*line-клеточек-->
    <xsl:if test="$size * $line >= string-length($input)">
      <xsl:call-template name="break">
        <xsl:with-param name="input">
          <xsl:if test="$nullIsPrinted !='' or $input != 0">
            <!--если есть необходимость выравнивания по правому краю-->
            <xsl:if test="$alignRight">
              <xsl:call-template name="symbolLeftRecursive">
                <xsl:with-param name="count" select="$size * $line - string-length($input)"/>
                <xsl:with-param name="symbol" select="$symbol"/>
              </xsl:call-template>
            </xsl:if>
            <xsl:value-of select="$input"/>
          </xsl:if>
        </xsl:with-param>
        <xsl:with-param name="size" select="$size"/>
        <xsl:with-param name="line" select="$line"/>
        <xsl:with-param name="symbol" select="$symbol"/>
        <xsl:with-param name="classBorder" select="$classBorder"/>
        <xsl:with-param name="bottomClassBorder" select="$bottomClassBorder"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="break">
    <!--строка, которую осталось разбить-->
    <xsl:param name="input"></xsl:param>
    <!--размер строки-->
    <xsl:param name="size"></xsl:param>
    <!--количество строк-->
    <xsl:param name="line">1</xsl:param>
    <!--символ, которым заполнить оставшуюся часть строки-->
    <xsl:param name="symbol"></xsl:param>
    <!--класс бордюра-->
    <xsl:param name="classBorder"></xsl:param>
    <!--класс бордюра - подчеркивание под символами -->
    <xsl:param name="bottomClassBorder"></xsl:param>
    
    <table style="width: auto; height: auto; margin-top: 2pt">
      <tr class="field_filled">
        <xsl:call-template name="breakRecursive">
          <xsl:with-param name="input" select="substring( $input, 1, $size )"/>
          <xsl:with-param name="classBorder" select="$classBorder"/>
        </xsl:call-template>

        <!--вся строка разобрана, если в бланке еще есть клетки, то нужно заполнить их прочерками-->
        <xsl:call-template name="symbolRecursive">
          <xsl:with-param name="symbol">
            <xsl:value-of select="$symbol"/>
          </xsl:with-param>
          <xsl:with-param name="size" select="$size - string-length($input)"/>
          <xsl:with-param name="classBorder" select="$classBorder"/>
        </xsl:call-template>
      </tr>
      <!-- если нужно под символами подчеркивание -->
      <xsl:if test="$bottomClassBorder">
        <tr>
          <xsl:call-template name="breakRecursive">
            <xsl:with-param name="input" select="substring( $input, 1, $size )"/>
            <xsl:with-param name="classBorder" select="$classBorder"/>
            <xsl:with-param name="bottomClassBorder" select="$bottomClassBorder"/>
          </xsl:call-template>

          <!--вся строка разобрана, если в бланке еще есть клетки, то только рисуем их-->
          <xsl:call-template name="symbolRecursive">
            <xsl:with-param name="symbol"> </xsl:with-param>
            <xsl:with-param name="size" select="$size - string-length($input)"/>
            <xsl:with-param name="classBorder" select="$bottomClassBorder"/>
          </xsl:call-template>
        </tr>
      </xsl:if>
      
    </table>
    <xsl:if test="$line>1">
      <xsl:call-template name="break">
        <xsl:with-param name="input" select="substring( $input, $size+1, string-length($input) )"/>
        <xsl:with-param name="size" select="$size"/>
        <xsl:with-param name="line" select="$line - 1"/>
        <xsl:with-param name="symbol" select="$symbol"/>
        <xsl:with-param name="classBorder" select="$classBorder"/>
        <xsl:with-param name="bottomClassBorder" select="$bottomClassBorder"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!-- Функция для вывода дробей -->
  <xsl:template name="breakDecimalValue">
    <xsl:param name="input"/>
    <!-- Размер целой части -->
    <xsl:param name="size">12</xsl:param>
    <!-- Размер дробной части -->
    <xsl:param name="decsize">2</xsl:param>


    <table style="width:auto">
      <tr>
        <td>
          <xsl:if test="number($input)=0">
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input"/>
              <xsl:with-param name="size" select="$size"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="number($input)!=0">
            <xsl:call-template name="breakStr">
              <xsl:with-param name="input">
                <xsl:choose>
                  <xsl:when test="contains($input,'.')">
                    <xsl:value-of select="substring-before($input,'.')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$input"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
              <xsl:with-param name="nullIsPrinted" select="1"/>
              <xsl:with-param name="size" select="$size"/>
            </xsl:call-template>
          </xsl:if>
        </td>
        <td style="padding: 1pt">.</td>
        <td>
          <xsl:choose>
            <xsl:when test="contains($input,'.')">
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input">
                  <xsl:call-template name="getStringForPrint">
                    <xsl:with-param name="input" select="substring-after($input,'.')"/>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="size" select="$decsize"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="breakStr">
                <xsl:with-param name="input"/>
                <xsl:with-param name="size" select="$decsize"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="getStringForPrint">
    <xsl:param name="input"/>
    <xsl:if test="$input=''">
      <xsl:value-of select="$input"/>
    </xsl:if>
    <xsl:if test="$input!=''">
      <xsl:if test="number(substring($input,string-length($input),1))!=0">
        <xsl:value-of select="$input"/>
      </xsl:if>
      <xsl:if test="number(substring($input,string-length($input),1))=0">
        <xsl:call-template name="getStringForPrint">
          <xsl:with-param name="input" select="substring($input,1,string-length($input)-1)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>