<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Квитанция о приеме  -->
	<xsl:template match="Файл[Документ[@КНД='1167001']]" mode="Title">
		<xsl:text>Квитанция о приеме</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1167001']">
		<xsl:apply-templates select="Документ[@КНД='1167001']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1167001']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1167001
			</span>
		</p>
		<h2 align="center">Квитанция о приеме</h2>
		<div>Получатель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвПолДок" mode="FormatSenderOrRecepient"/>
		</div>
		<div class="line">
			(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица),
			ИНН (при наличии), наименование и код налогового органа)
		</div>
		<div>Подтверждает, что принял <xsl:apply-templates select="СвКвит/@ДатаПрин"/></div>
		<table class="noborder" width='100%'>
			<tr>
				<td width="300pt" style="text-align:left">
					Документ (документы) в электронном виде
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвКвит/@НаимВидДок"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(вид документа)</div>
				</td>
			</tr>
		</table>

		<table class="noborder" width='100%'>
			<tr>
				<td width="220pt" style="text-align:left">
					наименование файла (файлов)
				</td>
				<td style="text-align:center">
					<xsl:for-each select="СвКвит/ИмяПринятФайла">
						<xsl:value-of select="."/>
						<xsl:text>, </xsl:text>
					</xsl:for-each>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">наименование файла (файлов)</div>
				</td>
			</tr>
		</table>
		<div>
			направленный
			<xsl:value-of select="СвКвит/@ДатаНапр"/>
			<xsl:text> в </xsl:text>
			<xsl:value-of select="СвКвит/@ВремНапр"/>
		</div>
		<div>Отправитель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвОтпрДок" mode="FormatSenderOrRecepient"/>
		</div>
		<div class="line">
			(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица),
			ИНН (при наличии), наименование и код налогового органа)
		</div>

		<table class="noborder" width='100%'>
			<tr>
				<td width="50pt" style="text-align:left">
					через
				</td>
				<td style="text-align:center">
					<xsl:if test="НОПром">
						<xsl:value-of select="НОПром/@НаимНО"/>
						<xsl:text> / </xsl:text>
						<xsl:value-of select="НОПром/@КодНО"/>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование и код налогового органа)</div>
				</td>
			</tr>
		</table>
		<div>по</div>
		<table class='noborder' width="100%">
			<tr>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:apply-templates select="СвАдр" mode="FormatTaxPayerInfo"/>
					</div>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии))
					</div>
				</td>
				<td>,</td>
			</tr>
		</table>
		<div>
			который поступил <xsl:value-of select="СвКвит/@ДатаПост"/>
		</div>
		<br/>
		<table class="noborder">
			<tr>
				<td width="250pt" style="text-align:left">
					Руководитель  организации(индивидуальный предприниматель, физическое лицо, уполномоченный представитель, должностное лицо налогового органа)
				</td>
				<td width="250"></td>
				<td width="300">
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td></td>
				<td align="center">
					<xsl:apply-templates select="ФИОДолж" />
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">подпись</div>
				</td>
				<td>
					<div class="line">Ф. И. О.</div>
				</td>
			</tr>
		</table>
	</xsl:template>
	
</xsl:stylesheet>
