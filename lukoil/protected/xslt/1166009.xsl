<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="Файл[Документ/@КНД='1166009']" mode ="Title">
		Уведомление об уточнении налоговой декларации (расчета), представленной в электронном виде
	</xsl:template>
	
	<xsl:template match="Файл[Документ/@КНД='1166009']">
		<xsl:apply-templates select="Документ[@КНД='1166009']"/>
	</xsl:template>
	
	<xsl:template match="Документ[@КНД='1166009']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166009
			</span>
		</p>
		<p>место штампа</p>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="СвОтпр/ОтпрЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
			</xsl:for-each>
			<xsl:for-each select="СвОтпр/ОтпрФЛ">
				<xsl:apply-templates select="ФИО/@Фамилия"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Имя"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Отчество"/>
			</xsl:for-each>
		</div>
		<hr style="height: 1px; border-right-width: 0px;border-left-width: 0px;border-bottom-width: 0px; border-top: 1px solid #000; margin-left:300pt"/>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="СвОтпр/ОтпрЮЛ">
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="СвОтпр/ОтпрФЛ">
				<xsl:apply-templates select="@ИННФЛ"/>
			</xsl:for-each>
		</div>
		<div class="headlines">
			(полное наименование организации, ИНН/КПП; Ф.И.О.
			индивидуального предпринимателя (физического лица), ИНН (при наличии))
		</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				Уведомление об уточнении налоговой декларации (расчета), представленной<br/>
				в электронном виде
			</strong>
		</p>
		<table class='noborder' width='100%'>
			<tr>
				<td width="150pt" style='text-align:right'>Налоговый орган</td>
				<td>
					<xsl:apply-templates select="@КодНО"/>
				</td>
				<td width="250pt">настоящим документом подтверждает</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(код налогового органа)</div>
				</td>
				<td></td>
			</tr>
		</table>
		<span>
			<xsl:for-each select="СвОтпр/ОтпрЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="СвОтпр/ОтпрФЛ">
				<xsl:apply-templates select="ФИО/@Фамилия"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Имя"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Отчество"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННФЛ"/>
			</xsl:for-each>
			<xsl:text>,</xsl:text>
		</span>
		<div class='line'>
			(полное наименование организации, ИНН/КПП; Ф.И.О.
			индивидуального предпринимателя (физического лица), <br/>
			ИНН (при наличии))
		</div>
		<span>
			что в представленной налоговой декларации (расчете)
		</span>
		<br/>
		<xsl:for-each select="СведУвед/ОбщСвУвед">
			<span>
				<xsl:apply-templates select="@НаимОтч"/>
				<xsl:text> (КНД: </xsl:text>
				<xsl:apply-templates select="@КНД"/>
				<xsl:text>), </xsl:text>
				<xsl:choose>
					<xsl:when test="@НомКорр = '0'">
						<xsl:text>первичная(ый), </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>корректировка №</xsl:text>
						<xsl:value-of select="@НомКорр"/>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</span>
			<div class='line'></div>
			<span>
				<xsl:text> код отчетного периода </xsl:text>
				<xsl:apply-templates select="@Период"/>
				<xsl:text> (</xsl:text>
				<xsl:apply-templates select="@Период" mode="FormatXMLPeriod"/>
				<xsl:text>)</xsl:text>
				<xsl:text> за </xsl:text>
				<xsl:apply-templates select="@ОтчетГод"/>
				<xsl:text> год</xsl:text>
			</span>
		</xsl:for-each>
		<div class='line'>
			(наименование и КНД налоговой декларации, вид документа
			(номер корректировки), код отчетного (налогового) периода, <br/>
			отчетный год)
		</div>
		<xsl:for-each select='СведУвед/ВыявлОшФайл'>
			<table class='noborder' width='100%'>
				<tr>
					<td width='60'>
						в файле
					</td>
					<td>
						<xsl:apply-templates select='ИмяОбрабФайла'/>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<div class='line' >(наименование файла)</div>
					</td>
				</tr>
			</table>
			<span>неправильно заполнены реквизиты</span>
			<table border="0" style="border: 1px solid black; font-size:11.0pt">
				<thead>
					<xsl:if test="not(count(//@ПолОшЭл)='0')">
						<xsl:call-template name="ColHeader">
							<xsl:with-param name="Hint">XPath путь к «ошибочному» элементу, включая сам элемент.</xsl:with-param>
							<xsl:with-param name="Text">Местоположение ошибочного элемента в XML файле</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Text">Ошибочное значение показателя</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Hint">Код ошибки в соответствии с Классификатором ошибок, форматно-логического контроля.</xsl:with-param>
						<xsl:with-param name="Text">Код ошибки</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Text">Текст сообщения об ошибке</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Hint">Текстовая строка, включающая последовательность наименований и значений элементов, идентифицирующих местоположение ошибки в файле обмена до «ошибочного» элемента</xsl:with-param>
						<xsl:with-param name="Text">Идентификатор ошибки</xsl:with-param>
					</xsl:call-template>
				</thead>
				<xsl:for-each select="СвПоОшибке">
					<tr>
						<xsl:if test="not(count(//@ПолОшЭл)='0')">
							<xsl:call-template name="Cell">
								<xsl:with-param name="Text">
									<xsl:apply-templates select="@ПолОшЭл"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:apply-templates select="@ЗнЭлем"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:apply-templates select="@КодОшибки"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:value-of select="ТекстОш"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:value-of select="ИдОш"/>
							</xsl:with-param>
						</xsl:call-template>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
		</xsl:for-each>
		<p>
			Предлагаем представить в течение пяти рабочих дней
			необходимые пояснения или внести соответствующие исправления в установленный
			срок.
		</p>
		<br/>
		<br/>
		<p style='font-size:11.0pt'>Должностное лицо</p>
		<table class="noborder" width='100%' cellpadding='10'>
			<tr>
				<td>
					<div class='line'>(должность)</div>
				</td>
				<td>
					<div class='line'>(подпись)</div>
				</td>
				<td>
					<div class='line'>(Ф.И.О.)</div>
				</td>
			</tr>
			<tr>
				<td colspan='2' style='text-align:center'>М.П.</td>
				<td></td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>