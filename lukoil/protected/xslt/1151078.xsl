<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="Qualifier.xsl"/>
  <xsl:include href="style.xslt"/>
  <xsl:output indent="yes" omit-xml-declaration="no" standalone="no" method="html" encoding="windows-1251"/>
  <xsl:decimal-format grouping-separator=" "/>


  <xsl:template match="/">

      <xsl:call-template name="InitStyles"/>

    <style>
      .table-with-border td
      {
        border: 1pt solid black;
        font-size: 8pt;
        vertical-align: top;
      }
    </style>



    <div class='view_container' style='width: 210mm'>
      <xsl:apply-templates select="Файл"/>
    </div>
  </xsl:template>

  <xsl:template match="Файл">
    <xsl:apply-templates select="Документ"/>
  </xsl:template>

  <xsl:template match="Документ">
    <!--2-НДФЛ - Справка о доходах физического лица за 2011 год-->
    <!--КНД 1151078-->
    <!--5.02-->

    <!--страницы-->
    <xsl:call-template name="Page1"/>
    <!--Сведения о доходах физического лица на страницах после 1ой странице-->
    <xsl:apply-templates select="СведДох[position() > 1]"/>

  </xsl:template>

  <xsl:template name="Page1">
    <xsl:if test="position() > 1">
      <div class="page-break">&#160;</div>
    </xsl:if>

   <table class="page page-margin-medium">
      <tr>
        <td class="page-content">
          <table>
            <tr>
              <td class="explanation">
              Приложение № 1 к приказу ФНС России от 17.11.2010 N ММВ-7-3/611@(в ред. Приказа ФНС РФ от 06.12.2011 N ММВ-7-3/909@)
              <div class="bold text-right">Форма 2-НДФЛ</div>
                <div class="text-right">
                  Код формы по КНД <xsl:value-of select="@КНД"/>
                </div>
              </td>
            </tr>
          </table>

          <xsl:call-template  name="doc">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>

          <table class="margin-top5mm">
            <tr class="explanation">
              <td class='bold'>
                1. Данные о налоговом агенте
              </td>
              <td class="text-right">в ИФНС (код)</td>
              <td class="nowrap border-bottom" width="1%">
                <xsl:value-of select="@КодНО"/>
              </td>
            </tr>
          </table>

          <!--Данные о налоговом агенте -->
          <xsl:apply-templates select="СвНА"/>
          <!--Данные о физическом лице - получателе дохода-->
          <xsl:apply-templates select="ПолучДох"/>
          <!--Сведения о доходах физического лица на 1ой странице-->
          <xsl:call-template name="outTable3-5">
            <xsl:with-param name="node" select="СведДох[position() = 1]"/>
          </xsl:call-template>

        </td>
      </tr>
    </table>
       
          <!--<xsl:apply-templates select="СведДох"/>-->
       
  </xsl:template>
  
  <xsl:template match="СведДох">
    
   <div class="page-break">&#160;</div>
    <table class="page page-margin-medium">
      <tr>
        <td class="page-content">
          <table style="text-align:right;">
            <tr>
              <td>
                Стр. <xsl:value-of select="position()+1"/>
              </td>
            </tr>
          </table>
          <!--Выводим заголовок: СПРАВКА О ДОХОДАХ ФИЗИЧЕСКОГО ЛИЦА на не первых страницах-->
          <xsl:call-template  name="doc">
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
          <!--Сведения о доходах физического лица на не первых страницах-->
          <xsl:call-template name="outTable3-5">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>
          
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="СвНА">
    <table style="width: auto">
      <tr class="explanation">
        <td>
          1.1. ИНН/КПП для организации или ИНН для физического лица
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="СвНАЮЛ/@ИННЮЛ"/>
          <xsl:value-of select="СвНАФЛ/@ИННФЛ"/>
        </td>
        <td>/</td>
        <td class="border-bottom bold" width="25%">
          <xsl:value-of select="СвНАЮЛ/@КПП"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td>
          1.2. Наименование организации / Фамилия, имя, отчество физического лица
        </td>
      </tr>
      <tr class="explanation">
        <td class="border-bottom bold">
          <xsl:value-of select="СвНАЮЛ/@НаимОрг"/>
          <xsl:apply-templates select="СвНАФЛ/ФИО"/>
        </td>
      </tr>
    </table>

    <table style="width: auto">
      <tr class="explanation">
        <td class="nowrap">
          1.3. Код ОКАТО
        </td>
        <td class="bold border-bottom" width="30%">
          <xsl:apply-templates select="@ОКАТО"/>
        </td>
        <td width="15%"></td>
        <td class="text-right nowrap">
          1.4. Телефон
        </td>
        <td class="bold border-bottom" width="30%">
          <xsl:apply-templates select="@Тлф"/>
        </td>
      </tr>
    </table>
    
  </xsl:template>

  <xsl:template match="ПолучДох">
    <table>
      <tr class="explanation">
        <td class="bold" colspan="4">
          2. Данные о физическом лице - получателе дохода
        </td>
      </tr>
      <tr class="explanation">
        <td width="5%" class="nowrap">
          2.1. ИНН
        </td>
        <td class="border-bottom bold" width="15%">
          <xsl:value-of select="@ИННФЛ"/>
        </td>
        <td class="text-right" width="25%">
          2.2. Фамилия, Имя, Отчество
        </td>
        <td class="border-bottom bold">
          <xsl:apply-templates select="ФИО"/>
        </td>
      </tr>
    </table>
   
    <table>
      <tr class="explanation">
        <td class="nowrap" width="20%">
          2.3. Статус налогоплательщика
        </td>
        <td class="bold border-bottom" width="3%">
          <xsl:value-of select="@Статус"/>
        </td>
        <td class="nowrap" width="10%">
          2.4. Дата рождения
        </td>
        <td class="bold border-bottom" width="20%">
          <xsl:value-of select="@ДатаРожд"/>
        </td>
        <td class="nowrap" width="20%">
          2.5. Гражданство (код страны)
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="@Гражд"/>
        </td>
      </tr>
    </table>
    
    <table>
      <tr class="explanation">
        <td class="nowrap" width="20%">
          2.6. Код документа, удостверяющего личность
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="УдЛичнФЛ/@КодУдЛичн"/>
        </td>
        <td class="nowrap" width="20%">
          2.7. Серия, номер документа
        </td>
        <td class="bold border-bottom">
          <xsl:value-of select="УдЛичнФЛ/@СерНомДок"/>
        </td>
      </tr>
    </table>
    
    <!--Адрес в РФ-->
    <table>
      <tr class="explanation">
        <td class="nowrap">
          2.8. Адрес места жительства в Российской Федерации:
        </td>
        <td class="nowrap" width="10%">
          почтовый индекс
        </td>
        <td class="bold border-bottom" width="15%">
          <xsl:value-of select="АдрМЖРФ/@Индекс"/>
        </td>
        <td class="nowrap" width="10%">
          код региона
        </td>
        <td class="bold border-bottom" width="5%">
          <xsl:value-of select="АдрМЖРФ/@КодРегион"/>
        </td>
        <td width="10%"></td>
      </tr>
    </table>
    
    <table>
      <tr class="explanation">
        <td class="nowrap padding-left5mm"  width="5%">
          &#160; район
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="АдрМЖРФ/@Район"/>
        </td>
        <td class="nowrap" width="5%">
          город
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="АдрМЖРФ/@Город"/>
        </td>
        <td class="nowrap" width="5%">
          населенный пункт
        </td>
        <td class="bold border-bottom" width="25%">
          <xsl:value-of select="АдрМЖРФ/@НаселПункт"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td class="nowrap padding-left5mm"  width="5%">
          &#160; улица
        </td>
        <td class="bold border-bottom" width="40%">
          <xsl:value-of select="АдрМЖРФ/@Улица"/>
        </td>
        <td class="nowrap" width="1%">
          дом
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="АдрМЖРФ/@Дом"/>
        </td>
        <td class="nowrap" width="5%">
          корпус
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="АдрМЖРФ/@Корпус"/>
        </td>
        <td class="nowrap" width="5%">
          квартира
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="АдрМЖРФ/@Кварт"/>
        </td>
      </tr>
    </table>

    <!--Адрес за пределами РФ-->
    <table>
      <tr class="explanation">
        <td class="nowrap"  width="5%">
          2.9. Адрес в стране проживания: Код страны
        </td>
        <td class="bold border-bottom" width="10%">
          <xsl:value-of select="АдрИноТип/@КодСтр"/>
        </td>
        <td class="nowrap" width="5%">
          Адрес
        </td>
        <td class="bold border-bottom">
          <xsl:value-of select="АдрМЖРФ/@АдрТекст"/>
        </td>
      </tr>
      <tr>
        <td colspan="4" class="border-bottom">
          &#160;
        </td>
      </tr>
    </table>
    
  </xsl:template>


  <xsl:template name="outTable3-5">
    <xsl:param name="node"/>

    <table>
      <tr class="explanation bold">
        <td width="15%" class="nowrap">
          3. Доходы, облагаемые по ставке
        </td>
        <td class="border-bottom bold text-center" width="3%">
          <xsl:value-of select="$node/@Ставка"/>
        </td>
        <td class="text-right" width="1%">
          %
        </td>
        <td></td>
      </tr>
    </table>
    <!--Происходит формирование таблиц по принципу: с четными номерами, с нечетными номерами-->
    <table>
      <tr>
        <td width="49%" class="vertical-align-top">
          <xsl:apply-templates select="$node/ДохВыч[СвСумДох[boolean(position() mod 2) and @Месяц > 0]]">
            <xsl:with-param name="node" select="$node/ДохВыч/СвСумДох[boolean(position() mod 2)]"/>
          </xsl:apply-templates>
        </td>
        <td></td>
        <td width="49%" class="vertical-align-top">
          <xsl:apply-templates select="$node/ДохВыч[СвСумДох[not(position() mod 2) and @Месяц > 0 ]]">
            <xsl:with-param name="node" select="$node/ДохВыч/СвСумДох[not(position() mod 2)]"/>
          </xsl:apply-templates>

          <!--Если только одна запись непустая и левая часть напечаталась, то в правой тоже рисуем шапку-->
          <xsl:if test="count($node/ДохВыч/СвСумДох[@Месяц > 0]) = 1">
            <table class="table-with-border">
              <xsl:call-template name="haedTable"/>
            </table>
          </xsl:if>
        </td>
      </tr>
    </table>

    <!--4. Стандартные, социальные и имущественные налоговые вычеты-->
    <xsl:apply-templates select="$node/НалВычССИ"/>

    <!--5. Общие суммы дохода и налога по итогам налогового периода-->
    <xsl:apply-templates select="$node/СГДНалПер"/>
    <!--Подписи-->
    <table class="margin-top5mm">
      <tr class="explanation">
        <td width="11%" class="nowrap">
          Налоговый агент
        </td>
        <td class="border-bottom text-center" width="20%">

        </td>
        <td width="1%"></td>
        <td class="border-bottom" width="20%">

        </td>
        <td width="1%"></td>
        <td class="border-bottom text-center" width="25%">

        </td>
      </tr>
      <tr>
        <td class="text-right">
          М.П. &#160;&#160;&#160;
        </td>
        <td class="podpis">(должность)</td>
        <td></td>
        <td class="podpis">(подпись)</td>
        <td></td>
        <td class="podpis">(Ф.И.О)</td>
      </tr>
    </table>

    <table>
      <tr>
        <td width="15%" class="border-bottom">&#160;</td>
      </tr>
      <tr>
        <td colspan="2" class="explanation">
          * Настоящий пункт заполняется в отношении сумм налога, исчисленных с доходов, полученных, начиная с 2011 года.
        </td>
      </tr>
    </table>
    
  </xsl:template>
  <!--заголовок: СПРАВКА О ДОХОДАХ ФИЗИЧЕСКОГО ЛИЦА-->
  <xsl:template name="doc">
    <xsl:param name="node"/>
    <table style="width: auto">
      <tr class="explanation">
        <td width="10%"></td>
        <td class="bold">
          СПРАВКА О ДОХОДАХ ФИЗИЧЕСКОГО ЛИЦА за
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@ОтчетГод"/>
        </td>
        <td class="bold">год</td>
        <td class="bold">№</td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@НомСпр"/>
        </td>
        <td class="bold">от</td>
        <td class="border-bottom bold">
          <xsl:value-of select="$node/@ДатаДок"/>
        </td>
        <td>признак</td>
        <td width="5%" class="border-bottom text-center">
          <xsl:value-of select="$node/@Признак"/>
        </td>
        <td width="10%"></td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="haedTable">
    <tr class="text-center">
      <td width="15%">Месяц</td>
      <td width="15%">
        Код<br/>дохода
      </td>
      <td>
        Сумма<br/>дохода
      </td>
      <td width="15%">
        Код<br/>вычета
      </td>
      <td>
        Сумма<br/>вычета
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="ДохВыч">
    <xsl:param name="node"/>
    <table class="table-with-border">
      <xsl:call-template name="haedTable"/>
      <xsl:apply-templates select="$node"/>
    </table>
  </xsl:template>
  
  <xsl:template match="СвСумДох">
    <tr class="bold">
      <td class="text-center">
        <xsl:value-of select="number(@Месяц)"/>
      </td>
      <td class="text-center">
        <xsl:value-of select="@КодДоход"/>
      </td>
      <td class="text-right">
        <xsl:call-template name="NumValue">
          <xsl:with-param name="input" select="@СумДоход"/>
        </xsl:call-template>
      </td>
      <xsl:apply-templates select="СвСумВыч[position()=1]"/>
       
      <xsl:if test="not(СвСумВыч)">
        <td></td>
        <td></td>
      </xsl:if>
    </tr>
    <xsl:apply-templates select="СвСумВыч[position()>1]" mode="other" />
      
  </xsl:template>

  <xsl:template match="СвСумВыч">
        <xsl:call-template name="outValue">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
  </xsl:template>
  <xsl:template match="СвСумВыч" mode="other">
      <tr class="bold">
          <td></td>
          <td></td>
          <td></td>
          <xsl:call-template name="outValue">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>
        </tr>
 </xsl:template>
  <xsl:template name="outValue">
    <xsl:param name="node"/>
    <td class="text-center">
      <xsl:value-of select="$node/@КодВычет"/>
    </td>
    <td class="text-right">
      <xsl:call-template name="NumValue">
        <xsl:with-param name="input" select="$node/@СумВычет"/>
      </xsl:call-template>
    </td>
  </xsl:template>
  
  <xsl:template match="НалВычССИ">
    <table>
      <tr class="explanation bold">
        <td>
          4. Стандартные, социальные и имущественные налоговые вычеты
        </td>
      </tr>
      <tr class="explanation">
        <td>
          4.1. Суммы предоставленных налогоплательщику налоговых вычетов
        </td>
      </tr>
    </table>

    <table>
      <tr>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="1"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="2"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="3"/>
          </xsl:call-template>
        </td>
        <td width="25%" class="vertical-align-top">
          <xsl:call-template name="outTable4">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="num" select="4"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td width="65%">
          4.2. № Уведомления, подтверждающего право на имущественный налоговый вычет
        </td>
        <td class="border-bottom bold">
          <xsl:value-of select="УведИмущВыч/@НомерУвед"/>
        </td>
      </tr>
    </table>

    <table>
      <tr class="explanation">
        <td width="10%" class="nowrap">
          4.3. Дата выдачи Уведомления
        </td>
        <td class="border-bottom bold" width="10%">
          <xsl:value-of select="УведИмущВыч/@ДатаУвед"/>
        </td>
        <td class="text-right">
          4.4. Код налогового органа, выдавшего Уведомление
        </td>
        <td class="border-bottom bold" width="20%">
          <xsl:value-of select="УведИмущВыч/@ИФНСУвед"/>
        </td>
      </tr>
    </table>

  </xsl:template>

  <xsl:template name="outTable4">
    <xsl:param name="node"/>
    <xsl:param name="num"/>
    <table class="table-with-border">
      <xsl:call-template name="headTable4"/>

      <!--выводим каждую 4-ую запись-->
      <xsl:apply-templates select="$node/ПредВычССИ[position() - $num =  4 * ( ceiling(position() div 4) - 1) ]"/>
      
    </table>
  </xsl:template>

  <xsl:template match="ПредВычССИ">
    <tr class="bold">
      <xsl:call-template name="outValue">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </tr>
  </xsl:template>
  
  <xsl:template name="headTable4">
    <tr class="text-center">
      <td width="40%">
        Код вычета
      </td>
      <td>
        Сумма вычета
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="СГДНалПер">

    <div class="explanation bold">5. Общие суммы дохода и налога по итогам налогового периода</div>
    <table class="table-with-border">
      <tr>
        <td width="80%">
          5.1. Общая сумма дохода
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@СумДохОбщ"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.2. Налоговая база
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалБаза"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.3. Сумма налога исчисленная
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалИсчисл"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.4. Сумма налога удержанная
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалУдерж"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.5. Сумма налога перечисленная*
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалПеречисл"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.6. Сумма налога, излишне удержанная налоговым агентом
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалУдержЛиш"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          5.7. Сумма налога, не удержанная налоговым агентом
        </td>
        <td class="bold text-right">
          <xsl:call-template name="NumValue">
            <xsl:with-param name="input" select="@НалНеУдерж"/>
            <xsl:with-param name="decimal"></xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
    </table>

  </xsl:template>

  
  <xsl:template match="ФИО">
    <xsl:value-of select="@Фамилия"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Имя"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="@Отчество"/>
  </xsl:template>

  <xsl:template name="Podpis">
    <tr>
      <td>
        <table class="margin-top5mm">
          <!--style="margin-top: 5mm;" -->
          <tr>
            <td>Руководитель</td>
            <td class="border-bottom" width="10%">&#160;</td>
            <td width="1%">&#160;</td>
            <td class="border-bottom" width="15%">
              <xsl:apply-templates select="Подписант[@ПрПодп=3]"/>
            </td>
            <td width="20%">
              &#160;
            </td>
            <td>Главный бухгалтер</td>
            <td class="border-bottom" width="10%">&#160;</td>
            <td width="1%">&#160;</td>
            <td class="border-bottom" width="15%">
              <xsl:apply-templates select="Подписант[@ПрПодп=4]"/>
            </td>
          </tr>
          <tr>
            <td></td>
            <td class="podpis">(подпись)</td>
            <td></td>
            <td class="podpis">(расшифровка подписи)</td>
            <td></td>
            <td></td>
            <td class="podpis">(подпись)</td>
            <td></td>
            <td class="podpis">(расшифровка подписи)</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <table style="width: auto;">
          <tr>
            <td>&quot;</td>
            <td class="border-bottom">
              <xsl:value-of select="number(substring(@ДатаДок,1,2))"/>
            </td>
            <td>&quot;</td>
            <td class="border-bottom">
              <xsl:call-template name="ДатаДок"/>
            </td>
            <td>&#160;</td>
            <td class="border-bottom">
              <xsl:value-of select="substring(@ДатаДок,7,4)"/>
            </td>
            <td>г.</td>
          </tr>
        </table>
      </td>
    </tr>
  </xsl:template>


  

  <!--Выводит на экран вместо 0 прочерк-->
  <xsl:template name="NumValue">
    <xsl:param name="input"/>
    <xsl:param name="decimal">2</xsl:param>
    <xsl:choose>
      <xsl:when test="number($input) and $decimal">
        <xsl:value-of select="format-number($input,'# ##0.00')"/>
      </xsl:when>
      <xsl:when test="number($input) and not($decimal)">
        <xsl:value-of select="format-number($input,'# ###.##')"/>
      </xsl:when>
      <xsl:otherwise>-</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  



  <!--Выводит дату отчета (месяц) прописью-->
  <xsl:template name="ДатаДок">
    <xsl:variable name="month" select="substring(@ДатаДок,4,2)"/>

    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>января</xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>февраля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>марта</xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>апреля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>мая</xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>июня</xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>июля</xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>августа</xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>сентября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>октября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>ноября</xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>декабря</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>