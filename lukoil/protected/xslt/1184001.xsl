<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Квитанция о приеме  -->
	<xsl:template match="Файл[Документ[@КНД='1184001']]" mode="Title">
		<xsl:text>Документооборот</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1184001']">
		<!--<xsl:apply-templates select="Документ[@КНД='1184001']"/>-->
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1184001
			</span>
		</p>
		<h2 align="center">Документооборот, используемый налоговыми органами при реализации своих полномочий в отношениях, регулируемых законодательством о налогах и сборах</h2>
		<table cellspacing="0">
			<colgroup>
				<col width="300"/>
				<col width="75%"/>
			</colgroup>
			<tr>
				<th>
					<xsl:text>Наименование</xsl:text>
				</th>
				<th>
					<xsl:text>Значение</xsl:text>
				</th>
			</tr>
			<!--<xsl:apply-templates select="@ВерсФорм"/>-->
			<xsl:apply-templates select="@ВерсПрог"/>
			<xsl:apply-templates select="@ИдФайл"/>
			<xsl:apply-templates select="Документ[@КНД='1184001']/@ДатаДок"/>
			<xsl:apply-templates select="Документ[@КНД='1184001']/СвОтпр"/>
		</table>
		<table cellspacing="0" border="1">
			<colgroup>
				<col width="300" />
				<col width="40%" />
				<col width="40%" />
			</colgroup>
			<xsl:apply-templates select="Документ[@КНД='1184001']/СвПолуч"/>
			<xsl:apply-templates select="Документ[@КНД='1184001']/Подписант"/>
		</table>
	</xsl:template>

	<xsl:template match="@ВерсФорм">
		<tr>
			<td>Версия формы отчетности</td>
			<td>
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="@ВерсПрог">
		<tr>
			<td>Подготовлено в программе</td>
			<td>
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="@ИдФайл">
		<tr>
			<td>Идентификатор файла</td>
			<td>
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Документ[@КНД='1184001']/@ДатаДок">
		<tr>
			<td>Дата формирования документа</td>
			<td>
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Документ[@КНД='1184001']/СвОтпр">
		<tr>
			<td>Сведения об отправителе (Код НО)</td>
			<td>
				<xsl:value-of select="@КодНО"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Документ[@КНД='1184001']/СвПолуч">
		<tr>
			<td rowspan="3">Сведения о получателе</td>
			<th colspan="2">
				<xsl:choose>
					<xsl:when test="@ПризПолучУП=1">
						<xsl:text>Налогоплательщик</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Уполномоченный представитель</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</th>
		</tr>
		<xsl:choose>
			<xsl:when test="ПолучЮЛ">
				<tr align="center">
					<td>
						<xsl:text>ИНН/КПП</xsl:text>
					</td>
					<td>
						<xsl:text>Организация</xsl:text>
					</td>
				</tr>
				<tr align="center">
					<td>
						<xsl:value-of select="ПолучЮЛ/@ИННЮЛ"/>
						<xsl:text> / </xsl:text>
						<xsl:value-of select="ПолучЮЛ/@КПП"/>
					</td>
					<td>
						<xsl:value-of select="ПолучЮЛ/@НаимОрг"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr align="center">
					<td>
						<xsl:text>ИНН</xsl:text>
					</td>
					<td>
						<xsl:text>ФИО</xsl:text>
					</td>
				</tr>
				<tr  align="center">
					<td>
						<xsl:value-of select="ПолучФЛ/@ИННФЛ"/>
					</td>
					<td>
						<xsl:value-of select="ПолучФЛ/ФИО/@Фамилия"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="ПолучФЛ/ФИО/@Имя"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="ПолучФЛ/ФИО/@Отчество"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>
	
	<xsl:template match="Документ[@КНД='1184001']/Подписант">
		<tr>
			<td rowspan="3">Сведения о подписанте</td>
			<th colspan="2">
				<xsl:text>Подписант</xsl:text>
			</th>
		</tr>
			<tr align="center">
				<td>
					<xsl:text>Должность</xsl:text>
				</td>
				<td>
					<xsl:text>ФИО</xsl:text>
				</td>
			</tr>
			<tr align="center">
				<td>
					<xsl:value-of select="@Должн"/>
				</td>
				<td>
					<xsl:value-of select="ФИО/@Фамилия"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="ФИО/@Имя"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="ФИО/@Отчество"/>
				</td>
			</tr>
	</xsl:template>

</xsl:stylesheet>
