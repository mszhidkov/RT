<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ[@КНД='1110017']]" mode="Title">
		<xsl:text>Заявление о ввозе товаров и уплате косвенных налогов в электронном виде</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1110017']">

		<h2 align="center">Заявление о ввозе товаров и уплате косвенных налогов в электронном виде</h2>

		<li>
			Версия формы отчетности: <b>
				<xsl:value-of select="@ВерсФорм"/>
			</b>
		</li>
		<li>
			Идентификатор файла: <b>
				<xsl:value-of select="@ИдФайл"/>
			</b>
		</li>
		<li>
			Код формы по КНД: <b>
				<xsl:text>1110017</xsl:text>
		</b>
	</li>

		<xsl:apply-templates select="Документ[@КНД='1110017']"/>
	</xsl:template>
	
	<xsl:template match="Документ[@КНД='1110017']">
		
		<li>
			Дата формирования документа: <b>
				<xsl:value-of select="@ДатаДок"/>
			</b>
		</li>
		<li>
			Отправитель: <b>
				<xsl:apply-templates select="СвОтпр" mode="FormatSenderOrRecepient"/>
			</b>
		</li>
	</xsl:template>
	
</xsl:stylesheet>
