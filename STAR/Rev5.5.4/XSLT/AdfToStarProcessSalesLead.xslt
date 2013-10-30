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
	<xsl:import href="AdfToStarVehicle.xslt"></xsl:import>
	<xsl:import href="AdfToStarPrice.xslt"></xsl:import>
	<xsl:import href="AdfToStarImage.xslt"></xsl:import>
	<xsl:import href="AdfToStarFinance.xslt"></xsl:import>
	<xsl:import href="AdfToStarDocumentIdentificationGroup.xslt"></xsl:import>
	<xsl:import href="AdfToStarSpecifiedPerson.xslt"></xsl:import>

  <!-- PASSED in from XLST Transform -->
  <xsl:param name="paramDate"/>

  <xsl:namespace-alias stylesheet-prefix="star" result-prefix="#default"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:variable name="convertdigit" select="',$'" />
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<star:ProcessSalesLead releaseID="5.5.4">

      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="'http://www.starstandard.org/STAR/5 http://urbanscience.github.com/subaru/STAR/Rev5.5.4/BODs/Developer/ProcessSalesLead.xsd'"/>
      </xsl:attribute>
      
			<xsl:variable name="varRoot" select="."/>
			<!-- ApplicationArea -->
			<xsl:apply-templates select="/adf">
        <xsl:with-param name="paramDate" select="$paramDate" />
      </xsl:apply-templates>
			<!-- ApplicationArea -->
			<star:ProcessSalesLeadDataArea>
				<star:Process acknowledgeCode="Always" />
				<star:SalesLead>
					<star:SalesLeadHeader>
						<!-- Document Identity Group -->
            <xsl:apply-templates select="$varRoot/adf/prospect">
              <xsl:with-param name="paramDate" select="$paramDate"></xsl:with-param>
            </xsl:apply-templates>
						<!-- Document Identity Group -->
						<xsl:variable name="varVehicle" select="$varRoot/adf/prospect/vehicle"/>
						<xsl:if test="$varVehicle/@interest">
							<star:LeadInterestCode>
								<xsl:choose>
									<xsl:when test="string($varVehicle/@interest)='buy'">B</xsl:when>
									<xsl:when test="string($varVehicle/@interest)='lease' ">L</xsl:when>
									<xsl:when test="string($varVehicle/@interest)='sell' ">S</xsl:when>
									<xsl:when test="string($varVehicle/@interest)='trade-in' ">T</xsl:when>
									<xsl:when test="string($varVehicle/@interest)='test-drive' ">B</xsl:when>
									<xsl:otherwise>B</xsl:otherwise>
									</xsl:choose>
							</star:LeadInterestCode>
						</xsl:if>
						
						<xsl:variable name="varTrackingCode" select="$varRoot/adf/prospect/provider/id[@source='Dealer.com']"></xsl:variable>					
						<xsl:if test="$varTrackingCode!=''">
							<star:LeadSourceCode>
								<xsl:value-of select="$varTrackingCode"/>
							</star:LeadSourceCode>
						</xsl:if>
						
						
						<xsl:if test="$varRoot/adf/prospect/customer/comments/text()!=''">
							<star:CustomerComments>
								<xsl:value-of select="string($varRoot/adf/prospect/customer/comments)"/>
								<!--
								<xsl:for-each select="$varRoot/adf/prospect/vehicle/option">option|optionname=<xsl:value-of select="optionname"></xsl:value-of><xsl:if test="manufacturercode">|manufacturercode=<xsl:value-of select="manufacturercode"></xsl:value-of></xsl:if><xsl:if test="stock">|stock=<xsl:value-of select="stock"></xsl:value-of></xsl:if><xsl:if test="weighting">|weighting=<xsl:value-of select="weighting"></xsl:value-of></xsl:if><xsl:if test="price">|price=<xsl:value-of select="price"></xsl:value-of></xsl:if>|option
								</xsl:for-each>
								-->
							</star:CustomerComments>
						</xsl:if>
						<!--<star:LeadComments>
							--><!--Workflow will insert value here--><!--
						</star:LeadComments>-->
							
						<!--<xsl:if test="$varRoot/adf/prospect/customer/timeframe/description">
							<star:LeadComments>
								<xsl:value-of select="string($varRoot/adf/prospect/customer/timeframe/description)"/>
							</star:LeadComments>
						</xsl:if>-->
						<xsl:variable name="varCustomer" select="$varRoot/adf/prospect/customer"></xsl:variable>
						<star:CustomerProspect>
							<star:ProspectParty>
                <xsl:if test="$varCustomer/contact/name/@type">
                  <star:RelationshipTypeCode>
                    <xsl:value-of select="$varCustomer/contact/name/@type"></xsl:value-of>
                  </star:RelationshipTypeCode>
                </xsl:if>
								<xsl:if test="$varRoot/adf/prospect/customer/timeframe/description">
                  <xsl:if test="string($varRoot/adf/prospect/customer/timeframe/description)!=''">
                    <star:SpecialRemarksDescription>
                      <xsl:value-of select="string($varRoot/adf/prospect/customer/timeframe/description)"/>
                    </star:SpecialRemarksDescription>
                  </xsl:if>									
								</xsl:if>
								<xsl:if test="$varCustomer/id!= ''">
									<star:PartyID>
										<xsl:value-of select="$varCustomer/id"/>
									</star:PartyID>
								</xsl:if>
								<!-- SpecifiedPerson -->
								<xsl:apply-templates select="$varCustomer/contact"></xsl:apply-templates>
								<!-- SpecifiedPerson -->
							</star:ProspectParty>
							<xsl:if test="$varRoot/adf/prospect/vehicle[@interest = 'trade-in']">
								<xsl:variable name="varTradeInVehicle" select="$varRoot/adf/prospect/vehicle[@interest='trade-in']" />
									<star:CurrentlyOwnedItem>
										<star:OwnedVehicleDetail>
											<star:SalesLeadOwnedVehicle>
											  <star:Vehicle>
												<!-- Vehicle -->
												<xsl:apply-templates select="$varTradeInVehicle"></xsl:apply-templates>
												<!-- Vehicle -->
											  </star:Vehicle>
											</star:SalesLeadOwnedVehicle>
											<!-- odometer -->
											<xsl:variable name="odometer" select="$varRoot/adf/prospect/vehicle[@interest='trade-in']/odometer" />
                      <xsl:if test="string(number(translate($odometer,',','')))!='NaN'">
											
												<star:CurrentDistanceMeasure>
													<xsl:if test="$odometer/@units">
														<xsl:attribute name="unitCode">
															<xsl:choose>
																<xsl:when test="contains($odometer/@units,'mi')">mile</xsl:when>
																<xsl:when test="contains($odometer/@units,'km')">kilometer</xsl:when>
															</xsl:choose>
														</xsl:attribute>
													</xsl:if>
													<!--<xsl:value-of select="number($odometer)"/>-->
                          <xsl:value-of select="number(translate($odometer,',',''))"/>
												</star:CurrentDistanceMeasure>
											</xsl:if>
											<!-- odometer -->
										</star:OwnedVehicleDetail>
									</star:CurrentlyOwnedItem>
							</xsl:if>
						</star:CustomerProspect>
						
            <!-- Workflow will insert this -->
              <star:LeadCreationDateTime></star:LeadCreationDateTime>

            <!-- The Request Date of the ADF Lead --><!--
            <xsl:if test="string($varRoot/adf/prospect/requestdate)!=''">
              <star:LeadCreationDateTime>
                <xsl:value-of select="string($varRoot/adf/prospect/requestdate)"/>
              </star:LeadCreationDateTime>
            </xsl:if>-->
					</star:SalesLeadHeader>
					<star:SalesLeadDetail>
						<!-- Finance -->
						<xsl:apply-templates select="$varRoot/adf/prospect/vehicle/finance"></xsl:apply-templates>
						<!-- Finance -->
						<star:SalesLeadLineItem>
						<xsl:for-each select="$varRoot/adf/prospect/vehicle">
							<xsl:if test="@interest!='trade-in'">
							<star:SalesLeadVehicleLineItem>
								<!-- Price -->
								<xsl:apply-templates select="price"></xsl:apply-templates>
								<!-- Price -->
								<!-- Image -->
								<xsl:apply-templates select="imagetag"></xsl:apply-templates>
								<!-- Image -->
								<star:SalesLeadVehicle>
									<!-- Vehicle -->
									<xsl:apply-templates select="."></xsl:apply-templates>
									<!-- Vehicle -->
								</star:SalesLeadVehicle>
								
								<xsl:variable name="odometer" select="$varRoot/adf/prospect/vehicle/odometer"/>
								<xsl:variable name="odometerConverted" select="translate(odometer, $convertdigit,'')"/>
								<xsl:if test="string(number($odometerConverted))!='NaN'">
									<star:CurrentDistanceMeasure>
										<xsl:if test="$odometer/@units">
											<xsl:attribute name="unitCode">
												<xsl:choose>
													<xsl:when test="contains($odometer/@units,'mi')">mile</xsl:when>
													<xsl:when test="contains($odometer/@units,'km')">kilometer</xsl:when>
												</xsl:choose>
											</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="number($odometerConverted)"/>
									</star:CurrentDistanceMeasure>
								</xsl:if>
								<!-- Stock -->
								<xsl:if test="stock">
								  <star:SalesStockNumberString>
									<xsl:value-of select="$varRoot/adf/prospect/vehicle/stock"/>
								  </star:SalesStockNumberString>
								</xsl:if>
								<!-- /Stock -->
								<!-- Options -->
                  
                  <xsl:for-each select="$varRoot/adf/prospect/vehicle/option">
                    <!--<xsl:variable name="varRoot" select="."/>-->
                    <xsl:variable name="optionVar" select="."/>
										<star:Option>
											<xsl:if test="optionname">
												<star:OptionName>
													<xsl:value-of select="optionname"></xsl:value-of>
												</star:OptionName>
											</xsl:if>
											<xsl:if test="manufacturercode">
												<star:ManufacturerName>
													<xsl:value-of select="manufacturercode"></xsl:value-of>
												</star:ManufacturerName>
											</xsl:if>
											<xsl:if test="stock">
												<star:OptionStockNumberString>
													<xsl:value-of select="stock"></xsl:value-of>
												</star:OptionStockNumberString>
											</xsl:if>
											
								
											<xsl:if test="weighting">
												<star:OptionNotes>
                          <xsl:text>weighting:</xsl:text>
													<xsl:value-of select="weighting"></xsl:value-of>
												</star:OptionNotes>
											</xsl:if>

                      
											<xsl:if test="price">
                        <xsl:variable name="priceVar" select="$optionVar/price"/>
												<star:OptionPricing>
												
													<!--<xsl:if test="price[@type]">-->
														<star:PriceSourceCode>
															<xsl:value-of select="$priceVar/@type"></xsl:value-of>
														</star:PriceSourceCode>
													<!--</xsl:if>-->
													
													<star:Price>
														<star:ChargeAmount currencyID="USD">
                            
															<xsl:if test="price">
																<xsl:value-of select="price"></xsl:value-of>
                              </xsl:if>
														</star:ChargeAmount>
													</star:Price>
												</star:OptionPricing>
											</xsl:if>
						
									  </star:Option>
								</xsl:for-each>
								
								<!-- /Options -->
							</star:SalesLeadVehicleLineItem>
							</xsl:if>
						</xsl:for-each>	
						</star:SalesLeadLineItem>
					</star:SalesLeadDetail>
				</star:SalesLead>
			</star:ProcessSalesLeadDataArea>
		</star:ProcessSalesLead>
	</xsl:template>
</xsl:stylesheet>
