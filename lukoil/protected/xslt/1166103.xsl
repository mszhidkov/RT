<?xml version="1.0" encoding="windows-1251"?>
	<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>
		<xsl:template match="/">

		
<table border='0' cellpadding='0' cellspacing='0' width="100%" style='border-collapse:
 collapse;table-layout:fixed'>
 <col width='4' span='133' style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'/>
 <tr height='33' style='mso-height-source:userset;height:24.75pt'>
  <td colspan='132' height='33' class='xl955035' width='528' style='height:24.75pt;
  width:396pt'>Код по КНД 1166103</td>
  <td class='xl635035' width='4' style='width:3pt'></td>
 </tr>
 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td colspan='133' height='13' class='xl665035' style='height:9.75pt'></td>
 </tr>
 
 
	<xsl:variable name="NP_Name_org" select="Документ/СвОтпр/СвОтпрЮЛ/@НаимОрг"/>
	<xsl:variable name="NP_INN" select="Документ/СвОтпр/СвОтпрЮЛ/@ИННЮЛ"/>
	<xsl:variable name="NP_KPP" select="Документ/СвОтпр/СвОтпрЮЛ/@КПП"/>
	<xsl:variable name="NP_org">
		<xsl:value-of select="$NP_Name_org"/>
		<xsl:if test="string-length($NP_INN) &gt; 0">
			<xsl:text>,&#32;<!--ИНН&#32;--></xsl:text>
			<xsl:value-of select="$NP_INN"/>
		</xsl:if>
		<xsl:if test="string-length($NP_INN) &gt; 0 and string-length($NP_KPP) &gt; 0">
			<xsl:text>/</xsl:text>
		</xsl:if>
		<xsl:if test="string-length($NP_KPP) &gt; 0">
			<!--<xsl:text>,&#32;КПП&#32;</xsl:text>-->
			<xsl:value-of select="$NP_KPP"/>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="NP_fiz_Fam" select="Документ/СвОтпр/СвОтпрФЛ/ФИО/@Фамилия"/>
	<xsl:variable name="NP_fiz_Name" select="Документ/СвОтпр/СвОтпрФЛ/ФИО/@Имя"/>
	<xsl:variable name="NP_fiz_Otch" select="Документ/СвОтпр/СвОтпрФЛ/ФИО/@Отчество"/>
	<xsl:variable name="NP_fiz_INN" select="Документ/СвОтпр/СвОтпрФЛ/@ИННФЛ"/>
	<xsl:variable name="NP_fiz">
		<xsl:value-of select="$NP_fiz_Fam"/>
		<xsl:if test="string-length($NP_fiz_Name) &gt; 0">
			<xsl:text>&#32;</xsl:text>
			<xsl:value-of select="$NP_fiz_Name"/>
		</xsl:if>
		<xsl:if test="string-length($NP_fiz_Otch) &gt; 0">
			<xsl:text>&#32;</xsl:text>
			<xsl:value-of select="$NP_fiz_Otch"/>
		</xsl:if>
		<xsl:if test="string-length($NP_fiz_INN) &gt; 0">
			<xsl:text>,&#32;<!--ИНН&#32;--></xsl:text>
			<xsl:value-of select="$NP_fiz_INN"/>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="Name_ot">
		<xsl:value-of select="$NP_org"/>
		<xsl:value-of select="$NP_fiz"/>
	</xsl:variable>
	<xsl:variable name="Name_ot_name">
		<xsl:value-of select="$NP_Name_org"/>
		<xsl:value-of select="$NP_fiz_Fam"/>
		<xsl:if test="string-length($NP_fiz_Name) &gt; 0">
			<xsl:text>&#32;</xsl:text>
			<xsl:value-of select="$NP_fiz_Name"/>
		</xsl:if>
		<xsl:if test="string-length($NP_fiz_Otch) &gt; 0">
			<xsl:text>&#32;</xsl:text>
			<xsl:value-of select="$NP_fiz_Otch"/>
		</xsl:if>
		<xsl:if test="string-length($NP_Name_org) &gt; 0 or string-length($NP_fiz_Fam) &gt; 0">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="Name_ot_INNKPP">
		<xsl:value-of select="$NP_INN"/>
		<xsl:if test="string-length($NP_INN) &gt; 0 and string-length($NP_KPP) &gt; 0">
			<xsl:text>/</xsl:text>
		</xsl:if>
		<xsl:value-of select="$NP_KPP"/>
		<xsl:value-of select="$NP_fiz_INN"/>
	</xsl:variable>
	

