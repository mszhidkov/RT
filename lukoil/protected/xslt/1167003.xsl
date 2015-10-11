<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Уведомление об отказе в приеме  -->
	<xsl:template match="Файл[Документ[@КНД='1167003']]" mode="Title">
		<xsl:text>Уведомление об отказе в приеме</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1167003']">
		<xsl:apply-templates select="Документ[@КНД='1167003']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1167003']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1167003
			</span>
		</p>
		<h2 align="center">Уведомление об отказе в приеме</h2>

		<div>Получатель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвПолДок" mode="FormatSenderOrRecepient"/>
		</div>
		<div class="line">
			(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица),
			ИНН (при наличии), наименование и код налогового органа)
		</div>
		<div>Уведомляет, что отправитель документа:</div>
		<div style="text-align:center; margin-right:0pt;">
			<xsl:apply-templates select="СвОтпрДок" mode="FormatSenderOrRecepient"/>
		</div>
		<table class="noborder" width="100%">
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица),
						ИНН (при наличии), наименование и код налогового органа)
					</div>
				</td>
				<td>,</td>
			</tr>
		</table>
		<div>
			<xsl:value-of select="СведУведОтказ/ОбщСвУвед/@ДатаНапр" />
			<xsl:text> в </xsl:text>
			<xsl:value-of select="СведУведОтказ/ОбщСвУвед/@ВремНапр" />
			направил документ (документы)
		</div>
		<table class="noborder" width='100%'>
			<tr>
				<td width="225pt" style="text-align:left">
					наименование файла (файлов)
				</td>
				<td>
					<xsl:for-each select="СведУведОтказ/ОбщСвУвед/ИмяПринятФайла">
						<xsl:value-of select="."/>
						<xsl:text>, </xsl:text>
					</xsl:for-each>
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
		<table class="noborder" width='100%'>
			<tr>
				<td width="50pt" style="text-align:left">
					через
				</td>
				<td align="center">
					<xsl:if test="НОПром">
						<xsl:value-of select="НОПром/@НаимНО"/>
						<xsl:text> / </xsl:text>
						<xsl:value-of select="НОПром/@КодНО"/>
					</xsl:if>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование и код налогового органа)</div>
				</td>
				<td>,</td>
			</tr>
		</table>

		<table class="noborder" width='100%'>
			<tr>
				<td width="25pt" style="text-align:left">
					для
				</td>
				<td align="center">
					<xsl:apply-templates select="СвАдр" mode="FormatTaxPayerInfo"/>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии))</div>
				</td>
				<td>,</td>
			</tr>
		</table>
		<div>
			который поступил <xsl:value-of select="СведУведОтказ/ОбщСвУвед/@ДатаПост" />
		</div>
		<br/>
		<div>Данный документ не принят.</div>
		<br/>
		<div>Причины отказа:</div>
		<table cellspacing="0" border="1" width="100%">
			<tr>
				<th width="300">Код ошибки:</th>
				<th>Сообщение об ошибке:</th>
			</tr>
			<xsl:for-each select="СведУведОтказ/ПеречВыявНар">
				<tr>
					<td>
						<xsl:value-of select="КодОш"/>
					</td>
					<td>
						<xsl:value-of select="ТекстОш"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<xsl:if test="СведУведОтказ/ВыявлНарФайл">
			<div>Нарушения в файлах:</div>
			<table cellspacing="0" border="1" width="100%">
				<tr>
					<th width="300">Имя файла:</th>
					<th>Ошибки</th>
				</tr>
				<xsl:for-each select="СведУведОтказ/ВыявлНарФайл">
					<tr>
						<td>
							<xsl:value-of select="ИмяОбрабФайла"/>
						</td>
						<td>
							<table width="100%">
								<tr>
									<td width="300">Код ошибки:</td>
									<td>Сообщение об ошибке:</td>
									<td>Дополнительные сведения:</td>
								</tr>
								<xsl:for-each select="ПеречВыявНар">
									<tr>
										<td>
											<xsl:value-of select="КодОш"/>
										</td>
										<td>
											<xsl:value-of select="ТекстОш"/>
										</td>
										<td>
											<xsl:value-of select="ИдОш"/>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

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
					<xsl:apply-templates select="ФИОДолж" mode="FormatNameString"/>
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
