<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="Файл[Документ/СпрРасчЮЛИП]" mode="Title">
		<xsl:text>Справка о состоянии расчетов по налогам, сборам, пеням и штрафам организаций и индивидуальных предпринимателей</xsl:text>
	</xsl:template>
	
	<xsl:template match="Файл[Документ/СпрРасчЮЛИП]">
		<h1>Справка о состоянии расчетов по налогам, сборам, пеням и штрафам организаций и индивидуальных предпринимателей</h1>
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

	<xsl:template match="Документ[СпрРасчЮЛИП]">
		<xsl:apply-templates select="." mode="CommonDocInfo"/>
	</xsl:template>
	
	<xsl:template match="Документ[СпрРасчЮЛИП]" mode="CommonDocInfo">
		<xsl:for-each select="СвОтпр">
			<xsl:for-each select="СвОтпрЮЛ">
				<xsl:apply-templates select=".">
					<xsl:with-param name="Title">Сведения об отправителе запроса, в ответ на который сформирован документ</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
			<xsl:for-each select="СвОтпрФЛ">
				<xsl:apply-templates select=".">
					<xsl:with-param name="Title">Сведения об отправителе запроса, в ответ на который сформирован документ</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="СпрРасчЮЛИП">
			<h2>Справка о состоянии расчетов по налогам, сборам, пеням и штрафам физических лиц</h2>
			<li>
				Номер справки: <b>
					<xsl:value-of select="@НомСпр"/>
				</b>
			</li>
			<li>
				Дата состояния сведений: <b>
					<xsl:value-of select="@ДатаСостСв"/>
				</b>
			</li>
			<li>
				Код налогового органа: <b>
					<xsl:value-of select="@КодНО"/>
				</b>
			</li>
			<li>
				Суммы денежных средств, списанных банком с расчетного счета налогоплательщика, но не зачисленных на счета по учету доходов бюджетов: <b>
					<xsl:value-of select="@СуммСписБанк"/>
				</b>
			</li>
			<br/>
			<br/>
			<xsl:for-each select="СвНП">
				<xsl:for-each select="НПЮЛ">
					<xsl:apply-templates select=".">
						<xsl:with-param name="Title">Сведения о налогоплательщике - юридическом лице</xsl:with-param>
					</xsl:apply-templates>
				</xsl:for-each>
				<xsl:for-each select="НПФЛ">
					<xsl:apply-templates select=".">
						<xsl:with-param name="Title">Сведения о налогоплательщике - физическом лице</xsl:with-param>
					</xsl:apply-templates>
				</xsl:for-each>
				<xsl:for-each select="АдрРФ">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</xsl:for-each>
			<h2>Справка о состоянии расчетов по виду налога, сбора</h2>
			<table width="100%" border="0" style="border: 1px solid black;">
				<tr>
					<th rowspan="2">
						<span>
							<xsl:attribute name="title">Наименование налога, сбора</xsl:attribute>
							<xsl:text>Наим. налога, сбора</xsl:text>
						</span>
					</th>
					<th rowspan="2">
						<span>
							<xsl:attribute name="title">Код бюджетной классификации</xsl:attribute>
							<xsl:text>КБК</xsl:text>
						</span>
					</th>
					<th rowspan="2">
						<span>
							<xsl:attribute name="title">Код по ОКАТО</xsl:attribute>
							<xsl:text>ОКАТО</xsl:text>
						</span>
					</th>
					<th rowspan="2">
						<span>
							<xsl:attribute name="title">Итоговое сальдо расчетов</xsl:attribute>
							<xsl:text>Итог. сальдо</xsl:text>
						</span>
					</th>
					<th rowspan="2">
						<span>
							<xsl:attribute name="title">Суммы денежных средств, списанных банком с расчетного счета налогоплательщика, но не зачисленных на счета по учету доходов бюджетов</xsl:attribute>
							<xsl:text>Суммы списан.</xsl:text>
						</span>
					</th>
					<xsl:if test ="СодСпрЮЛИП/Налог">
						<th colspan="3">Расчет по налогу</th>
					</xsl:if>
					<xsl:if test ="СодСпрЮЛИП/Налог">
						<th colspan="3">Расчет по пени</th>
					</xsl:if>
					<xsl:if test ="СодСпрЮЛИП/Налог">
						<th colspan="3">Расчет по налоговым санкциям</th>
					</xsl:if>
				</tr>
				<tr>
					<xsl:if test ="СодСпрЮЛИП/Налог">
						<th>
							<span>
								<xsl:attribute name="title">Итоговое сальдо расчетов по налогу</xsl:attribute>
								<xsl:text>Итог. сальдо</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по налогу</xsl:attribute>
								<xsl:text>Сумма</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по налогу</xsl:attribute>
								<xsl:text>Срок до</xsl:text>
							</span>
						</th>
					</xsl:if>
					<xsl:if test ="СодСпрЮЛИП/Пени">
						<th>
							<span>
								<xsl:attribute name="title">Итоговое сальдо расчетов по пени</xsl:attribute>
								<xsl:text>Итог. сальдо</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по пени</xsl:attribute>
								<xsl:text>Сумма</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по пени</xsl:attribute>
								<xsl:text>Срок до</xsl:text>
							</span>
						</th>
					</xsl:if>
					<xsl:if test ="СодСпрЮЛИП/НалСанк">
						<th>
							<span>
								<xsl:attribute name="title">Итоговое сальдо расчетов по налоговым санкциям</xsl:attribute>
								<xsl:text>Итог. сальдо</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по налоговым санкциям</xsl:attribute>
								<xsl:text>Сумма</xsl:text>
							</span>
						</th>
						<th>
							<span>
								<xsl:attribute name="title">Кроме того, отсрочено, рассрочено, в том числе в порядке реструктуризации, приостановлено к взысканию по налоговым санкциям</xsl:attribute>
								<xsl:text>Срок до</xsl:text>
							</span>
						</th>
					</xsl:if>
				</tr>
				<xsl:for-each select="СодСпрЮЛИП">
					<tr>
						<td><xsl:value-of select="@НаимНС"/></td>
						<td><xsl:value-of select="@КБК"/></td>
						<td><xsl:value-of select="@ОКАТО"/></td>
						<td><xsl:value-of select="@ИтогПроц"/></td>
						<td><xsl:value-of select="@СуммСписБанк"/></td>
						<xsl:for-each select="Налог">
							<td><xsl:value-of select="@ИтогНалог"/></td>
							<td><xsl:value-of select="ДолгНалог/@Сумма"/></td>
							<td><xsl:value-of select="ДолгНалог/@Дата"/></td>
					</xsl:for-each>
						<xsl:for-each select="Пени">
							<td><xsl:value-of select="@ИтогПени"/></td>
							<td><xsl:value-of select="ДолгПени/@Сумма"/></td>
							<td><xsl:value-of select="ДолгПени/@Дата"/></td>
					</xsl:for-each>
						<xsl:for-each select="НалСанк">
							<td><xsl:value-of select="@ИтогНалСанк"/></td>
							<td><xsl:value-of select="ДолгНалСанк/@Сумма"/></td>
							<td><xsl:value-of select="ДолгНалСанк/@Дата"/></td>
					</xsl:for-each>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
			<br/>
		</xsl:for-each>
		<xsl:if test="Подписант">
			<xsl:apply-templates select="Подписант"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