<xsl:choose>
	<xsl:when test="string-length($Name_ot) &lt; 29">

 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='59' height='14' class='xl665035' style='height:10.5pt'></td>
  <td colspan='10' class='xl995035'>Кому</td>
  <td colspan='59' class='xl925035' style="font-family:'Courier New', monospace;font-size:8.0pt;">&#160;<xsl:value-of select="$Name_ot"/></td>
  <td colspan='2' class='xl965035' style='border-right:.5pt solid black'>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='59' height='14' class='xl665035' style='height:10.5pt'></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035'>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='59' height='14' class='xl665035' style='height:10.5pt'></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035'>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>

</xsl:when>
<xsl:otherwise>

<xsl:variable name="LengTTS0"><xsl:text>29</xsl:text></xsl:variable>
<xsl:variable name="LengTTSO"><xsl:text>36</xsl:text></xsl:variable>

<xsl:variable name="LengNotN" select="string-length($Name_ot_name)"/>
<xsl:variable name="LengNotIK" select="string-length($Name_ot_INNKPP)"/>

<xsl:variable name="StrO1">
	<xsl:choose>
		<xsl:when test="$LengNotN &lt; $LengTTS0"><xsl:value-of select="$Name_ot_name"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring($Name_ot_name,1,$LengTTS0)"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="Name_ot_nameFO">
	<xsl:choose>
		<xsl:when test="$LengNotN &lt; $LengTTS0"></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring($Name_ot_name,$LengTTS0+1)"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="LengNotNFO" select="string-length($Name_ot_nameFO)"/>

<xsl:variable name="StrOO">
	<xsl:if test="$LengNotNFO &gt; 0">
		<xsl:variable name="CountLinr" select="floor($LengNotNFO div $LengTTSO)"/>
		<xsl:variable name="DeLen" select="$LengNotNFO - ($CountLinr * $LengTTSO)"/>
		<xsl:choose>
			<xsl:when test="($DeLen + 1 + $LengNotIK) &lt; $LengTTSO"><xsl:value-of select="$Name_ot_nameFO"/><xsl:text>&#32;</xsl:text><xsl:value-of select="$Name_ot_INNKPP"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$Name_ot_nameFO"/></xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:variable>

<xsl:variable name="StrOIK">
	<xsl:choose>
		<xsl:when test="$LengNotNFO &gt; 0">
			<xsl:variable name="CountLinr" select="floor($LengNotNFO div $LengTTSO)"/>
			<xsl:variable name="DeLen" select="$LengNotNFO - ( $CountLinr * $LengTTSO )"/>
			<xsl:choose>
				<xsl:when test="($DeLen + 1 + $LengNotIK) &lt; $LengTTSO"></xsl:when>
				<xsl:otherwise><xsl:value-of select="$Name_ot_INNKPP"/></xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$Name_ot_INNKPP"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable>


 <tr style='mso-height-source:userset;'>
  <td colspan='59' class='xl665035' ></td>
  <td colspan='10' class='xl995035'>Кому</td>
  <td colspan='59' class='xl925035' style="font-family:'Courier New', monospace;font-size:8.0pt;text-align:left;"><xsl:text>&#160;</xsl:text><xsl:value-of select="$StrO1"/></td>
  <td colspan='2' class='xl965035' style='border-right:.5pt solid black'>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 <!--
 <tr style='mso-height-source:userset;'>
  <td colspan='59' class='xl665035' ></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;text-align:left;"><xsl:value-of select="$StrO2"/>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 <tr style='mso-height-source:userset;'>
  <td colspan='59' class='xl665035' ></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;text-align:left;"><xsl:value-of select="substring($Name_ot,$LengTTS0 + 1 + $LengTTSO, $LengTTSO)"/>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 -->
				<xsl:call-template name="SpliteStrPer">
					<xsl:with-param name="str" select="$StrOO" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$LengTTSO"/>
				</xsl:call-template>		
						
				<xsl:call-template name="SpliteStrPer">
					<xsl:with-param name="str" select="$StrOIK" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$LengTTSO"/>
				</xsl:call-template>				

<xsl:if test="($LengNotNFO &lt; 1 and string-length($StrOIK)  &gt; 0) or (string-length($StrOO)  &lt;= $LengTTSO and string-length($StrOIK)  &lt; 1 )">
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='59' height='14' class='xl665035' style='height:10.5pt'></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035'>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>
</xsl:if>
 <!--<tr >
  <td colspan='59' class='xl665035'></td>
   <td class='xl645035' style="border-top:.5pt solid windowtext;">&#160;</td>
 <td colspan='68' class='xl995035' style='word-wrap: break-word;vertical-align:middle;border-bottom:.5pt solid windowtext;border-left:none;text-align:justify'>Кому &#160; <font class="font925035" style="font-family:'Courier New', monospace;font-size:10.0pt;border-bottom:.5pt solid windowtext;">&#160;<xsl:value-of select="$Name_ot"/></font></td>
  <td colspan='2' class='xl965035' style='border-right:.5pt solid black'>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr>-->
 <!--
 <xsl:if test="string-length($Name_ot) &lt; 80">
 
  <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='59' height='14' class='xl665035' style='height:10.5pt'></td>
  <td class='xl645035'>&#160;</td>
  <td colspan='68' class='xl715035'>&#160;</td>
  <td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
  <td colspan='3' class='xl665035'></td>
 </tr>

