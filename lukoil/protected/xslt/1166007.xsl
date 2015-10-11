<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="Файл[Документ/@КНД='1166007']" mode ="Title">
		Извещение о вводе сведений, указанных в налоговой декларации (расчете)
	</xsl:template>
	
	<xsl:template match="Файл[Документ/@КНД='1166007']">
		<xsl:apply-templates select="Документ[@КНД='1166007']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166007']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166007
			</span>
		</p>
		<p>место штампа</p>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="СвПол/ОтпрЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
			</xsl:for-each>
			<xsl:for-each select="СвПол/ОтпрФЛ">
				<xsl:apply-templates select="ФИО/@Фамилия"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Имя"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Отчество"/>
			</xsl:for-each>
		</div>
		<hr style="height: 1px; border-right-width: 0px;border-left-width: 0px;border-bottom-width: 0px; border-top: 1px solid #000; margin-left:300pt"/>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="СвПол/ОтпрЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="СвПол/ОтпрФЛ">
				<xsl:apply-templates select="@ИННФЛ"/>
			</xsl:for-each>
		</div>
		<div class="headlines">
			(полное наименование организации, ИНН/КПП; Ф.И.О.
			индивидуального предпринимателя (физического лица), ИНН (при наличии))
		</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				Извещение о вводе сведений, указанных в налоговой декларации (расчете)
			</strong>
		</p>
		<table class='noborder' width='100%'>
			<tr>
				<td width="150pt" style='text-align:right'>Налоговый орган</td>
				<td>
					<xsl:apply-templates select="КодНоОтпр"/>
				</td>
				<td width="280pt">настоящим документом подтверждает, что</td>
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
			<xsl:for-each select="СвНП/НПЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="СвНП/НПФЛ">
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
			в налоговой декларации (расчете)
		</span>
		<br/>
		<xsl:for-each select="СвИзвещВ">
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
			<div class='line'>
				(наименование и КНД налоговой декларации, вид документа
				(номер корректировки), код отчетного (налогового) периода, <br/>
				отчетный год)
			</div>
			<table class='noborder' width='100%'>
				<tr>
					<td width='160pt' style='text-align:left;'>
						представленный в файле
					</td>
					<td>
						<xsl:apply-templates select='@ИмяОбрабФайла'/>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<div class='line' >(наименование файла)</div>
					</td>
				</tr>
			</table>
			<span>не содержится ошибок (противоречий).</span>
			<br/>
		</xsl:for-each>
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