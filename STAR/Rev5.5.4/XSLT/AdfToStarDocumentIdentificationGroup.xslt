<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:nmmacl="http://www.nmma.org/CodeLists" 
	xmlns:oagis="http://www.openapplications.org/oagis/9" 
	xmlns:clmIANAMIMEMediaTypes="http://www.openapplications.org/oagis/9/IANAMIMEMediaTypes:2003" 
	xmlns:oacl="http://www.openapplications.org/oagis/9/codelists" 
	xmlns:clm54217="http://www.openapplications.org/oagis/9/currencycode/54217:2001" 
	xmlns:clm5639="http://www.openapplications.org/oagis/9/languagecode/5639:1988" 
	xmlns:qdt="http://www.openapplications.org/oagis/9/qualifieddatatypes/1.1" 
	xmlns:clm66411="http://www.openapplications.org/oagis/9/unitcode/66411:2001" 
	xmlns:udt="http://www.openapplications.org/oagis/9/unqualifieddatatypes/1.1" 
	xmlns:star="http://www.starstandard.org/STAR/5" 
	xmlns:scl="http://www.starstandard.org/STAR/5/codelists" 
	xmlns:sqdt="http://www.starstandard.org/STAR/5/qualifieddatatypes/1.0" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xfUOMcl="http://www.xfront.com/UnitsOfMeasure" 
	exclude-result-prefixes="xs xsi xsl"
  xmlns="http://www.starstandard.org/STAR/5">

  <xsl:param name="paramDate" />
  <xsl:namespace-alias stylesheet-prefix="star" result-prefix="#default"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="prospect">
    <xsl:variable name="varTrackingCode" select="provider/id[@source='Dealer.com']"></xsl:variable>		

   <!-- 
	<star:DocumentDateTime>
  <xsl:value-of select="$paramDate"/> 
		</star:DocumentDateTime>-->
		<star:DocumentDateTime>2013-03-01T00:00:00-00:00</star:DocumentDateTime>
    <!--
	<xsl:if test="$varTrackingCode!=''">
      <SecondaryDealerNumberID>
        <xsl:value-of select="$varTrackingCode"/>
      </SecondaryDealerNumberID>
    </xsl:if>
	-->
<!--check wih DDC-->
		<star:DocumentIdentificationGroup>
			<star:DocumentIdentification>
				<xsl:choose>
					<xsl:when test="id/text() != '' ">
									<star:DocumentID>
										<xsl:value-of select="id/text()"/>
									</star:DocumentID>
					</xsl:when>
				</xsl:choose>
			</star:DocumentIdentification>
		</star:DocumentIdentificationGroup>
		<xsl:variable name="varTimeFrame" select="/customer/timeframe" ></xsl:variable>
		<xsl:if test="$varTimeFrame/earliestdate">
			<star:PurchaseEarliestDate>
				<xsl:value-of select="$varTimeFrame/earliestdate"/>
			</star:PurchaseEarliestDate>
		</xsl:if>
		<xsl:if test="$varTimeFrame/latestdate">
			<star:PurchaseLatestDate>
				<xsl:value-of select="$varTimeFrame/latestdate"/>
			</star:PurchaseLatestDate>
		</xsl:if>
</xsl:template>
</xsl:stylesheet>