</xsl:if>
-->
</xsl:otherwise> 
</xsl:choose>
 
 <tr height='36' style='mso-height-source:userset;height:27.0pt'>
  <td colspan='59' height='36' class='xl665035' style='height:27.0pt'></td>
  <td class='xl655035'>&#160;</td>
  <td colspan='68' class='xl765035' width='272' style='width:204pt'>(Наименование
  организации, ИНН/ Ф.И.О индивидуального предпринимателя (физического лица),
  ИНН (при наличии))</td>
  <td colspan='2' class='xl745035' style='border-right:.5pt solid black'>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 
   <xsl:variable name="IDF" select="@ИдФайл"/>
  <xsl:variable name="KodIFNS" select="substring-after(substring-after(substring-after(substring-after($IDF,'_'),'_'),'_'),'_')"/>

 <tr style='mso-height-source:userset;'>
  <td colspan='59' class='xl665035' ></td>
  <td colspan='33' class='xl1015035' width='132' style='border-right:.5pt solid black;
  width:99pt'>От</td>
  <td colspan='18' class='xl1025035' width='72' style='border-left:none;width:54pt'>Код
  ИФНС</td>

  <td colspan='5' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($KodIFNS,1,1)"/></td>
  <td colspan='5' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($KodIFNS,2,1)"/></td>
  <td colspan='5' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($KodIFNS,3,1)"/></td>
  <td colspan='5' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($KodIFNS,4,1)"/></td>

  <td colspan='3' class='xl665035'></td>
 </tr>
 <tr height='4' style='mso-height-source:userset;height:3.0pt'>
  <td colspan='133' height='4' class='xl665035' style='height:3.0pt'></td>
 </tr>
 <tr height='6' style='mso-height-source:userset;height:4.5pt'>
  <td colspan='133' height='6' class='xl665035' style='height:4.5pt'></td>
 </tr>
 <tr height='20' style='mso-height-source:userset;height:15.0pt'>
  <td colspan='133' height='20' class='xl665035' style='height:15.0pt'></td>
 </tr>
 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td colspan='9' height='13' class='xl665035' style='height:9.75pt'></td>
  <td colspan='7' class='xl945035'>дата</td>
  <td colspan='20' class='xl665035345345' style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;"><xsl:value-of select="Документ/ПисьмоОтв/@ДатаПисьмо"/></td>
  <td class='xl635035'></td>
  <td colspan='9' class='xl685035'>исх. №</td>
  <td class='xl635035'></td>
  <td colspan='56' class='xl69503534534' style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;">&#160;<xsl:value-of select="Документ/ПисьмоОтв/@НомПисьмо"/></td>
  <td colspan='30' class='xl665035'></td>
 </tr>
 <tr height='11' style='mso-height-source:userset;height:8.25pt'>
  <td colspan='133' height='11' class='xl665035' style='height:8.25pt'></td>
 </tr>
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='9' height='14' class='xl665035' style='height:10.5pt'></td>
  <td colspan='8' class='xl945035'>на №</td>
  <td colspan='56' class='xl69503534534'  style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;">&#160;<xsl:value-of select="@НомОбращ"/></td>
  <td colspan='10' class='xl685035'>дата</td>
  <td colspan='20' class='xl665035345345'  style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;"><xsl:value-of select="@ДатаОбращ"/></td>
  <td colspan='30' class='xl665035'></td>
 </tr>
 <tr style='mso-height-source:userset;'>
  <td colspan='9' class='xl665035' ></td>
  <xsl:choose>
		<xsl:when test="string-length(@ИдФайлОбращ) &lt; 1">
		  <td colspan='76' class='xl69503534534' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:justify;border-bottom:.5pt solid windowtext;"><font style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;text-align:justify;">
		<xsl:text>&#160;</xsl:text>
		  </font></td>
		</xsl:when>
		<xsl:otherwise>
  <td colspan='76' class='xl69503534534' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:justify;border:none;">
			<table border='0' cellpadding='0' cellspacing='0' width='100%' style='border-collapse:collapse;table-layout:fixed;width:100%'>
				<xsl:call-template name="SpliteStrPer3">
				  <xsl:with-param name="str" select="@ИдФайлОбращ" />
				  <xsl:with-param name="start" select="0" />
				  <xsl:with-param name="len" select="40"/>
				</xsl:call-template>
			</table>
