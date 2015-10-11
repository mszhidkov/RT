<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ/@КНД='1166004']" mode ="Title">
		Подтверждение даты отправки
	</xsl:template>

	<xsl:template match="/Файл[Документ/@КНД='1166004']">
		<xsl:apply-templates select="Документ[@КНД='1166004']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166004']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166004
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
			<xsl:for-each select="СвОтпр/ОтпрНО">
				<xsl:apply-templates select="@НаимНО"/>
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
			<xsl:for-each select="СвОтпр/ОтпрНО">
				&#160;
			</xsl:for-each>
		</div>
		<div class="headlines">
			(полное наименование организации, ИНН/КПП; Ф.И.О.
			индивидуального предпринимателя (физического лица), ИНН (при наличии))
		</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				Подтверждение даты отправки
			</strong>
		</p>
		<span>
			<xsl:apply-templates select="ОргПодт/СпецОперат/@НаимОрг | ОргПодт/НО/@КодНО"/>
		</span>
		<div class="line">
			(наименование специализированного оператора связи; код налогового органа)
		</div>
		<span>
			настоящим документом подтверждает, что
			<xsl:apply-templates select="СведПодтв/@ДатаОтпр"/>
			в
			<xsl:value-of select="translate(СведПодтв/@ВремяОтпр,'.',':')"/>
			был отправлен электронный <br/>
			документ в файле<br/>
		</span>
		<xsl:for-each select="СведПодтв/СведОтпрФайл">
			<span>
				<xsl:apply-templates select="@ИмяПостФайла"/>
			</span>
			<div class="line">(наименование файла)</div>
		</xsl:for-each>
		<span>
			Отправитель документа (налогоплательщик, представитель):<br/>
		</span>
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
		</span>
		<div class="line">
			(наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии))
		</div>
		<xsl:apply-templates select="СвОтпр/@E-mail"/>
		<div class="line">
			(электронный адрес отправителя)
		</div>
		<span>
			Получатель документа:<br/>
		</span>
		<span>
			<xsl:for-each select="СвПолДок/ОтпрНО">
				<xsl:apply-templates select="@КодНО"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@НаимНО"/>
			</xsl:for-each>
			<xsl:for-each select="СвПолДок/ОтпрЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="СвПолДок/ОтпрФЛ">
				<xsl:apply-templates select="ФИО/@Фамилия"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Имя"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Отчество"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@ИННФЛ"/>
			</xsl:for-each>
		</span>
		<div class="line">
			(код налогового органа)
		</div>
		<xsl:apply-templates select="СвПолДок/@E-mail"/>
		<div class="line">
			(электронный адрес получателя)
		</div>
	</xsl:template>
</xsl:stylesheet>