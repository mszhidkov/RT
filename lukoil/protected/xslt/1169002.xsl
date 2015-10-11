<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Файл[Документ[@КНД='1169002']]" mode="Title">
		<xsl:text>Сообщение о результатах проверки</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1169002']">
		<xsl:apply-templates select="Документ[@КНД='1169002']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1169002']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1169002
			</span>
		</p>
		<h2 align="center">Сообщение о результатах проверки</h2>
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
			сообщает, что на Заявление о ввозе товаров и  уплате  косвенных  налогов (далее - Заявление), зарегистрированном в Журнале регистрации  Заявлений
		</div>

		<table class="noborder">
			<tr>
				<td width="50pt" style="text-align:left">
					за N
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвПроверка/@РегНомДок"/>
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

		<table class="noborder">
			<tr>
				<td width="400pt" style="text-align:left">
					Дата представления Заявления на бумажном носителе
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвПроверка/@ДатаРегБум"/>
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

		<table class="noborder">
			<tr>
				<td width="420pt" style="text-align:left">
					Дата представления Заявления в электронном виде по ТКС
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвПроверка/@ДатаРегЭл"/>
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

		<table class="noborder">
			<tr>
				<td width="150pt" style="text-align:left">
					Номер Заявления
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвПроверка/@НомерДокНП"/>
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

		<table class="noborder">
			<tr>
				<td width="150pt" style="text-align:left">
					Дата Заявления
				</td>
				<td style="text-align:center">
					<xsl:value-of select="СвПроверка/@ДатаДокНП"/>
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

		<div>Отправитель документа:</div>
		<table width="100%" class="noborder">
			<tr>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:apply-templates select="СвОтпрДок" mode="FormatSenderOrRecepient"/>
					</div>
				</td>
				<td>,</td>
			</tr>
			<tr>
				<td>
					<div class="line">
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица),
						ИНН (при наличии), наименование и код налогового органа)
					</div>
				</td>
				<td>
				</td>
			</tr>
		</table>

		<div>по</div>
		<table class="noborder" width="100%">
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
						(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии))
					</div>
				</td>
				<td></td>
			</tr>
		</table>

			<xsl:choose>
				<xsl:when test="СвПроверка/@Отметка=1 or СвПроверка/@Отметка=2">
					<table class='noborder' width="100%">
						<tr>
							<td width="120pt">а)* проставлена</td>
							<td width="20pt">
								<xsl:value-of select="СвПроверка/@Отметка"/>
							</td>
							<td>отметка налогового органа об уплате  косвенных налогов в полном объеме и (или) освобождении от налогообложения  налогом на добавленную стоимость и (или) акцизами.
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div class="line">
									<font color="white">.</font>
								</div>
							</td>
							<td>
								
							</td>
						</tr>
					</table>
				</xsl:when>
				<xsl:otherwise>
					<table class="noborder" width="100%">
						<tr>
							<td width="120pt">б)* проставлена</td>
							<td width="20pt">
								<xsl:value-of select="СвПроверка/@Отметка"/>
							</td>
							<td>
								отказано  в  проставлении  отметки  налогового органа об уплате косвенных налогов в полном объеме и (или)  освобождении от налогообложения налогом на добавленную стоимость и  (или)  акцизами.
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div class="line">
									<font color="white">.</font>
								</div>
							</td>
							<td>

							</td>
						</tr>
					</table>
					<br/>
					Уведомление об отказе в проставлении  на  Заявлении  отметки  налогового органа об уплате косвенных налогов  в  полном  объеме   (освобождении от налогообложения налогом на добавленную стоимость и  (или)  акцизами)
					<table class="noborder">
					<tr>
						<td>от</td>
						<td>
							<xsl:value-of select="СвПроверка/@ДатаУведОткз"/>
						</td>
						<td>
							№
						</td>
						<td>
							<xsl:value-of select="СвПроверка/@НомерУведОткз"/>
						</td>
						<td>.</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div class="line">
								<font color="white">.</font>
							</div>
						</td>
						<td></td>
						<td>
							<div class="line">
								<font color="white">.</font>
							</div>
						</td>
						<td></td>
					</tr>
				</table>
				</xsl:otherwise>
			</xsl:choose>

			<br/>

			<table class="noborder">
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