</td>
		</xsl:otherwise>
	</xsl:choose>
  <td colspan='48' class='xl685035'>(заполняется при ответе на обращение)</td>
 </tr>
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='9' height='14' class='xl665035' style='height:10.5pt'></td>
  <td colspan='73' class='xl705035'>(наименование файла обращения)</td>
  <td colspan='51' class='xl665035'></td>
 </tr>
 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
  <td colspan='133' height='14' class='xl665035' style='height:10.5pt'></td>
 </tr>
 <tr height='16' style='mso-height-source:userset;height:12.0pt'>
  <td colspan='10' height='16' class='xl665035' style='height:12.0pt'></td>
  <td colspan='47' class='xl675035'>Реквизиты налогоплательщика:</td>
  <td colspan='76' class='xl665035'></td>
 </tr>
 <tr height='28' style='mso-height-source:userset;height:21.0pt'>
  <td height='28' class='xl635035' style='height:21.0pt'></td>
  <td colspan='129' class='xl915035' width='516' style='border-top:none;width:387pt'>1. Наименование
  организации-налогоплательщика, индивидуального предпринимателя, физического
  лица:</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 
	<xsl:variable name="Otpr_Name_org" select="Документ/СвНП/НПЮЛ/@НаимОрг"/>
	<xsl:variable name="Otpr_fiz_Fam" select="Документ/СвНП/НПФЛ/ФИО/@Фамилия"/>
	<xsl:variable name="Otpr_fiz_Name" select="Документ/СвНП/НПФЛ/ФИО/@Имя"/>
	<xsl:variable name="Otpr_fiz_Otch" select="Документ/СвНП/НПФЛ/ФИО/@Отчество"/>
	<xsl:variable name="Otpr_fiz">
		<xsl:value-of select="$Otpr_fiz_Fam"/>
		<xsl:text>&#32;&#160;&#32;</xsl:text>
		<xsl:value-of select="$Otpr_fiz_Name"/>
		<xsl:if test="string-length($Otpr_fiz_Otch) &gt; 0">
			<xsl:text>&#32;&#160;&#32;</xsl:text>
			<xsl:value-of select="$Otpr_fiz_Otch"/>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="Name_otpr">
		<xsl:value-of select="$Otpr_Name_org"/>
		<xsl:value-of select="$Otpr_fiz"/>
	</xsl:variable>

<xsl:choose>
	<xsl:when test=" string-length($Name_otpr) &lt; 71">
 
 <tr height='16' style='mso-height-source:userset;height:12.0pt'>
  <td colspan='2' height='16' class='xl665035' style='height:12.0pt'></td>
  <td colspan='123' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;">&#160;<xsl:value-of select="$Name_otpr"/></td>
  <td colspan='8' class='xl665035'></td>
 </tr>
 <tr height='16' style='mso-height-source:userset;height:12.0pt'>
  <td colspan='2' height='16' class='xl665035' style='height:12.0pt'></td>
  <td colspan='123' class='xl925035'>&#160;</td>
  <td colspan='8' class='xl665035'></td>
 </tr>
  
	</xsl:when>
	<xsl:otherwise>
 
 <!--
 <tr >
  <td colspan='2' class='xl665035' ></td>
  <td colspan='129' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;text-align:justify"><font style="border-bottom:.5pt solid windowtext;font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="$Name_otpr"/>&#160;</font>&#160;</td>
  <td colspan='2' class='xl665035'></td>
 </tr>-->

				<xsl:call-template name="SpliteStrPer1">
					<xsl:with-param name="str" select="$Name_otpr" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="70"/>
				</xsl:call-template>				


	</xsl:otherwise>
