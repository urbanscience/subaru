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
	<xsl:template match="finance">
		<xsl:variable name="varFinanceMethod" select="./method"></xsl:variable>
    <xsl:variable name="varAmountType" select="./amount/@type"></xsl:variable>
    <xsl:variable name="varAmountValue" select="translate(./amount[@type],$convertdigit,'')"></xsl:variable>
    <star:Financing>
			<star:FinanceTypeString>
			<xsl:choose>
				<xsl:when test="$varFinanceMethod='cash' ">C</xsl:when>
				<xsl:when test="$varFinanceMethod='finance' ">F</xsl:when>
				<xsl:when test="$varFinanceMethod='lease' ">L</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
			</star:FinanceTypeString>
      
			<star:EstimatedFinancingAmounts>
				<xsl:if test="string($varAmountType)='monthly' ">
          <xsl:if test="string(number($varAmountValue))!='NaN' ">
            <star:BalanceAmount currencyID="USD">
              <xsl:value-of select="$varAmountValue"></xsl:value-of>
            </star:BalanceAmount>
          </xsl:if>
				</xsl:if>
				<xsl:if test="string($varAmountType)='downpayment' ">
          <xsl:if test="string(number($varAmountValue))!='NaN' ">
            <star:DownPaymentAmount currencyID="USD">
              <xsl:value-of select="$varAmountValue"></xsl:value-of>
            </star:DownPaymentAmount>
          </xsl:if>
				</xsl:if>
        <xsl:if test="string($varAmountType)='total'">
         <xsl:if test="string(number($varAmountValue))!='NaN' ">
              <star:ApprovedAmount currencyID="USD">
                <xsl:value-of select="$varAmountValue"></xsl:value-of>
              </star:ApprovedAmount>
            </xsl:if>
          </xsl:if>

			</star:EstimatedFinancingAmounts>
		</star:Financing>
</xsl:template>
</xsl:stylesheet>
