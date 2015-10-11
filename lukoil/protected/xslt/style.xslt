<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="windows-1251"/>
  
  <!-- печатает стили в документ -->
  <xsl:template name="InitStyles">
    <style>
      .field_text
      {
      border-bottom: 1px solid black;
      text-align: center;
      vertical-align: bottom;
      font-weight: bold;
      }
      .explanation
      {
      font-size: 8pt;
      }
      .podpis
      {
      font-size: 7pt;
      text-align: center;
      vertical-align: top;
      }
      .bold
      {
      font-weight: bold;
      }
      .italic
      {
      font-style: italic;
      }
      .text-right
      {
      text-align: right;
      }
      .text-center
      {
      text-align: center;
      }
      .text-left
      {
      text-align: left;
      }
      .nowrap
      {
      white-space: nowrap;
      }
      .barcode_EAN8
      {
      font-family: sbisean-13;
      font-size: 40.0pt;
      }
      .view_container
      {
      font-family: tahoma,verdana,arial;
      font-size: 9.0pt;
      }
      .view_container *
      {
      filter: none;
      }
      @media SCREEN
      {
      .view_container
      {
      /*background-color: #fafadc;*/
      }
      }

      @media PRINT
      {
      .view_container
      {
      }
      .no_format
      {
      display: none;
      }
      }
      
      .view_container table
      {
      font-size: 9.0pt;
      border-collapse: collapse;
      width: 100%;
      }
      .view_container h1
      {
      font-size: 11pt;
      font-weight: bold;
      text-align: center;
      width: 100%;
      }
      .view_container h2
      {
      font-size: 9pt;
      font-weight: bold;
      text-align: center;
      color: black;
      width: 100%;
      }
      
      /* Книжная разметка страниц*/
      .view_container .page-margin-narrow
      {
      height: 281mm;
      width: 195mm;
      margin: 5mm 8mm 10mm 7mm;
      padding: 5mm 8mm 10mm 7mm;
      }
      .view_container .page-margin-medium
      {
      height: 276mm;
      width: 185mm;
      margin: 10mm 10mm 10mm 15mm;
      padding: 10mm 10mm 10mm 15mm;
      }
      .view_container .page-margin-standard
      {
      height: 256mm;
      width: 165mm;
      margin: 20mm 15mm 20mm 30mm;
      padding: 20mm 15mm 20mm 30mm;
      }
      
      /* Альбомная разметка страниц*/
      .view_container .page-landscape-margin-narrow
      {
      width: 272mm;
      height: 194mm;
      margin: 5mm 8mm 10mm 7mm;
      padding: 5mm 8mm 10mm 7mm;
      }
      .view_container .page-landscape-margin-medium
      {
      width: 267mm;
      height: 179mm;
      margin: 15mm 10mm 15mm 20mm;
      padding: 15mm 10mm 15mm 20mm;
      }
      .view_container .page-landscape-margin-standard
      {
      width: 257mm;
      height: 164mm;
      margin: 20mm 15mm 20mm 30mm;
      padding: 20mm 15mm 20mm 30mm;
      }
      .landscape
      {
      height: 209mm;
      width: 296mm;
      }
      
      .page-break
      {
      height: 0pt;
      page-break-before: always;
      border: 1pt solid white;      /* иначе margin-top следующей страницы не работают в режиме совместимости с IE8*/
      font-size: 0pt;               /* скрывает символ между тегами, необходимый для корректного предпросмотра в IE */
      }
      .field_filled
      {
      }
      .field_filled td
      {
      text-align: center;
      width: 4mm;
      height: 5mm;
      border-collapse: collapse;
      }
      .border-dotted
      {
      border: 1pt dotted black;
      }
      .border-solid
      {
      border: 1pt solid black;
      }
      .border-bold-solid
      {
      border: 2pt solid black;
      }
      .padding-top5mm
      {
      padding-top: 5mm;
      }
      .padding-top10mm
      {
      padding-top: 10mm;
      }
      .margin-top5mm
      {
      margin-top: 5mm;
      }
      .margin-top10mm
      {
      margin-top: 10mm;
      }      
      .page-content
      {
      vertical-align: top;
      }
      .footer
      {
      vertical-align: bottom;
      }
      .border-all
      {
      border: solid 1px black;
      }
      .border-left
      {
      border-left: solid 1px black;
      }
      .border-right
      {
      border-right: solid 1px black;
      }
      .border-top
      {
      border-top: solid 1px black;
      }
      .border-bottom
      {
      border-bottom:1px solid black;
      }
      .bold-border-all
      {
      border: solid 2px black;
      }
      .bold-border-left
      {
      border-left: solid 2px black;
      }
      .bold-border-right
      {
      border-right: solid 2px black;
      }
      .bold-border-top
      {
      border-top: solid 2px black;
      }
      .bold-border-bottom
      {
      border-bottom: solid 2px black;
      }
      .padding-left5mm
      {
      padding-left: 5mm;
      }
      .padding-left10mm
      {
      padding-left: 10mm;
      }
      .padding-left15mm
      {
      padding-left: 15mm;
      }
      .padding-left20mm
      {
      padding-left: 20mm;
      }
      .block-gray
      {
      background-color: #cccccc;
      border: solid 2px black;
      text-align: center;
      }
      .vertical-align-top
      {
      vertical-align: top;
      }
      .vertical-align-middle
      {
      vertical-align: middle;
      }
      .vertical-align-bottom
      {
      vertical-align: bottom;
      }


    </style>
  </xsl:template>
  
</xsl:stylesheet>