</xsl:choose>

 <tr height='23' style='mso-height-source:userset;height:17.25pt'>
  <td colspan='133' height='23' class='xl665035' style='height:17.25pt'></td>
 </tr>
 <tr height='21' style='mso-height-source:userset;height:15.75pt'>
  <td colspan='2' height='21' class='xl665035' style='height:15.75pt'></td>
  <td colspan='100' rowspan="2" class='xl935035' ><font
  class="font65035456456" style="font-size:8.0pt;">Адрес местонахождения ЮЛ, место жительства ИП, физического лица:</font><br/><font class="font75035">(Индекс,
  код региона, район,город, населенный пункт, улица, дом, корпус, кв.)</font></td>
  <td class='xl635035'></td>
  
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,1,1)"/></td>
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,2,1)"/></td>
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,3,1)"/></td>
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,4,1)"/></td>
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,5,1)"/></td>
  <td colspan='4' class='xl1025035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/АдрРФ/@Индекс,6,1)"/></td>
  
 </tr>
 
  <tr height='8' style='mso-height-source:userset;height:6pt'>
  <td colspan='2' height='8' class='xl665035' style='height:6pt'></td>
  <td class='xl665035'></td>
  
  <td colspan='4' class='xl665035'></td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='4' class='xl665035'></td>
  
 </tr>
 
 
	<xsl:variable name="NP_kodreg" select="Документ/СвНП/АдрРФ/@КодРегион"/>
	<xsl:variable name="NP_rao" 		select="Документ/СвНП/АдрРФ/@Район"/>
	<xsl:variable name="NP_sity" 	select="Документ/СвНП/АдрРФ/@Город"/>
	<xsl:variable name="NP_Naspy" select="Документ/СвНП/АдрРФ/@НаселПункт"/>
	<xsl:variable name="NP_Strit" 	select="Документ/СвНП/АдрРФ/@Улица"/>
	<xsl:variable name="NP_home" 	select="Документ/СвНП/АдрРФ/@Дом"/>
	<xsl:variable name="NP_korp" 	select="Документ/СвНП/АдрРФ/@Корпус"/>
	<xsl:variable name="NP_kvar" 	select="Документ/СвНП/АдрРФ/@Кварт"/>
	<xsl:variable name="NP_Addr">
		<xsl:if test="string-length($NP_kodreg) > 0">
			<xsl:text>&#32;</xsl:text><xsl:value-of select="$NP_kodreg"/>
		</xsl:if>
		<xsl:if test="string-length($NP_rao) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_rao"/>
		</xsl:if>
		<xsl:if test="string-length($NP_sity) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_sity"/>
		</xsl:if>
		<xsl:if test="string-length($NP_Naspy) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_Naspy"/>
		</xsl:if>
		<xsl:if test="string-length($NP_Strit) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_Strit"/>
		</xsl:if>
		<xsl:if test="string-length($NP_home) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_home"/>
		</xsl:if>
		<xsl:if test="string-length($NP_korp) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_korp"/>
		</xsl:if>
		<xsl:if test="string-length($NP_kvar) > 0">
			<xsl:text>,&#32;</xsl:text><xsl:value-of select="$NP_kvar"/>
		</xsl:if>
	</xsl:variable>

<xsl:choose>
	<xsl:when test=" string-length($NP_Addr) &lt; 71">
 
 <tr height='16' style='mso-height-source:userset;height:12.0pt'>
  <td height='16' class='xl635035' style='height:12.0pt'></td>
  <td colspan='129' class='xl715035'  style="font-family:'Courier New', monospace;font-size:8.0pt;">&#160;<xsl:value-of select="$NP_Addr"/></td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 <tr height='16' style='mso-height-source:userset;height:12.0pt'>
  <td height='16' class='xl635035' style='height:12.0pt'></td>
  <td colspan='129' class='xl925035'>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 </xsl:when>
 <xsl:otherwise>


				<xsl:call-template name="SpliteStrPer1">
					<xsl:with-param name="str" select="$NP_Addr" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="70"/>
				</xsl:call-template>				

<!--
 <tr >
  <td class='xl635035' ></td>
  <td colspan='129' class='xl715035' style='border-bottom:.5pt solid windowtext;text-align:justify'><font style='border-bottom:.5pt solid windowtext;'><xsl:value-of select="$NP_Addr"/>&#160;</font>&#160;</td>
  <td colspan='3' class='xl665035'></td>
 </tr> -->
 
 </xsl:otherwise>
 </xsl:choose>
 
 <tr >
  <td colspan='2' class='xl665035' ></td>
  <td colspan='60' class='xl905035345345' >ИНН организации<br/>
  (ИП, физического лица):</td>
  <td colspan='14' class='xl665035'></td>
  <td colspan='49' class='xl905035345345' >КПП организации:<br/><font
  class="font65035">(заполняется в случае необходимости)</font></td>
  <td colspan='8' class='xl665035'></td>
 </tr>
 <tr style='mso-height-source:userset;'>
  <td colspan='2' class='xl665035' ></td>
          
         <xsl:variable name="INN"><xsl:value-of select="Документ/СвНП/НПЮЛ/@ИННЮЛ"/>
			<xsl:value-of select="Документ/СвНП/НПФЛ/@ИННФЛ"/></xsl:variable>
                    
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,1,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,2,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,3,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,4,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,5,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,6,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,7,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,8,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,9,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,10,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,11,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($INN,12,1)"/></td>

 
  <td colspan='14' class='xl665035'></td>
                       
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,1,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,2,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,3,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,4,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,5,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,6,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,7,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,8,1)"/></td>
   <td colspan='5' class='xl885035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring(Документ/СвНП/НПЮЛ/@КПП,9,1)"/></td>
  
  <td colspan='12' class='xl665035'></td>
 </tr>
 <tr height='20' style='height:15.0pt'>
  <td colspan='133' height='20' class='xl665035' style='height:15.0pt'></td>
 </tr>
