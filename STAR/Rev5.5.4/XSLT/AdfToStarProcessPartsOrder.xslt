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

  <xsl:import href="AdfToStarApplicationArea.xslt"></xsl:import>
	<xsl:import href="AdfToStarDocumentIdentificationGroup.xslt"></xsl:import>
	<xsl:import href="AdfToStarVehicle.xslt"></xsl:import>
	<xsl:import href="AdfToStarSpecifiedPerson.xslt"></xsl:import>

  <!-- PASSED in from XLST Transform -->
  <xsl:param name="paramDate"/>
 
	<xsl:namespace-alias stylesheet-prefix="star" result-prefix="#default"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<star:ProcessPartsOrder releaseID="5.5.4">
      
      <xsl:attribute name="xsi:schemaLocation">
			<xsl:value-of select="'http://www.starstandard.org/STAR/5 http://urbanscience.github.com/subaru/STAR/Rev5.5.4/BODs/Developer/ProcessPartsOrder.xsd'"/>
			</xsl:attribute>
      
			<xsl:variable name="varRoot" select="."/>
			<!-- ApplicationArea -->
			<xsl:apply-templates select="/adf">
        <xsl:with-param name="paramDate" select="$paramDate" />
      </xsl:apply-templates>
			<!-- ApplicationArea -->
			<star:ProcessPartsOrderDataArea>
        <star:Process acknowledgeCode="Always" />
				<star:PartsOrder>
					<star:PartsOrderHeader>
						<!-- Document Identity Group -->
						<xsl:apply-templates select="$varRoot/adf/prospect" />
						<!-- Document Identity Group -->
						<star:OrderTypeCode>N/A</star:OrderTypeCode>
						<xsl:if test="$varRoot/adf/prospect/customer/comments">
						<star:OrderComments>
								<xsl:value-of select="string($varRoot/adf/prospect/customer/comments)"/>
								<!--
								<xsl:for-each select="$varRoot/adf/prospect/vehicle/option">option|optionname=<xsl:value-of select="optionname"></xsl:value-of><xsl:if test="manufacturercode">|manufacturercode=<xsl:value-of select="manufacturercode"></xsl:value-of></xsl:if><xsl:if test="stock">|stock=<xsl:value-of select="stock"></xsl:value-of></xsl:if><xsl:if test="weighting">|weighting=<xsl:value-of select="weighting"></xsl:value-of></xsl:if><xsl:if test="price">|price=<xsl:value-of select="price"></xsl:value-of></xsl:if>|option
								</xsl:for-each>
								-->
						</star:OrderComments>
						</xsl:if>
					    <star:ShipToParty>
                <!--PurchaseHorizon-->
                <xsl:if test="$varRoot/adf/prospect/customer/timeframe/description">
                  <xsl:if test="string($varRoot/adf/prospect/customer/timeframe/description)!=''">
                    <star:SpecialRemarksDescription>
                      <xsl:value-of select="string($varRoot/adf/prospect/customer/timeframe/description)"/>
                    </star:SpecialRemarksDescription>
                  </xsl:if>
                </xsl:if>
								<!--PurchaseHorizon-->
								<!-- SpecifiedPerson -->
								<xsl:apply-templates select="$varRoot/adf/prospect/customer/contact"></xsl:apply-templates>
								<!-- SpecifiedPerson -->
					    </star:ShipToParty>

            <!--this will be inserted by ADF-->
              <star:PartsOrderReceivedDateTime></star:PartsOrderReceivedDateTime>
            
            <!--<xsl:if test="$varRoot/adf/prospect/requestdate and string($varRoot/adf/prospect/requestdate)!=''">
              <star:PartsOrderReceivedDateTime>
                <xsl:value-of select="$varRoot/adf/prospect/requestdate"/>
              </star:PartsOrderReceivedDateTime>
            </xsl:if>-->
            
              <!--<star:PartsOrderReceivedDateTime>
                <xsl:choose>
                  <xsl:when test="$varRoot/adf/prospect/requestdate and string($varRoot/adf/prospect/requestdate)!=''">
                    <xsl:value-of select="$varRoot/adf/prospect/requestdate"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$paramDate"/>
                  </xsl:otherwise>
                </xsl:choose>
              </star:PartsOrderReceivedDateTime>-->
              

            <!--DDC Lead Id-->
            <xsl:variable name="varTrackingCode" select="$varRoot/adf/prospect/provider/id[@source='Dealer.com']"></xsl:variable>
            <xsl:if test="$varTrackingCode!=''">
              <star:DatasourceURICode>
                <xsl:value-of select="$varTrackingCode"/>
              </star:DatasourceURICode>
            </xsl:if>
            
            <star:FreeFormTextGroup>
              <star:Description>
                <xsl:text>Year: </xsl:text>
                <xsl:value-of select="string($varRoot/adf/prospect/vehicle/year)"/>
              </star:Description>
              <star:Description>
                <xsl:text>Make: </xsl:text>
                <xsl:value-of select="string($varRoot/adf/prospect/vehicle/make)"/>
              </star:Description>
              <star:Description>
                <xsl:text>Model: </xsl:text>
                <xsl:value-of select="string($varRoot/adf/prospect/vehicle/model)"/>
              </star:Description>
              <star:Description>
                <xsl:text>VIN: </xsl:text>
                <xsl:value-of select="string($varRoot/adf/prospect/vehicle/vin)"/>
              </star:Description>
            </star:FreeFormTextGroup>
					</star:PartsOrderHeader>
				</star:PartsOrder>
			</star:ProcessPartsOrderDataArea>
		</star:ProcessPartsOrder>
	</xsl:template>
</xsl:stylesheet>
