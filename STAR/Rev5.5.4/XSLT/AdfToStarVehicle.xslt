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
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<xsl:template match="vehicle">
			<xsl:variable name="varRoot" select="."></xsl:variable>
								<xsl:if test="model/text()!=''">
									<star:Model>
										<xsl:value-of select="string(model)"/>
									</star:Model>
								</xsl:if>
								<xsl:if test="string(number(year))!='NaN'">
									<star:ModelYear>
										<xsl:value-of select="string(year)"/>
									</star:ModelYear>
								</xsl:if>
								<xsl:if test="make/text()!=''">
									<star:MakeString>
										<xsl:value-of select="string(make)"/>
									</star:MakeString>
								</xsl:if>
									<xsl:if test="@status">
										
											<xsl:choose>
												<xsl:when test="@status = 'used-certified'">
                          <star:SaleClassCode>
													<xsl:text>Used</xsl:text>
                          </star:SaleClassCode>
												</xsl:when>

                        <xsl:when test="@status = 'used'">
                          <star:SaleClassCode>
                            <xsl:text>Used</xsl:text>
                          </star:SaleClassCode>
                        </xsl:when>

                        <xsl:when test="@status = 'new'">
                          <star:SaleClassCode>
                            <xsl:text>New</xsl:text>
                          </star:SaleClassCode>
                        </xsl:when>
                        
												<!--<xsl:otherwise>
													<xsl:value-of select="concat(translate(substring(@status,1,1), $lowercase,$uppercase), substring(@status,2))"/>
												</xsl:otherwise>-->
                        </xsl:choose>
										
									</xsl:if>
									<xsl:if test="condition/text()!=''">
										<star:Condition>
											<xsl:value-of select="condition"/>
										</star:Condition>
									</xsl:if>
									<xsl:if test="comments/text()!=''">
										<star:VehicleNote>
											<xsl:value-of select="comments"/>
										</star:VehicleNote>
									</xsl:if>
									<xsl:if test="trim/text()!=''">
										<star:TrimCode>
											<xsl:value-of select="string(trim)"/>
										</star:TrimCode>
									</xsl:if>

                  <xsl:if test="string(number(doors))!='NaN'">
										<star:DoorsQuantityNumeric>
											<xsl:value-of select="string(doors)"/>
										</star:DoorsQuantityNumeric>
									</xsl:if>

                  <xsl:if test="string(doors)!='' and string(number(doors))='NaN'">
                    <xsl:variable name="doorsVar" select="string(doors)"></xsl:variable>
                    <xsl:choose>
                      <xsl:when test="contains($doorsVar, '2')">
                        <star:DoorsQuantityNumeric>2</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <xsl:when test="contains($doorsVar, 'Two')">
                        <star:DoorsQuantityNumeric>2</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <xsl:when test="contains($doorsVar, '4')">
                        <star:DoorsQuantityNumeric>4</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <xsl:when test="contains($doorsVar, 'Four')">
                        <star:DoorsQuantityNumeric>4</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <xsl:when test="contains($doorsVar, '5')">
                        <star:DoorsQuantityNumeric>5</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <xsl:when test="contains($doorsVar, 'Five')">
                        <star:DoorsQuantityNumeric>5</star:DoorsQuantityNumeric>
                      </xsl:when>
                      <!--<xsl:otherwise>
                        <star:DoorsQuantityNumeric></star:DoorsQuantityNumeric>
                      </xsl:otherwise>-->
                    </xsl:choose>
                  </xsl:if>

                  <xsl:if test="bodystyle/text()!=''">
										<star:BodyStyle>
											<xsl:value-of select="bodystyle"/>
										</star:BodyStyle>
									</xsl:if>
									<xsl:if test="transmission/text()!=''">
									<star:TransmissionGroup>
										<star:TransmissionTypeName>
											<xsl:value-of select="transmission"/>
										</star:TransmissionTypeName>
									</star:TransmissionGroup>
									</xsl:if>
									<xsl:for-each select="colorcombination">
										<xsl:if test="interiorcolor">
											<xsl:variable name="varInteriorColor" select="interiorcolor/text()" />
											<star:ColorGroup>
												<star:ColorItemCode>Interior</star:ColorItemCode>
												<xsl:if test="$varInteriorColor!=''">
												<star:ColorDescription>
												  <xsl:if test="preference">
													<xsl:if test="preference>0">(Priority: <xsl:value-of select="preference"/>) </xsl:if>
												  </xsl:if>
													<xsl:value-of select="$varInteriorColor"/>
												</star:ColorDescription>
												<star:ColorName>
													<xsl:value-of select="$varInteriorColor"/>
												</star:ColorName>
												</xsl:if>
											</star:ColorGroup>
										</xsl:if>
										<xsl:if test="exteriorcolor">
											<xsl:variable name="varExteriorColor" select="exteriorcolor/text()" />
											<star:ColorGroup>
												<star:ColorItemCode>Exterior</star:ColorItemCode>
												<xsl:if test="$varExteriorColor!=''">
												<star:ColorDescription>
													<xsl:if test="preference">
														<xsl:if test="preference>0">(Priority: <xsl:value-of select="preference"/>) </xsl:if>
													</xsl:if>
												<xsl:value-of select="$varExteriorColor"/>
												</star:ColorDescription>
												<star:ColorName>
													<xsl:value-of select="$varExteriorColor"/>
												</star:ColorName>
												</xsl:if>
											</star:ColorGroup>
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="vin/text()!=''">
										<star:VehicleID>
											<xsl:value-of select="vin"/>
										</star:VehicleID>
									</xsl:if>	
									<xsl:if test="make/text()!=''">
									  <star:ManufacturerName>
										<xsl:value-of select="string(make)"/>
									  </star:ManufacturerName>
									</xsl:if>
									<xsl:if test="stock/text()!=''">
									  <star:VehicleStockString>
										<xsl:value-of select="string(stock)"/>
									  </star:VehicleStockString>
									</xsl:if>
								</xsl:template>
</xsl:stylesheet>