<!--
 <tr height='23' style='mso-height-source:userset;height:17.25pt'>
  <td colspan='2' height='23' class='xl665035' style='height:17.25pt'></td>
  <td colspan='74' class='xl895035'>Код инспекции ФНС России, которая формирует
  письмо</td>
  <td colspan='4' class='xl665035'></td>
  
   <td colspan='5' class='xl885035'><xsl:value-of select="substring($KodIFNS,1,1)"/></td>
   <td colspan='5' class='xl885035'><xsl:value-of select="substring($KodIFNS,2,1)"/></td>
   <td colspan='5' class='xl885035'><xsl:value-of select="substring($KodIFNS,3,1)"/></td>
   <td colspan='5' class='xl885035'><xsl:value-of select="substring($KodIFNS,4,1)"/></td>
  
  <td colspan='29' class='xl665035'></td>
 </tr>
 <tr height='12' style='mso-height-source:userset;height:9.0pt'>
  <td colspan='133' height='12' class='xl665035' style='height:9.0pt'></td>
 </tr> -->
 
 <xsl:variable name="text_obr" select="Документ/ПисьмоОтв/ПисьмоТекст"/> 

<xsl:choose>
	<xsl:when test="string-length($text_obr) &lt; 71">

<tr height='24' style='mso-height-source:userset;height:18.0pt'>
  <td colspan='2' height='24' class='xl665035' style='height:18.0pt'></td>
  <td colspan='129' class='xl865035' style="font-family:'Courier New', monospace;font-size:8.0pt;">&#160;<xsl:value-of select="$text_obr"/></td>
  <td colspan='2' class='xl665035'></td>
</tr>

</xsl:when>
<xsl:otherwise>

				<xsl:call-template name="SpliteStrPer1">
					<xsl:with-param name="str" select="$text_obr" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="70"/>
				</xsl:call-template>				
<!--
<tr >
  <td colspan='2' class='xl665035' ></td>
  <td colspan='129' class='xl865035' style='border-bottom:.5pt solid windowtext;text-align:justify'><font style='border-bottom:.5pt solid windowtext;'><xsl:value-of select="$text_obr"/>&#160;</font>&#160;</td>
  <td colspan='2' class='xl665035'></td>
</tr>
-->

</xsl:otherwise>
</xsl:choose>
 
 <xsl:if test="string-length($text_obr) &lt; 100">
 <tr height='24' style='mso-height-source:userset;height:18.0pt'>
  <td colspan='2' height='24' class='xl665035' style='height:18.0pt'></td>
  <td colspan='129' class='xl875035'>&#160;</td>
  <td colspan='2' class='xl665035'></td>
 </tr>
</xsl:if>
<xsl:if test="string-length($text_obr) &lt; 200">
 <tr height='24' style='mso-height-source:userset;height:18.0pt'>
  <td colspan='2' height='24' class='xl665035' style='height:18.0pt'></td>
  <td colspan='129' class='xl875035'>&#160;</td>
  <td colspan='2' class='xl665035'></td>
 </tr>
</xsl:if>
 
 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td colspan='2' height='13' class='xl665035' style='height:9.75pt'></td>
  <td colspan='129' class='xl705035'>(текст письма)</td>
  <td colspan='2' class='xl665035'></td>
 </tr>
 <tr height='12' style='mso-height-source:userset;height:9.0pt'>
  <td colspan='2' height='12' class='xl665035' style='height:9.0pt'></td>
  <td colspan='129' class='xl865035'>&#160;</td>
  <td colspan='2' class='xl665035'></td>
 </tr>
 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td colspan='133' height='13' class='xl665035' style='height:9.75pt'></td>
 </tr>
 <tr height='18' style='mso-height-source:userset;height:13.5pt'>
  <td colspan='2' height='18' class='xl665035' style='height:13.5pt'></td>
  <td colspan='20' rowspan='2' class='xl845035'>Приложение:</td>
  <td colspan='3' class='xl665035'></td>
  <td colspan='29' rowspan='2' class='xl845035'>количество файлов</td>
  <td class='xl635035'></td>
 
 
<xsl:variable name="count_file">
	<xsl:if test="string-length(Документ/ПисьмоОтв/Прил/@КолФайл) &lt; 2"><xsl:text>0</xsl:text></xsl:if><xsl:value-of select="Документ/ПисьмоОтв/Прил/@КолФайл"/>
