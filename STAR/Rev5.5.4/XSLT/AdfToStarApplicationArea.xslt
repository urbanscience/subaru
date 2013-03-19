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
	<xsl:import href="AdfToStarDestination.xslt"></xsl:import>
	<xsl:import href="AdfToStarSender.xslt"></xsl:import>
	<xsl:namespace-alias stylesheet-prefix="star" result-prefix="#default"/>

  <xsl:param name="paramDate"/>
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="adf">
			<xsl:variable name="varRoot" select="./prospect"></xsl:variable>
			<star:ApplicationArea>
				<!-- APPLY THE SENDER TEMPLATE-->
				<xsl:apply-templates select="$varRoot/provider"></xsl:apply-templates>
				<!-- REQUIRED - Will be inserted by WorkFlow-->
        <star:CreationDateTime></star:CreationDateTime>
        
        <!--<star:CreationDateTime>
					<xsl:choose>
						<xsl:when test="$varRoot/requestdate and string($varRoot/requestdate)!=''">
							<xsl:value-of select="$varRoot/requestdate"/>
						</xsl:when>
						<xsl:otherwise>
						  <xsl:value-of select="$paramDate"/>
						</xsl:otherwise>
					</xsl:choose>
				</star:CreationDateTime>-->
        
				<star:BODID>
					<xsl:value-of select="$varRoot/id/text()"/>
				</star:BODID>
        
				<!--
				<xsl:variable name="varBodid" select="$varRoot/id[@source='Urban Science']"></xsl:variable>			
				
				<xsl:if test="$varRoot/id[@source='Urban Science']">
					<star:BODID>
						<xsl:value-of select="$varBodid"/>
					</star:BODID>
				</xsl:if>
				-->
				<!-- APPLY THE DESTINATION TEMPLATE-->
				<xsl:apply-templates select="$varRoot/vendor"></xsl:apply-templates>
			</star:ApplicationArea>
	</xsl:template>
</xsl:stylesheet>
