<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>

  <xsl:template name="NameFromQualifier">
    <xsl:param name="Qualifier"/>
    <xsl:param name="Code"/>
    <xsl:value-of select="document(concat('',$Qualifier,'.xml'))/Классификатор/Строка[@Код=$Code]"/>
  </xsl:template>

</xsl:stylesheet>