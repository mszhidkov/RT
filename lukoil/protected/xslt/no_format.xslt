<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>

  <!--Выводит подсказку о том, что нет в формате данных-->
  <xsl:template name="noFotmat">
    <img class="no_format" src="/kilor/xslt/no_format.png" title="Данные не содержатся в формате!"/>
  </xsl:template>


</xsl:stylesheet>