</xsl:variable>      
     
                            
   <td colspan='5' class='xl835035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($count_file,1,1)"/></td>
   <td colspan='5' class='xl835035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($count_file,2,1)"/></td>
  
  <td colspan='68' class='xl665035'></td>
 </tr>
 <tr height='12' style='mso-height-source:userset;height:9.0pt'>
  <td colspan='2' height='12' class='xl665035' style='height:9.0pt'></td>
  <td colspan='3' class='xl665035'></td>
  <td colspan='79' class='xl665035'></td>
 </tr>
 <tr height='19' style='mso-height-source:userset;height:14.25pt'>
  <td colspan='2' height='19' class='xl665035' style='height:14.25pt'></td>
  <td colspan='76' class='xl845035'>Наименование файлов приложений (при наличии)</td>
  <td colspan='55' class='xl665035'></td>
 </tr>
 <tr height='8' style='mso-height-source:userset;height:6.0pt'>
  <td colspan='133' height='8' class='xl665035' style='height:6.0pt'></td>
 </tr>
 
 <xsl:for-each select="Документ/ПисьмоОтв/Прил/НаимПрил">
 <xsl:variable name="Cur_pos" select="position()"/>
 <xsl:if test="(($Cur_pos - 1) mod 4) = 0">
 <tr >
  <td class='xl635035' ></td>
  <td colspan='32' class='xl825035' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:left;"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str" select="Документ/ПисьмоОтв/Прил/НаимПрил[$Cur_pos]" /><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="15"/></xsl:call-template></td>
  <td colspan='32' class='xl825035' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:left;"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str" select="Документ/ПисьмоОтв/Прил/НаимПрил[$Cur_pos+1]" /><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="15"/></xsl:call-template></td>
  <td colspan='32' class='xl825035' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:left;"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str" select="Документ/ПисьмоОтв/Прил/НаимПрил[$Cur_pos+2]" /><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="15"/></xsl:call-template></td>
  <td colspan='32' class='xl825035' style="font-family:'Courier New', monospace;font-size:8.0pt;word-wrap: break-word;text-align:left;"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str" select="Документ/ПисьмоОтв/Прил/НаимПрил[$Cur_pos+3]" /><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="15"/></xsl:call-template></td>
  <td colspan='4' class='xl665035'></td>
 </tr>
 </xsl:if>
 </xsl:for-each>
 
   <xsl:if test=" count(Документ/ПисьмоОтв/Прил/НаимПрил) = 0">

 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td height='13' class='xl635035' style='height:9.75pt'></td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='4' class='xl665035'></td>
 </tr>
</xsl:if>
 
   <xsl:if test=" count(Документ/ПисьмоОтв/Прил/НаимПрил) &lt; 5">

 <tr height='13' style='mso-height-source:userset;height:9.75pt'>
  <td height='13' class='xl635035' style='height:9.75pt'></td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='32' class='xl825035'>&#160;</td>
  <td colspan='4' class='xl665035'></td>
 </tr>
</xsl:if>
 
 <tr height='3' style='mso-height-source:userset;height:2.25pt'>
  <td colspan='133' height='3' class='xl665035' style='height:2.25pt'></td>
 </tr>
 <tr height='3' style='mso-height-source:userset;height:2.25pt'>
  <td colspan='133' height='3' class='xl665035' style='height:2.25pt'></td>
 </tr>
 <tr height='18' style='mso-height-source:userset;height:13.5pt'>
  <td height='18' class='xl635035' style='height:13.5pt'></td>
  <td colspan='59' class='xl845035'>Должностное лицо налогового органа</td>
  <td colspan='73' class='xl665035'></td>
 </tr>
 <tr >
  <td class='xl635035' ></td>
  <td colspan='51' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;text-align:justify"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str" select="Документ/Подписант/@Должн" /><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="26"/></xsl:call-template></td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='20' class='xl715035'>&#160;</td>
  <td colspan='3' class='xl815035'>/</td>
  <td colspan='51' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:text>&#160;</xsl:text><xsl:call-template name="SpliteStrPer2"><xsl:with-param name="str"><xsl:value-of select="Документ/Подписант/ФИО/@Фамилия"/><xsl:text>&#32;</xsl:text><xsl:value-of select="Документ/Подписант/ФИО/@Имя"/><xsl:text>&#32;</xsl:text><xsl:value-of select="Документ/Подписант/ФИО/@Отчество"/></xsl:with-param><xsl:with-param name="start" select="0" /><xsl:with-param name="len" select="26"/></xsl:call-template></td>
  <td colspan='3' class='xl815035'>/</td>
 </tr>
 <tr height='15' style='mso-height-source:userset;height:11.25pt'>
  <td height='15' class='xl635035' style='height:11.25pt'></td>
  <td colspan='51' class='xl705035'>(должность)</td>
  <td colspan='4' class='xl665035'></td>
  <td colspan='20' class='xl705035'>Подпись</td>
  <td colspan='3' class='xl815035'></td>
  <td colspan='51' class='xl705035'>Ф.И.О</td>
  <td colspan='3' class='xl665035'></td>
 </tr>
 
