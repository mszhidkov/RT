<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ/@КНД='1166008']" mode ="Title">
		Извещение о получении электронного документа (документов)
	</xsl:template>
	
	<xsl:template match="Файл[Документ/@КНД='1166008']">
		<xsl:apply-templates select="Документ[@КНД='1166008']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166008']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				Форма по КНД 1166008
			</span>
		</p>
		<p>место штампа</p>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="ОтпрДок/ЮЛ">
				<xsl:apply-templates select="@НаимОрг"/>
			</xsl:for-each>
			<xsl:for-each select="ОтпрДок/ФЛ">
				<xsl:apply-templates select="ФИО/@Фамилия"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Имя"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ФИО/@Отчество"/>
			</xsl:for-each>
			<xsl:for-each select="ОтпрДок/КодНО">
				<xsl:apply-templates select="."/>
			</xsl:for-each>
			<xsl:for-each select="ОтпрДок/СпецОперат">
				<xsl:apply-templates select="@НаимОрг"/>
			</xsl:for-each>
		</div>
		<xsl:if test="not(ОтпрДок/КодНО | ОтпрДок/СпецОперат)">
			<hr style="height: 1px; border-right-width: 0px;border-left-width: 0px;border-bottom-width: 0px; border-top: 1px solid #000; margin-left:300pt"/>
		</xsl:if>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="ОтпрДок/ЮЛ">
				<xsl:apply-templates select="@ИННЮЛ"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@КПП"/>
			</xsl:for-each>
			<xsl:for-each select="ОтпрДок/ФЛ">
				<xsl:apply-templates select="@ИННФЛ"/>
			</xsl:for-each>
		</div>
		<div class='headlines'>(полное наименование организации, ИНН/КПП; Ф.И.О. индивидуального предпринимателя (физического лица), ИНН (при наличии); наименование специализированного оператора связи; код налогового органа)</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				Извещение о получении электронного документа (документов)
			</strong>
		</p>
		<xsl:for-each select='ПодтвДок'>
			<span>
				<xsl:for-each select="ЮЛ">
					<xsl:apply-templates select="@НаимОрг"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННЮЛ"/>
					<xsl:text>/</xsl:text>
					<xsl:apply-templates select="@КПП"/>
				</xsl:for-each>
				<xsl:for-each select="ФЛ">
					<xsl:apply-templates select="ФИО/@Фамилия"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Имя"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Отчество"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННФЛ"/>
				</xsl:for-each>
				<xsl:for-each select="КодНО">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
				<xsl:for-each select="СпецОперат">
					<xsl:apply-templates select="@НаимОрг"/>
				</xsl:for-each>
			</span>
			<div class='line'>
				(наименование организации, ИНН/КПП; наименование специализированного
				оператора связи, код налогового органа, ФИО индивидуального
				предпринимателя (физического лица), ИНН (при наличии))
			</div>
			<span>
				<xsl:apply-templates select='@E-mail'/>
			</span>
			<div class='line'>
				(электронный адрес отправителя)
			</div>
		</xsl:for-each>
		<xsl:for-each select='СвИзвещП'>
			<span>
				настоящим документом подтверждает, что
				<xsl:apply-templates select="@ДатаПол"/>
				в
				<xsl:value-of select="translate(@ВремяПол,'.',':')"/>
				был  получен электронный документ (документы) в файле (файлах)
			</span>
			<br/>
			<xsl:for-each select='СведПолФайл'>
				<span>
					<xsl:apply-templates select='@ИмяПостФайла'/>
				</span>
				<div class='line'>
					(наименование файла)
				</div>
			</xsl:for-each>
		</xsl:for-each>
		Отправитель документа (документов):<br/>
		<xsl:for-each select='ОтпрДок'>
			<span>
				<xsl:for-each select="ЮЛ">
					<xsl:apply-templates select="@НаимОрг"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННЮЛ"/>
					<xsl:text>/</xsl:text>
					<xsl:apply-templates select="@КПП"/>
				</xsl:for-each>
				<xsl:for-each select="ФЛ">
					<xsl:apply-templates select="ФИО/@Фамилия"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Имя"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Отчество"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННФЛ"/>
				</xsl:for-each>
				<xsl:for-each select="КодНО">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
				<xsl:for-each select="СпецОперат">
					<xsl:apply-templates select="@НаимОрг"/>
				</xsl:for-each>
				<xsl:text>.</xsl:text>
			</span>
			<div class='line'>
				(наименование организации, ИНН/КПП; наименование специализированного
				оператора связи, код налогового органа, ФИО индивидуального
				предпринимателя (физического лица), ИНН (при наличии))
			</div>
			<span>
				<xsl:apply-templates select='@E-mail'/>
			</span>
			<div class='line'>
				(электронный адрес отправителя)
			</div>
		</xsl:for-each>
		Получатель документа (документов):<br/>
		<xsl:for-each select='ПолДок'>
			<span>
				<xsl:for-each select="ЮЛ">
					<xsl:apply-templates select="@НаимОрг"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННЮЛ"/>
					<xsl:text>/</xsl:text>
					<xsl:apply-templates select="@КПП"/>
				</xsl:for-each>
				<xsl:for-each select="ФЛ">
					<xsl:apply-templates select="ФИО/@Фамилия"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Имя"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ФИО/@Отчество"/>
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="@ИННФЛ"/>
				</xsl:for-each>
				<xsl:for-each select="КодНО">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
				<xsl:for-each select="СпецОперат">
					<xsl:apply-templates select="@НаимОрг"/>
				</xsl:for-each>
				<xsl:text>.</xsl:text>
			</span>
			<div class='line'>
			(наименование организации ИНН/КПП; наименование специализированного
			оператора связи, код налогового органа, ФИО индивидуального
			предпринимателя (физического лица), ИНН (при наличии))
		</div>
			<span>
				<xsl:apply-templates select='@E-mail'/>
			</span>
			<div class='line'>
				(электронный адрес получателя)
			</div>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>