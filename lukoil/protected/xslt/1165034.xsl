<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ[@КНД='1165034']]" mode="Title">
		<xsl:text>Опись документов, направляемых в налоговый орган</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1165034']">

		<h2 align="center">Опись документов, направляемых в налоговый орган</h2>

		<li>
			Версия формы отчетности: <b>
				<xsl:value-of select="@ВерсФорм"/>
			</b>
		</li>
		<li>
			Идентификатор файла: <b>
				<xsl:value-of select="@ИдФайл"/>
			</b>
		</li>
		<li>
			Код формы по КНД: <b>
				<xsl:value-of select="Документ/@КНД"/>
			</b>
		</li>

		<xsl:apply-templates select="Документ[@КНД='1165034']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1165034']">

		<li>
			Дата формирования документа: <b>
				<xsl:value-of select="@ДатаДок"/>
			</b>
		</li>
		<li>
			Отправитель: <b>
				<xsl:apply-templates select="СвОтпр"/>
			</b>
		</li>
		<li>
			Получатель: <b>
				<xsl:apply-templates select="СвПолуч/@КодНО"/>
			</b>
		</li>
		<li>
			Налогоплательщик: <b>
				<xsl:apply-templates select="СвНП" mode="ON_OP"/>
			</b>
		</li>
		<li>
				<xsl:choose>
					<xsl:when test="ИдФайлОсн/ИмяФайлТреб">
						Идентификатор файла документа, к которому  формируется опись:
						<b>
							<xsl:value-of select="ИдФайлОсн/ИмяФайлТреб"/>
						</b>
					</xsl:when>
					<xsl:otherwise>
						Идентификатор файла налоговой декларации (расчета), к которой формируется опись:
						<b>
							<xsl:value-of select="ИдФайлОсн/ИдФайлНалОтч"/>
						</b>
					</xsl:otherwise>
				</xsl:choose>
			
		</li>
		<li>
			Подписант: <b>
				<xsl:apply-templates select="Подписант/ФИО" mode="FormatNameString"/>
			</b>
		</li>
	</xsl:template>

	<xsl:template match="СвНП" mode="ON_OP">
		<xsl:choose>
			<xsl:when test="НПЮЛ">
				<xsl:value-of select="НПЮЛ/@НаимОрг"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="НПЮЛ/@ИННЮЛ"/>
				<xsl:text> / </xsl:text>
				<xsl:value-of select="НПЮЛ/@КПП"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="НПФЛ" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="СвОтпр">
		<xsl:choose>
			<xsl:when test="ОтпрЮЛ">
				<xsl:value-of select="ОтпрЮЛ/@НаимОрг"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="ОтпрЮЛ/@ИННЮЛ"/>
				<xsl:text> / </xsl:text>
				<xsl:value-of select="ОтпрЮЛ/@КПП"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="ОтпрФЛ/ФИО" mode="FormatNameString"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="ОтпрФЛ/@ИННФЛ"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="НПФЛ">
		<xsl:apply-templates select="ФИО" mode="FormatNameString"/>
		<xsl:text> ; </xsl:text>
		<xsl:value-of select="@ИННФЛ"/>
	</xsl:template>

</xsl:stylesheet>