</table>

	</xsl:template>
	
	
		    <!-- block output function -->
  <xsl:template name="SpliteStrPer">
    <xsl:param name="str" />
    <xsl:param name="start" />
    <xsl:param name="len" />
    
    <xsl:if test="string-length($str) &gt; 0">
		<xsl:choose>
			<xsl:when test="$start &gt; 0">
			
				
				<xsl:call-template name="SpliteStrPer">
					<xsl:with-param name="str" select="substring($str,$start+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:otherwise>
			
			<tr style='mso-height-source:userset;'>
				<td colspan='59' class='xl665035' ></td>
				<td class='xl645035'>&#160;</td>
				<td colspan='68' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;text-align:left;"><xsl:value-of select="substring($str,1,$len)"/>&#160;</td>
				<td colspan='2' class='xl725035' style='border-right:.5pt solid black'></td>
				<td colspan='3' class='xl665035'></td>
			</tr>
			
				<xsl:call-template name="SpliteStrPer">
					<xsl:with-param name="str" select="substring($str,$len+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>				

			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    

   </xsl:template>
  <!-- block output function -->
	
		
		    <!-- block output function -->
  <xsl:template name="SpliteStrPer1">
    <xsl:param name="str" />
    <xsl:param name="start" />
    <xsl:param name="len" />
    
    <xsl:if test="string-length($str) &gt; 0">
		<xsl:choose>
			<xsl:when test="$start &gt; 0">
			
				
				<xsl:call-template name="SpliteStrPer1">
					<xsl:with-param name="str" select="substring($str,$start+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:otherwise>
			
<tr >
  <td colspan='2' class='xl665035' ></td>
  <td colspan='129' class='xl715035' style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;text-align:justify"><font style="border-bottom:.5pt solid windowtext;font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($str,1,$len)"/></font></td>
  <td colspan='2' class='xl665035'></td>
 </tr>

			
				<xsl:call-template name="SpliteStrPer1">
					<xsl:with-param name="str" select="substring($str,$len+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>				

			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    
    

   </xsl:template>
  <!-- block output function -->
  
  		
		    <!-- block output function -->
  <xsl:template name="SpliteStrPer2">
    <xsl:param name="str" />
    <xsl:param name="start" />
    <xsl:param name="len" />
    
    <xsl:if test="string-length($str) &gt; 0">
		<xsl:choose>
			<xsl:when test="$start &gt; 0">
			
				
				<xsl:call-template name="SpliteStrPer2">
					<xsl:with-param name="str" select="substring($str,$start+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:otherwise>
			
<xsl:value-of select="substring($str,1,$len)"/><xsl:if test="string-length($str) &gt; $len"><br/><xsl:text>&#160;</xsl:text></xsl:if> 

			
				<xsl:call-template name="SpliteStrPer2">
					<xsl:with-param name="str" select="substring($str,$len+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>				

			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    
    

   </xsl:template>
  <!-- block output function -->
	
	 		
		    <!-- block output function -->
  <xsl:template name="SpliteStrPer3">
    <xsl:param name="str" />
    <xsl:param name="start" />
    <xsl:param name="len" />
    
    <xsl:if test="string-length($str) &gt; 0">
		<xsl:choose>
			<xsl:when test="$start &gt; 0">
			
				
				<xsl:call-template name="SpliteStrPer3">
					<xsl:with-param name="str" select="substring($str,$start+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:otherwise>
			
<tr style="border:none;">
  <td class='xl69503534534' style="font-family:'Courier New', monospace;font-size:8.0pt;border-bottom:.5pt solid windowtext;text-align:justify"><font style="border-bottom:.5pt solid windowtext;font-family:'Courier New', monospace;font-size:8.0pt;"><xsl:value-of select="substring($str,1,$len)"/></font></td>
 </tr>

			
				<xsl:call-template name="SpliteStrPer3">
					<xsl:with-param name="str" select="substring($str,$len+1)" />
					<xsl:with-param name="start" select="0" />
					<xsl:with-param name="len" select="$len"/>
				</xsl:call-template>				

			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    
    

   </xsl:template>
  <!-- block output function -->
	
	
</xsl:stylesheet>