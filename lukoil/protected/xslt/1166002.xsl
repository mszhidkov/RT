<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ/@КНД='1166002']" mode ="Title">
		Квитанция о приеме налоговой декларации (расчета) в электронном виде
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1166002']">
		<xsl:apply-templates select="Документ[@КНД='1166002']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166002']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166002
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
				Квитанция о приеме налоговой декларации (расчета) в электронном виде
			</strong>
		</p>
		<table class='noborder' width='100%'>
			<tr>
				<td width="150pt" style='text-align:right'>Налоговый орган</td>
				<td>
					<xsl:apply-templates select="@НаимНОПодт"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@КодНОПодт"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование и код налогового органа)</div>
				</td>
			</tr>
		</table>
		<span>настоящим документом подтверждает, что</span>
		<br/>
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
			представил(а)
			<xsl:apply-templates select="СвКвит/@ДатаПредст"/>
			в
			<xsl:value-of select="translate(СвКвит/@ВремПредст,'.',':')"/>
			налоговую декларацию (расчет)
		</span><br/>
		<xsl:for-each select="СвКвит">
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
			(наименование налоговой декларации, вид документа, отчетный период, отчетный год)
		</div>
		<table class="noborder" width='100%'>
			<tr>
				<td width="50pt" style="text-align:left">
					в файле
				</td>
				<td>
					<xsl:apply-templates select="СвКвит/@ИмяОбрабФайла"/>
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
				<td width="117pt" style="text-align:left">
					в налоговый орган
				</td>
				<td>
					<xsl:apply-templates select="СвНалОргПост/@НаимНО"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="СвНалОргПост/@КодНО"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<div class="line">(наименование и код налогового органа)</div>
				</td>
			</tr>
		</table>
		<span>
			которая  поступила
			<xsl:apply-templates select="СвКвит/@ДатаПост"/>
			и  принята  налоговым  органом
			<xsl:apply-templates select="СвКвит/@ДатаПрин"/>
			,
		</span>
		<table class="noborder" width='100%'>
			<tr>
				<td width="150pt" style="text-align:left">
					регистрационный номер
				</td>
				<td width="100pt">
					<xsl:apply-templates select="СвКвит/@РегНом"/>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td style="border-top:1px solid black;"></td>
				<td></td>
			</tr>
		</table>
		<p style='font-size:11.0pt'>Должностное лицо</p>
		<div class='line' style="margin-left:0pt; margin-right:300pt;">(наименование налогового органа)</div>
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
				<td></td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>


