<?xml version="1.0" encoding="UTF-8"?>
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
	<xsl:namespace-alias stylesheet-prefix="star" result-prefix="#default"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:variable name="convertdigit" select="',$'" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="price">
			<star:PricingABIE>
				<xsl:if test="@type">
				<star:PriceSourceCode>
					<xsl:choose>
						<xsl:when test="@type='quote' ">Quote</xsl:when>
						<xsl:when test="@type='msrp' ">MSRP</xsl:when>
						<xsl:when test="@type='invoice' ">Invoice</xsl:when>
						<xsl:when test="@type='offer' ">Offer</xsl:when>
						<xsl:when test="@type='call' ">Call</xsl:when>
						<xsl:when test="@type='appraisal' ">Appraisal</xsl:when>
						<xsl:when test="@type='asking' ">Asking</xsl:when>
						<xsl:otherwise>Blue-Book</xsl:otherwise>
					</xsl:choose>
				</star:PriceSourceCode>
				</xsl:if>
				<xsl:if test="@delta='percentage'">
					<star:PricingDeltaPercent>
						<xsl:value-of select="text()"/>
					</star:PricingDeltaPercent>
			  </xsl:if>
				<star:Price>
					<xsl:if test="text()">
					
						<xsl:variable name="priceConverted" select="translate(text(), $convertdigit,'')"/>
							<xsl:choose>
							  <xsl:when test="string(number($priceConverted))!='NaN'">
								<star:ChargeAmount currencyID="USD">
								  <xsl:value-of select="$priceConverted"></xsl:value-of>
								</star:ChargeAmount>
							  </xsl:when>
							  <xsl:otherwise>
								<star:ChargeAmount currencyID="USD"><xsl:value-of select="text()"></xsl:value-of></star:ChargeAmount>
							  </xsl:otherwise>
							</xsl:choose>
					</xsl:if>
					<xsl:if test="pricecomments">
						<star:PriceDescription>
							<xsl:value-of select="string(pricecomments)"/>
						</star:PriceDescription>
					</xsl:if>
				</star:Price>
			</star:PricingABIE>
</xsl:template>
</xsl:stylesheet>
