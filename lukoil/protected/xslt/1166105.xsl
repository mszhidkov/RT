<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ/@КНД='1166105']" mode="Title">
		<xsl:text>Квитанция о приеме документа</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1166105']">
		<h1>Квитанция о приеме документа</h1>
		<br/>
		<span>
			<xsl:attribute name="title">
				<xsl:text>Идентификатор файла: </xsl:text>
				<xsl:value-of select="@ИдФайл"/>
			</xsl:attribute>
			<li>
				Дата формирования документа:
				<b>
					<xsl:apply-templates select="Документ/@ДатаДок" mode="FormatLongDate"/>
				</b>
			</li>
		</span>
		<xsl:apply-templates select="Документ" />
	</xsl:template>

	<xsl:template match="Документ[@КНД='1166105']">
		<xsl:apply-templates select="." mode="CommonDocInfo"/>
	</xsl:template>
	
	<xsl:template match="Файл/Документ[@КНД='1166105']" mode="CommonDocInfo">
		<xsl:for-each select ="СвПолДок">
			<h2>Сведения о получателе документа, на который формируется файл квитанции</h2>
			<xsl:for-each select="ОтпрЮЛ">
				<li>
					Наименование организации: <b>
						<xsl:value-of select="@НаимОрг"/>
					</b>
				</li>
				<li>
					ИНН организации: <b>
						<xsl:apply-templates select="@ИННЮЛ" mode="FormatINN"/>
					</b>
				</li>
				<li>
					КПП организации: <b>
						<xsl:apply-templates select="@КПП"/>
					</b>
				</li>
			</xsl:for-each>
			<xsl:for-each select="ОтпрФЛ">
				<li>
					Ф.И.О.: <b>
						<xsl:apply-templates select="ФИО" mode="FormatNameString"/>
					</b>
				</li>
				<xsl:for-each select="ИННФЛ[translate(.,' ','')!='']|@ИННФЛ[translate(.,' ','')!='']">
					<li>
						ИНН физического лица (индивидуального предпринимателя): <b>
							<xsl:apply-templates select="." mode="FormatINN"/>
						</b>
					</li>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="ОтпрНО">
				<li>
					Код налогового органа: <b>
						<xsl:apply-templates select="@КодНО"/>
					</b>
				</li>
				<li>
					Наименование налогового органа: <b>
						<xsl:apply-templates select="@НаимНО"/>
					</b>
				</li>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select ="СвОтпрДок">
			<h2>Сведения об отправителе документа, на который формируется файл квитанции</h2>
			<xsl:for-each select="ОтпрЮЛ">
				<li>
					Наименование организации: <b>
						<xsl:value-of select="@НаимОрг"/>
					</b>
				</li>
				<li>
					ИНН организации: <b>
						<xsl:apply-templates select="@ИННЮЛ" mode="FormatINN"/>
					</b>
				</li>
				<li>
					КПП организации: <b>
						<xsl:apply-templates select="@КПП"/>
					</b>
				</li>
			</xsl:for-each>
			<xsl:for-each select="ОтпрФЛ">
				<li>
					Ф.И.О.: <b>
						<xsl:apply-templates select="ФИО" mode="FormatNameString"/>
					</b>
				</li>
				<xsl:for-each select="ИННФЛ[translate(.,' ','')!='']|@ИННФЛ[translate(.,' ','')!='']">
					<li>
						ИНН физического лица (индивидуального предпринимателя): <b>
							<xsl:apply-templates select="." mode="FormatINN"/>
						</b>
					</li>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="ОтпрНО">
				<li>
					Код налогового органа: <b>
						<xsl:apply-templates select="@КодНО"/>
					</b>
				</li>
				<li>
					Наименование налогового органа: <b>
						<xsl:apply-templates select="@НаимНО"/>
					</b>
				</li>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="СвНП">
			<xsl:for-each select="НПЮЛ">
				<xsl:apply-templates select=".">
					<xsl:with-param name="Title">Налогоплательщик - организация</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
			<xsl:for-each select="НПФЛ">
				<xsl:apply-templates select=".">
					<xsl:with-param name="Title">Налогоплательщик - физическое лицо</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="СвНОКвит">
			<h2>Сведения о налоговом органе, который формирует файл квитанции</h2>
			<li>
				Код налогового органа: <b>
					<xsl:apply-templates select="@КодНО"/>
				</b>
			</li>
			<li>
				Наименование налогового органа: <b>
					<xsl:apply-templates select="@НаимНО"/>
				</b>
			</li>
		</xsl:for-each>
		<xsl:for-each select="СвКвит">
			<h2>Сведения квитанции</h2>
			<li>
				Наименование представленного документа: <b>
					<xsl:apply-templates select="@НаимВидДок"/>
				</b>
			</li>
			<li>
				Дата/время направления документа: <b>
					<xsl:apply-templates select="@ДатаНапр"/>
					/<xsl:apply-templates select="@ВремяНапр"/>
				</b>
			</li>
			<li>
				Дата поступления документа: <b>
					<xsl:apply-templates select="@ДатаПост"/>
				</b>
			</li>
			<li>
				Дата принятия документа: <b>
					<xsl:apply-templates select="@ДатаПрин"/>
				</b>
			</li>
			<li>
				Регистрационный номер документа: <b>
					<xsl:apply-templates select="@РегНом"/>
				</b>
			</li>
			<li>
				Имя поступающего файла: <b>
					<xsl:for-each select="ИмяПринятФайла">
						<br/>
						<xsl:apply-templates select="."/>
					</xsl:for-each>
				</b>
			</li>
		</xsl:for-each>
		<xsl:if test="Подписант">
			<h2>Сведения о лице, подписавшем документ</h2>
		</xsl:if>
		<xsl:for-each select="Подписант">
			<li>
				Ф.И.О. подписанта:
				<b>
					<xsl:apply-templates select="ФИО" mode="FormatNameString"/>
				</b>
			</li>
			<li>
				Должность:
				<b>
					<xsl:apply-templates select="@Должн"/>
				</b>
			</li>
			<br/>
			<br/>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
