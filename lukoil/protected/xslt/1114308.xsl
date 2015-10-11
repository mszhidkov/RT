<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="Файл[Документ[@КНД='1114308']]" mode="Title">
		<xsl:text>Уведомление банком налогового органа о факте выдачи банковской гарантии налогоплательщику</xsl:text>
	</xsl:template>

	<xsl:template match="Файл[Документ/@КНД='1114308']">

		<h2 align="center">Уведомление банком налогового органа о факте выдачи банковской гарантии налогоплательщику</h2>

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
				<xsl:text>1114308</xsl:text>
			</b>
		</li>

		<xsl:apply-templates select="Документ[@КНД='1114308']"/>
	</xsl:template>

	<xsl:template match="Документ[@КНД='1114308']">

		<li>
			Дата формирования документа: <b>
				<xsl:value-of select="@ДатаДок"/>
			</b>
		</li>
		<li>
			Отправитель: <b>
				<xsl:value-of select="УведПравОсв/СвБанк/@НаимБанк"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="УведПравОсв/СвБанк/@ИННБанк"/>
			</b>
		</li>
		<li>
			Налогоплательщик: <b>
				<xsl:apply-templates select="СвНП"/>
			</b>
		</li>
	</xsl:template>
	
	<!--<xsl:template match="/Файл/Документ" mode="MakeTreeBranch">
		<xsl:param name="Group"/>
		<xsl:param name="ParentID"/>
		<xsl:param name="Content"/>
		<xsl:param name="Position">
			<xsl:apply-templates select="." mode="GetPosition"/>
		</xsl:param>
		<xsl:param name="GroupPosition"  select="$Position"/>
		<xsl:param name="GroupTitle">
			<xsl:apply-templates select="." mode="GroupTitle"/>
		</xsl:param>

		<xsl:variable name="GroupID">
			<xsl:value-of select="$ParentID"/>
			<xsl:value-of select="$Group"/>
			<xsl:value-of select="$GroupPosition"/>
		</xsl:variable>

		<tr id="{$GroupID}_Branch">
			<td class="subtree" colspan="2">
				<table width="100%">
					<xsl:if test="$GroupTitle != ''">
						<tr>
							<th colspan="2">
								<xsl:value-of select="$GroupTitle"/>
							</th>
						</tr>
					</xsl:if>

					<xsl:apply-templates select="." mode="MakeList">
						<xsl:with-param name="ID" select="$GroupID"/>
						<xsl:with-param name="Name">Doc</xsl:with-param>
						<xsl:with-param name="Title">

							<xsl:call-template name="DefaultDocSectionTitle"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</table>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Документ" mode="Sections">
		<xsl:param name="GroupID"/>
		<xsl:param name="Group"/>
		<xsl:param name="Content"/>
		<xsl:apply-templates select="." mode="Section">
			<xsl:with-param name="Name" select="$Group"/>
			<xsl:with-param name="Content" select="$Content"/>
			<xsl:with-param name="Title">Титульный лист</xsl:with-param>
			<xsl:with-param name="Mode"/>
		</xsl:apply-templates>
	</xsl:template>-->

	<!--<xsl:template match="Документ">-->
		<!--<xsl:attribute name="sps:Path">
			<xsl:apply-templates select="." mode="MakePath"/>
		</xsl:attribute>-->

		<!--<h2 align="center">Уведомление банком налогового органа о факте выдачи банковской гарантии налогоплательщику</h2>

		<li>
			Версия формы отчетности: <b>
				<xsl:value-of select="ancestor::Файл/@ВерсФорм"/>
			</b>
		</li>
		<li>
			Идентификатор файла: <b>
				<xsl:value-of select="ancestor::Файл/@ИдФайл"/>
			</b>
		</li>
		<li>
			Код формы по КНД: <b>
				<xsl:text>1114308</xsl:text>
			</b>
		</li>
		<li>
			Дата формирования документа: <b>
				<xsl:value-of select="@ДатаДок"/>
			</b>
		</li>
		<li>
			Отправитель: <b>
				<xsl:value-of select="УведПравОсв/СвБанк/@НаимБанк"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="УведПравОсв/СвБанк/@ИННБанк"/>
			</b>
		</li>
		<li>
			Налогоплательщик: <b>
				<xsl:apply-templates select="СвНП"/>
			</b>
		</li>
	</xsl:template>-->
	
	
	<xsl:template match="СвНП">
		<xsl:choose>
			<xsl:when test="НПЮЛ">
				<xsl:value-of select="НПЮЛ/@НаимЮЛ"/>
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="НПЮЛ/@ИННЮЛ"/>
				<xsl:text> / </xsl:text>
				<xsl:value-of select="НПЮЛ/@КПП"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="НПИП/ФИОИП" mode="FormatNameString"/>
				<!--<xsl:apply-templates select="НПИП/ФИОИП"/>-->
				<xsl:text> ; </xsl:text>
				<xsl:value-of select="НПИП/@ИННИП"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--<xsl:template match="НПИП/ФИОИП">
		<xsl:value-of select="@Фамилия"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="@Имя"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="@Отчество"/>
	</xsl:template>-->
	
	<!--////////////////////////используется в режиме формы -->
	
</xsl:stylesheet>

