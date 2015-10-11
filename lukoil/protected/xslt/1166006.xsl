<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ/@КНД='1166006']" mode ="Title">
		Уведомление об отказе в приеме налоговой декларации (расчета) в электронном виде
	</xsl:template>
	
	<xsl:template match="Файл[Документ/@КНД='1166006']">
		<xsl:apply-templates select="Документ[@КНД='1166006']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166006']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166006
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
			(реквизиты налогоплательщика (представителя):
			- полное наименование организации, ИНН/КПП;
			- Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии))
		</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				Уведомление об отказе в приеме налоговой декларации (расчета) в электронном виде
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
		<table class="noborder" width='100%'>
			<tr>
				<td width='240pt' style="text-align:left">
					<xsl:apply-templates select="СведУведУточ/ОбщСвУвед/@ДатаПредст"/>
					в
					<xsl:value-of select="translate(СведУведУточ/ОбщСвУвед/@ВремПредст,'.',':')"/>
					направлен файл
				</td>
				<td>
					<xsl:apply-templates select="СведУведУточ/ОбщСвУвед/@ИмяОбрабФайла"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование файла)</div>
				</td>
			</tr>
		</table>
		<table class="noborder" width='100%'>
			<tr>
				<td  width="120pt" style="text-align:left">в налоговый орган</td>
				<td>
					<xsl:for-each select="СвНалОргНап">
						<xsl:apply-templates select="@НаимНО"/>
						<xsl:text>, </xsl:text>
						<xsl:apply-templates select="@КодНО"/>
					</xsl:for-each>
				</td>
				<td width="5pt" style="text-align:right">
					,
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование и код налогового органа)</div>
				</td>
				<td></td>
			</tr>
		</table>
		<span>
			который поступил
			<xsl:apply-templates select="СведУведУточ/ОбщСвУвед/@ДатаПрием"/>.
		</span>
		<br/>
		<br/>
		<span>По основаниям, предусмотренным пунктом 133 Административного регламента ФНС России, утвержденного Приказом Минфина России от 18.01.2008 № 9н:</span>
		<br/>
		<span style ="text-indent:20pt">
			<i>(перечень выявленных нарушений)</i>
		</span>
		<xsl:for-each select="СведУведУточ">
			<table width="100%" border="0" style="border: 1px solid black;">
				<thead>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Text">Код ошибки</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Text">Текст ошибки</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="ПеречВыявНар/ИдОш">
						<xsl:call-template name="ColHeader">
							<xsl:with-param name="Text">Доп. сведения об ошибке</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</thead>
				<xsl:for-each select="ПеречВыявНар">
					<tr>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:value-of select ="КодОш"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text">
								<xsl:value-of select ="ТекстОш"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ИдОш">
							<xsl:call-template name="Cell">
								<xsl:with-param name="Text">
									<xsl:value-of select ="ИдОш"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
			<xsl:for-each select="ВыявлНарФайл">
				<span>
					Перечень выявленных нарушений в файле:
					<xsl:apply-templates select="ИмяОбрабФайла"/>
				</span>
				<table width="100%" border="0" style="border: 1px solid black;">
					<thead>
						<xsl:call-template name="ColHeader">
							<xsl:with-param name="Text">Код ошибки</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="ColHeader">
							<xsl:with-param name="Text">Текст ошибки</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ПеречВыявНар/ИдОш">
							<xsl:call-template name="ColHeader">
								<xsl:with-param name="Text">Доп. сведения об ошибке</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</thead>
					<xsl:for-each select="ПеречВыявНар">
						<tr>
							<xsl:call-template name="Cell">
								<xsl:with-param name="Text">
									<xsl:value-of select ="КодОш"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="Cell">
								<xsl:with-param name="Text">
									<xsl:value-of select ="ТекстОш"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="ИдОш">
								<xsl:call-template name="Cell">
									<xsl:with-param name="Text">
										<xsl:value-of select ="ИдОш"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</tr>
					</xsl:for-each>
				</table>
				<br/>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="СведУведУточ/ОбщСвУвед">
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
		<div class="line">(наименование налоговой декларации, вид документа, отчетный период, отчетный год)</div>
		<span style ="text-indent:20pt">не принимается.</span><br/>
		<span style ="text-indent:20pt">Вам необходимо представить налоговую декларацию (расчет) в сроки, установленные законодательством о налогах и сборах.</span>
		<br/>
		<br/>
		<p style='font-size:11.0pt; float:left;'>Должностное лицо</p>
        <xsl:for-each select="СвНалОргНап">
            <xsl:apply-templates select="@НаимНО"/>
        </xsl:for-each>
		<div class='line' style="margin-left:0pt; margin-right:300pt; clear:both;">(наименование налогового органа)</div>
		<br/>
		<table class="noborder" width='100%' cellpadding='10'>
			<tr>
				<td>
					<div class='line'>(классный чин)</div>
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

			</tr>
		</table>
	</xsl:template>
	<xsl:template name="ColHeader">
		<xsl:param name="RowSpan" select="1"/>
		<xsl:param name="ColSpan" select="1"/>
		<xsl:param name="Hint" select="''"/>
		<xsl:param name="Text"/>
		<xsl:if test="$RowSpan != 0 and $ColSpan != 0">
			<th>
				<xsl:if test="$RowSpan != 1">
					<xsl:attribute name="rowspan">
						<xsl:value-of select="$RowSpan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$ColSpan != 1">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$ColSpan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="translate($Hint,' ','') = ''">
						<xsl:copy-of select="$Text"/>
					</xsl:when>
					<xsl:otherwise>
						<span title="{$Hint}">
							<xsl:copy-of select="$Text"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</th>
		</xsl:if>
	</xsl:template>

	<!-- Ячейка -->
	<xsl:template name="Cell">
		<xsl:param name="RowSpan" select="1"/>
		<xsl:param name="ColSpan" select="1"/>
		<xsl:param name="Class" select="''"/>
		<xsl:param name="Hint" select="''"/>
		<xsl:param name="Text"/>
		<xsl:if test="$RowSpan != 0 and $ColSpan != 0">
			<td>
				<xsl:if test="$RowSpan != 1">
					<xsl:attribute name="rowspan">
						<xsl:value-of select="$RowSpan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$ColSpan != 1">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$ColSpan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="starts-with($Class, 'h')">
					<xsl:attribute name="align">left</xsl:attribute>
				</xsl:if>
				<xsl:call-template name="Value">
					<xsl:with-param name="Class" select="$Class"/>
					<xsl:with-param name="Hint" select="$Hint"/>
					<xsl:with-param name="Text" select="$Text"/>
				</xsl:call-template>
			</td>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Value">
		<xsl:param name="Class" select="''"/>
		<xsl:param name="Hint" select="''"/>
		<xsl:param name="Text"/>
		<xsl:choose>
			<xsl:when test="translate($Hint,' ','') = '' and translate($Class,' ','') = ''">
				<xsl:copy-of select="$Text"/>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:if test="translate($Class,' ','') != ''">
						<xsl:attribute name="class">
							<xsl:value-of select="$Class"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="translate($Hint,' ','') != ''">
						<xsl:attribute name="title">
							<xsl:value-of select="$Hint"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:copy-of select="$Text"/>
					<xsl:if test="translate($Hint,' ','') != '' and not(starts-with($Class, 'h'))">
						<sup>*</sup>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>


