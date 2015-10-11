<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Подтверждение даты отправки электронного документа  -->
	<xsl:template match="Файл[Документ[@КНД='1167002']]" mode="Title">
		<xsl:text>Подтверждение даты отправки</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1167002']">
		<xsl:apply-templates select="Документ[@КНД='1167002']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1167002']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1167002
			</span>
		</p>
		<h2 align="center">Подтверждение даты отправки</h2>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:choose>
				<xsl:when test="ОргПодт/СпецОперат">
					<xsl:value-of select="ОргПодт/СпецОперат/@НаимОрг"/>
				</xsl:when>
				<xsl:when test="ОргПодт/НО">
					<xsl:value-of select="ОргПодт/НО/@КодНО"/>
					<xsl:text> / </xsl:text>
					<xsl:value-of select="ОргПодт/НО/@НаимНО"/>
				</xsl:when>
			</xsl:choose>
		</div>
		<div class="line">
			(наименование специализированного оператора связи; наименование и код налогового органа)
		</div>
		<br/>
		<div style="border-top:solid 1pt;">
			Подтверждает, что
			<xsl:value-of select="СведПодтв/@ДатаОтпр"/>
			в
			<xsl:value-of select="СведПодтв/@ВремяОтпр"/>
			был отправлен документ (документы) в файле (файлах)
		</div>
		<br/>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:for-each select="СведПодтв/СведОтпрФайл">
				<xsl:value-of select="@ИмяПостФайла"/>
				<xsl:text>, </xsl:text>
			</xsl:for-each>
		</div>
		<div class="line">
			(наименование файла (файлов))
		</div>
		<div>Отправитель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвОтпр" mode="FormatSenderOrRecepient" />
		</div>
		<table class='noborder' width="100%">
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии), наименование и код налогового органа)
					</div>
				</td>
				<td>
					,
				</td>
			</tr>
		</table>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:value-of select="СвОтпр/@E-mail"/>
		</div>
		<div class="line">
			(электронный адрес отправителя (идентификатор абонента))
		</div>

		<div>Получатель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвПолДок" mode="FormatSenderOrRecepient" />
		</div>
		<table class='noborder' width="100%">
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии), наименование и код налогового органа)
					</div>
				</td>
				<td>
					,
				</td>
			</tr>
		</table>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:value-of select="СвПолДок/@E-mail"/>
		</div>
		<div class="line">
			(электронный адрес получателя (идентификатор абонента))
		</div>
	</xsl:template>

</xsl:stylesheet>
