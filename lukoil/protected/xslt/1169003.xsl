<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Файл[Документ[@КНД='1169003']]" mode="Title">
		<xsl:text>Сообщение об отзыве</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1169003']">
		<xsl:apply-templates select="Документ[@КНД='1169003']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1169003']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1169003
			</span>
		</p>
		<h2 align="center">Сообщение об отзыве</h2>
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
					<xsl:value-of select="СвОтзыв/@РегНомДок"/>
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
					<xsl:value-of select="СвОтзыв/@ДатаРегБум"/>
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
					<xsl:value-of select="СвОтзыв/@ДатаРегЭл"/>
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
					<xsl:value-of select="СвОтзыв/@НомерДокНП"/>
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
					<xsl:value-of select="СвОтзыв/@ДатаДокНП"/>
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

		<table calss="noborder">
			<tr>
				<td width="110pt">было отозвано</td>
				<td width="130pt" align="center">
					<xsl:value-of select="СвОтзыв/@ДатаОснОтз"/>
				</td>
				<td width="150pt">из налоговых органов</td>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:choose>
							<xsl:when test="СвОтзыв/@КодСтранПрод1='112'">
								<xsl:text>Республики Беларусь</xsl:text>
							</xsl:when>
							<xsl:when test="СвОтзыв/@КодСтранПрод1='398'">
								<xsl:text>Республики Казахстан</xsl:text>
							</xsl:when>
						</xsl:choose>
					</div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">
						(дата)
					</div>
				</td>
				<td></td>
				<td>
					<div class="line">
						(Республики Беларусь или Республики Казахстан)
					</div>
				</td>
			</tr>
		</table>
		<br/>

		<table class="noborder">
			<tr>
				<td>по следующим причинам: </td>
				<td>
					<xsl:choose>
						<xsl:when test="СвОтзыв/@ПричЗам = '001'">
							<xsl:text>по инициативе налогоплательщика</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>по инициативе налогового органа</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">
						<font color="White">.</font>
					</div>
				</td>
			</tr>
		</table>

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

