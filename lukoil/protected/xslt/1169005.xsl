<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Файл[Документ[@КНД='1169005']]" mode="Title">
		<xsl:text>Сообщение о проставлении отметки налогового органа</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1169005']">
		<xsl:apply-templates select="Документ[@КНД='1169005']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1169005']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Код по КНД 1169005
			</span>
		</p>
		<h2 align="center">Сообщение о проставлении отметки налогового органа</h2>
		<div style="text-align:center; margin-bottom:10pt;">
			<div style="width: 100pt; margin: 0 auto;">
				<table class="noborder">
					<tr>
						<td valign="top" style="padding-right: 5pt;">
							от
						</td>
						<td valign="top">
							<div style="text-align:center; margin-right:0pt;">
								<xsl:value-of select="СвОтметка/@ДатаСообОтм"/>
							</div>
							<div class="line">
								(дата)
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:if test="НОПром">
				<xsl:value-of select="НОПром/@НаимНО"/>
				<xsl:text> / </xsl:text>
				<xsl:value-of select="НОПром/@КодНО"/>
			</xsl:if>
		</div>
		<div class="line">
			(наименование и код налогового органа)
		</div>
		<div>
			сообщает, что на заявление о ввозе товаров и  уплате  косвенных  налогов (далее - заявление), зарегистрированном в Журнале регистрации заявлений
		</div>

		<table class="noborder">
			<tr>
				<td width="50pt" style="text-align:left">
					за N
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвОтметка/@РегНомДок"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">
						<font color="white">.</font>
					</div>
				</td>
			</tr>
		</table>

		<table class="noborder" style="margin-bottom: 10pt;">
			<tr>
				<td style="text-align:left">
					Дата представления заявления на бумажном носителе
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвОтметка/@ДатаРегБум"/>
					</span>
					, в электронном виде по ТКС
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвОтметка/@ДатаРегЭл"/>
					</span>
				</td>
			</tr>
		</table>

		<table class="noborder" style="margin-bottom: 10pt;">
			<tr>
				<td style="text-align:left">
					Дата заявления
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвОтметка/@ДатаДокНП"/>
					</span>
					, Номер заявления
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвОтметка/@НомерДокНП"/>
					</span>
				</td>
			</tr>
		</table>

		<div>Отправитель заявления:</div>
		<table width="100%" class="noborder">
			<tr>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:apply-templates select="СвПолДок" mode="FormatSenderOrRecepient"/>
					</div>
				</td>
				<td>,</td>
			</tr>
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. физического лица,
						ИНН (при наличии))
					</div>
				</td>
				<td>
				</td>
			</tr>
		</table>

		<div>Налогоплательщик - заявитель (импортер):</div>
		<table class="noborder" width="100%" style="margin-bottom: 10pt;">
			<tr>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:apply-templates select="СвНП" mode="FormatTaxPayerInfo"/>
					</div>
				</td>
				<td>,</td>
			</tr>
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя
						(физического лица), ИНН (при наличии))
					</div>
				</td>
				<td></td>
			</tr>
		</table>

		<div>
			проставлена <span style="text-decoration: underline;">
				<xsl:value-of select="СвОтметка/@ДатаОтмПров"/>
			</span> отметка налогового органа об уплате косвенных
			налогов (освобождении от налогообложения налогом на добавленную стоимость
			и (или) акцизами) по месту постановки на учет покупателя.
		</div>

		<br/>

		<table class="noborder" style="margin-bottom: 10pt;">
			<tr>
				<td width="300pt" style="text-align:left">
					Должностное лицо налогового органа
				</td>
				<td width="250"></td>
				<td width="300">
				</td>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="ДолжНО/@Долж"/>, <xsl:value-of select="ДолжНО/@Чин"/>
				</td>
				<td></td>
				<td align="center">
					<xsl:apply-templates select="ДолжНО/ФИОДолж" mode="FormatNameString"/>
				</td>
			</tr>
			<tr>
				<td>
					<div class="line">(должность, классный чин)</div>
				</td>
				<td>
					<div class="line">(подпись)</div>
				</td>
				<td>
					<div class="line">(Ф. И. О.)</div>
				</td>
			</tr>
		</table>

		<xsl:if test="ДолжНО/@Тлф">
			<div style="margin-bottom: 10pt;">
				Телефон: <span style="text-decoration: underline;">
					<xsl:value-of select="ДолжНО/@Тлф"/>
				</span>
			</div>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>

