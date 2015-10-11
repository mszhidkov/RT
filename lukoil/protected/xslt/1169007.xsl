<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Файл[Документ[@КНД='1169007']]" mode="Title">
		<xsl:text>Сообщение об отказе в проставлении отметки налогового органа</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1169007']">
		<xsl:apply-templates select="Документ[@КНД='1169007']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1169007']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Код по КНД 1169007
			</span>
		</p>
		<div style="text-align:center; margin-bottom:10pt;">
			<div style="width: 100pt; margin: 0 auto;">
				<table class="noborder">
					<tr>
						<td valign="top" style="padding-right: 5pt;">
							от
						</td>
						<td valign="top">
							<div style="text-align:center; margin-right:0pt;">
								<xsl:value-of select="СвУведом/@ДатаУведОткз"/>
							</div>
							<div class="line">
								(дата)
							</div>
						</td>
						<td valign="top" style="padding-right: 5pt; padding-left: 30pt;">
							№
						</td>
						<td valign="top">
							<div style="text-align:center; margin-right:0pt;">
								<xsl:value-of select="СвУведом/@НомерУведОткз"/>
							</div>
							<div class="line">
								(номер)
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
					<xsl:value-of select="СвУведом/@РегНомДок"/>
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

		<xsl:if test="СвУведом/@ДатаРегБум">
			<table class="noborder" style="margin-bottom: 10pt;">
				<tr>
					<td style="text-align:left">
						Дата представления заявления на бумажном носителе
						<span style="text-decoration: underline;">
							<xsl:value-of select="СвУведом/@ДатаРегБум"/>
						</span>
						, в электронном виде по ТКС
						<span style="text-decoration: underline;">
							<xsl:value-of select="СвУведом/@ДатаРегЭл"/>
						</span>
					</td>
				</tr>
			</table>
		</xsl:if>
		<xsl:if test="not(СвУведом/@ДатаРегБум)">
			<table class="noborder" style="margin-bottom: 10pt;">
				<tr>
					<td style="text-align:left">
						Дата представления заявления
						<span style="text-decoration: underline;">
							<xsl:value-of select="СвУведом/@ДатаРегЭл"/>
						</span>
					</td>
				</tr>
			</table>
		</xsl:if>

		<table class="noborder" style="margin-bottom: 10pt;">
			<tr>
				<td style="text-align:left">
					Дата заявления
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвУведом/@ДатаДокНП"/>
					</span>
					, Номер заявления
					<span style="text-decoration: underline;">
						<xsl:value-of select="СвУведом/@НомерДокНП"/>
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

		<xsl:if test="СвУведом/СвНесоотв">
			<div>
				выявила следующие     несоответствия  сведений,   указанных в   названном

				заявлении между собой и (или) сведениям, содержащимся в    представленных

				документах (информации), и (или) сведениям, имеющимся в налоговом органе,

				и (или)   требованиям,   установленным   нормативными актами государств -

				членов Таможенного союза:
			</div>
			<ol>
				<xsl:for-each select="СвУведом/СвНесоотв">
					<li>
						<span style="text-decoration: underline;">
							<xsl:value-of select="text()"/>
						</span>
					</li>
				</xsl:for-each>
			</ol>
		</xsl:if>

		<br />

		<xsl:if test="СвУведом/СвНепредст">
			<div>
				установила непредставление следующих обязательных документов,

				предусмотренных пунктом 8 статьи 2 Протокола о порядке взимания косвенных

				налогов и механизме контроля за их уплатой при экспорте и импорте товаров

				в Таможенном союзе  от 11 декабря 2009 года, принятого в соответствии  со

				статьей 4 Соглашения о принципах взимания косвенных налогов при  экспорте

				и импорте товаров, выполнении работ, оказании услуг в Таможенном союзе от

				25 января 2008 года:
			</div>
			<ol>
				<xsl:for-each select="СвУведом/СвНепредст">
					<li>
						<span style="text-decoration: underline;">
							<xsl:value-of select="text()"/>
						</span>
					</li>
				</xsl:for-each>
			</ol>
		</xsl:if>

		<br/>

		<div style="margin-bottom: 10pt;">
			Учитывая изложенное
			<span style="text-decoration: underline;">
				<xsl:if test="НОПром">
					<xsl:value-of select="НОПром/@НаимНО"/>
				</xsl:if>
			</span>

			приняла решение об  отказе  в проставлении отметки налогового   органа об

			уплате косвенных  налогов  (освобождении  от налогообложения   налогом на

			добавленную стоимость   и (или)   акцизами) по месту постановки   на учет

			покупателя  на  представленных  экземплярах указанного  выше  заявления о

			ввозе товаров и уплате косвенных налогов.
		</div>

		<table class="noborder" style="margin-bottom: 10pt;">
			<tr>
				<td width="300pt" style="text-align:left">
					Начальник
				</td>
				<td width="250"></td>
				<td width="300">
				</td>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="ДолжНО/@Чин"/>
				</td>
				<td></td>
				<td align="center">
					<xsl:apply-templates select="ДолжНО/ФИОДолж" mode="FormatNameString"/>
				</td>
			</tr>
			<tr>
				<td>
					<div class="line">(классный чин)</div>
				</td>
				<td>
					<div class="line">(подпись)</div>
				</td>
				<td>
					<div class="line">(Ф. И. О.)</div>
				</td>
			</tr>
		</table>

		<div style="margin-bottom: 10pt;">
			Исполнитель: <span style="text-decoration: underline;">
				<xsl:value-of select="ДолжНО/@ФамилИсп"/>
			</span>
		</div>

		<xsl:if test="ДолжНО/@Тлф">
			<div style="margin-bottom: 10pt;">
				Телефон: <span style="text-decoration: underline;">
					<xsl:value-of select="ДолжНО/@Тлф"/>
				</span>
			</div>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>

