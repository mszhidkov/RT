<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Файл[Документ/@КНД='1166001']" mode="Title">
		<xsl:text>Уведомление об уточнении отчётности</xsl:text>
	</xsl:template>
	
	<xsl:template match="Файл[Документ/@КНД='1166001']">
		<h1>Уведомление об уточнении декларации (расчёта)</h1>
		<xsl:apply-templates select="." mode="Common"/>
		<xsl:apply-templates select="Документ/СведУвед"/>
	</xsl:template>
	
	<xsl:template match="СведУвед">
		<xsl:apply-templates select="ОбщСвУвед"/>
		<xsl:if test="РекНал">
			<hr/>
			<h2>Рекомендация  (предупреждение)  налогоплательщику</h2>
			<table border="1">
				<xsl:for-each select="РекНал">
				<tr><td><xsl:value-of select="."/></td></tr>
				</xsl:for-each>
			</table>
		</xsl:if>
		<xsl:if test="СвПоОшибке">
			<xsl:variable name="CountCol1"><xsl:call-template name="HasCol"><xsl:with-param name="Data" select="СвПоОшибке/@ПолОшЭл"/></xsl:call-template></xsl:variable>
			<xsl:variable name="CountCol2"><xsl:call-template name="HasCol"><xsl:with-param name="Data" select="СвПоОшибке/@ЗнЭлем"/></xsl:call-template></xsl:variable>
			<xsl:variable name="CountCol3"><xsl:call-template name="HasCol"><xsl:with-param name="Data" select="СвПоОшибке/@КодОшибки"/></xsl:call-template></xsl:variable>
			<xsl:variable name="CountCol5"><xsl:call-template name="HasCol"><xsl:with-param name="Data" select="СвПоОшибке/ИдОш"/></xsl:call-template></xsl:variable>
			<hr/>
			<h2>Сведения по выявленным ошибкам</h2>
			<table border="0" style="border: 1px solid black;" >
				<thead>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="ColSpan" select="$CountCol1"/>
						<xsl:with-param name="Hint">XPath путь к «ошибочному» элементу, включая сам элемент.</xsl:with-param>
						<xsl:with-param name="Text">Местоположение ошибочного элемента в XML файле</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="ColSpan" select="$CountCol2"/>
						<xsl:with-param name="Text">Ошибочное значение показателя</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="ColSpan" select="$CountCol3"/>
						<xsl:with-param name="Hint">Код ошибки в соответствии с Классификатором ошибок, форматно-логического контроля.</xsl:with-param>
						<xsl:with-param name="Text">Код ошибки</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="Text">Текст сообщения об ошибке</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ColHeader">
						<xsl:with-param name="ColSpan" select="$CountCol5"/>
						<xsl:with-param name="Hint">Текстовая строка, включающая последовательность наименований и значений элементов, идентифицирующих местоположение ошибки в файле обмена до «ошибочного» элемента</xsl:with-param>
						<xsl:with-param name="Text">Идентификатор ошибки</xsl:with-param>
					</xsl:call-template>
				</thead>
				<xsl:for-each select="СвПоОшибке">
					<tr>
						<xsl:call-template name="Cell">
							<xsl:with-param name="ColSpan" select="$CountCol1"/>
							<xsl:with-param name="Text"><xsl:apply-templates select="@ПолОшЭл" mode="XPath"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="ColSpan" select="$CountCol2"/>
							<xsl:with-param name="Text"><xsl:apply-templates select="@ЗнЭлем"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="ColSpan" select="$CountCol3"/>
							<xsl:with-param name="Text"><xsl:apply-templates select="@КодОшибки"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="Text"><xsl:value-of select="ТекстОш"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="Cell">
							<xsl:with-param name="ColSpan" select="$CountCol5"/>
							<xsl:with-param name="Text"><xsl:value-of select="ИдОш"/></xsl:with-param>
						</xsl:call-template>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="ОбщСвУвед">
		<hr/>
		<h2>Общие сведения уведомления</h2>
		<li>Дата приёма файла в налоговом органе:
			<span>
				<xsl:attribute name="title">
					<xsl:text>Имя обработанного файла: </xsl:text>
					<xsl:apply-templates select="@ИмяОбрабФайла"/>
				</xsl:attribute>
				<b><xsl:apply-templates select="@ДатаПрием" mode="XMLFormatLongDate"/></b>
				<sup>*</sup>
			</span>
		</li>
		<li>Название программного комплекса, осуществившего проверку отчётности:
			<span>
				<xsl:attribute name="title">
					<xsl:text>Регистрационный номер отчётности в налоговом органе: </xsl:text>
					<xsl:apply-templates select="@РегНом"/>
				</xsl:attribute>
				<b><xsl:value-of select="@ПрогрКомпл"/></b>
				<sup>*</sup>
			</span>
		</li>
		<xsl:for-each select="@КНД">
			<li>Код формы отчетности по КНД: <b>
			<xsl:apply-templates select="."/>
			</b></li>
		</xsl:for-each>
		<xsl:if test="@НаимОтч">
			<li>Наименование формы отчётности:
				<span>
					<xsl:attribute name="title">
						<xsl:text>Версия формата: </xsl:text>
						<xsl:apply-templates select="@ВерсФорм"/>
					</xsl:attribute>
					<b><xsl:value-of select="@НаимОтч"/></b>
					<sup>*</sup>
				</span>
			</li>
		</xsl:if>
		<xsl:for-each select="@НомКорр">
			<li>Номер корректировки: <b>
			<xsl:value-of select="."/> (<xsl:apply-templates select="."/>)
			</b></li>
		</xsl:for-each>
		<xsl:for-each select="@ОтчетГод">
			<li>Отчетный год: <b>
			<xsl:apply-templates select="." mode="FormatLongYear"/>
			</b></li>
		</xsl:for-each>
		<xsl:for-each select="@Период">
			<li>Период: <b>
			<xsl:value-of select="."/>
			</b></li>
		</xsl:for-each>
		<xsl:for-each select="@ПериодНаим">
			<li>Наименование налогового (отчётного) периода: <b>
			<xsl:value-of select="."/>
			</b></li>
		</xsl:for-each>
		<xsl:if test="@ДатаДок">
			<li>Дата формирования документа:
				<span>
					<xsl:attribute name="title">
						<xsl:text>Идентификатор обработанного документа: </xsl:text>
						<xsl:apply-templates select="@ИдДок"/>
					</xsl:attribute>
					<b><xsl:apply-templates select="@ДатаДок" mode="FormatLongDate"/></b>
					<sup>*</sup>
				</span>
			</li>
		</xsl:if>
		<li>Признак уточнения: <b>
		<xsl:apply-templates select="@ПрУточ"/>
		</b></li>
		<li>Дата формирования уведомления:
			<span>
				<xsl:attribute name="title">
					<xsl:text>Регистрационный номер уведомления в налоговом органе: </xsl:text>
					<xsl:apply-templates select="@РегНомУвед"/>
				</xsl:attribute>
				<b><xsl:apply-templates select="@ДатаФормУвед" mode="FormatLongDate"/></b>
				<sup>*</sup>
			</span>
		</li>
		<li>Код обработки  обобщённый: <b>
		<xsl:apply-templates select="@КодОшОб"/>
		</b></li>
		<li>Текст обработки обобщённый: <b>
		<xsl:value-of select="ТекстОшОб"/>
		</b></li>
	</xsl:template>
	
	<xsl:template match="@ПрУточ">
		<xsl:choose>
			<xsl:when test="1">Декларация (расчет) не содержит ошибок (противоречий)</xsl:when>
			<xsl:when test="2">Декларация (расчет) содержит ошибки и требует уточнения</xsl:when>
			<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>


