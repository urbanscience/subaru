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
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="provider">
			<xsl:variable name="varRoot" select="."></xsl:variable>
				<!-- REQUIRED -->
				<star:Sender>
					<star:CreatorNameCode>SubaruUrbanScience</star:CreatorNameCode>
					<star:SenderNameCode>
						<xsl:choose>
							<xsl:when test="name"><xsl:value-of select="name"></xsl:value-of></xsl:when>
							<xsl:otherwise>SubaruUrbanScience</xsl:otherwise>
						</xsl:choose>
					</star:SenderNameCode>
					<xsl:if test="service">
						<star:ServiceID>
							<xsl:value-of select="service"/>
						</star:ServiceID>
					</xsl:if>
				</star:Sender>
	</xsl:template>
</xsl:stylesheet>
