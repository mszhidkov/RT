<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Квитанция о приеме  -->
	<xsl:template match="Файл[Документ[@КНД='1169004']]" mode="Title">
		<xsl:text>Сообщение о несоответствиях</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1169004']">
		<xsl:apply-templates select="Документ[@КНД='1169004']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1169004']">
		<p align="right" style="text-align:right">
			<span style="font-size:11.0pt">
				Форма по КНД 1169004
			</span>
		</p>
		<h2 align="center">Сообщение о несоответствиях</h2>
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
					<xsl:value-of select="СвНесоответ/@РегНомДок"/>
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
					<xsl:value-of select="СвНесоответ/@ДатаРегБум"/>
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
					<xsl:value-of select="СвНесоответ/@ДатаРегЭл"/>
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
					<xsl:value-of select="СвНесоответ/@НомерДокНП"/>
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
					<xsl:value-of select="СвНесоответ/@ДатаДокНП"/>
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
		<table class='noborder' width="100%">
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

		<div>от налоговых органов</div>
		<table class='noborder' width="100%">
			<tr>
				<td>
					<div style="text-align:center; margin-right:0pt;">
						<xsl:choose>
							<xsl:when test="СвНесоответ/@КодСтранПрод1='112'">
								<xsl:text>Республики Беларусь</xsl:text>
							</xsl:when>
							<xsl:when test="СвНесоответ/@КодСтранПрод1='398'">
								<xsl:text>Республики Казахстан</xsl:text>
							</xsl:when>
						</xsl:choose>
					</div>
				</td>
				<td>,</td>
			</tr>
			<tr>
				<td>
					<div class="line">
						(Республики Беларусь или Республики Казахстан)
					</div>
				</td>
				<td></td>
			</tr>
		</table>

		<xsl:if test="СвНесоответ/@ТипПр=1 or СвНесоответ/@ТипПр=3">
			<table class='noborder'>
				<tr>
					<td width="100pt">
						а)*поступил
					</td>
					<td width="120pt">
						<xsl:value-of select="СвНесоответ/@ДатаФЛК"/>
					</td>
					<td width="300pt">
						Протокол форматно-логического контроля
					</td>
					<td width="350pt">
						<xsl:value-of select="СвНесоответ/@ИмяФЛК"/>
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
							(имя файла)
						</div>
					</td>
				</tr>
			</table>
			<div>в котором указано следующее:</div>
			<table cellspacing="0" border="1" width="100%">
				<tr>
					<th width="300">Наименование реквизита</th>
					<th width="300">Код ошибки</th>
					<th>Сообщение об ошибке:</th>
				</tr>
				<xsl:for-each select="СвНесоответ/ОшибкиФЛК">
					<tr>
						<td>
							<xsl:value-of select="@НаимРеквОш"/>
						</td>
						<td>
							<xsl:value-of select="@КодОшиб"/>
						</td>
						<td>
							<xsl:value-of select="@ТекстОшиб"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

		<xsl:if test="СвНесоответ/@ТипПр=2 or СвНесоответ/@ТипПр=3">
			<table class='noborder'>
				<tr>
					<td width="100pt">
						а)*поступил
					</td>
					<td width="120pt">
						<xsl:value-of select="СвНесоответ/@ДатаИД"/>
					</td>
					<td width="300pt">
						Протокол  идентификации  обработанных  Заявлений
					</td>
					<td width="350pt">
						<!--<xsl:value-of select="СвНесоответ/@ИмяФЛК"/>-->
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
							(имя файла)
						</div>
					</td>
				</tr>
			</table>
			<div>в котором указано следующее:</div>
			<table cellspacing="0" border="1" width="100%">
				<tr>
					<th>ИНН (УНП, ИИН) продавца</th>
					<th>Комментарий</th>
				</tr>
				<xsl:for-each select="СвНесоответ/ОшибкиИД">
					<tr>
						<td>
							<xsl:value-of select="@ИдНомПрод1"/>
						</td>
						<td>
							<xsl:value-of select="@Коммент"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

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
