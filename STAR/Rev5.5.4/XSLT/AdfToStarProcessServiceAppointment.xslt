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
		<star:ProcessServiceAppointment releaseID="5.5.4">
      
      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="'http://www.starstandard.org/STAR/5 http://urbanscience.github.com/subaru/STAR/Rev5.5.4/BODs/Developer/ProcessServiceAppointment.xsd'"/>
			</xsl:attribute>
      
			<xsl:variable name="varRoot" select="."/>
			<!-- ApplicationArea -->
			<xsl:apply-templates select="/adf">
        <xsl:with-param name="paramDate" select="$paramDate" />
      </xsl:apply-templates>
			<!-- ApplicationArea -->
			<star:ProcessServiceAppointmentDataArea>
				<star:Process acknowledgeCode="Always"/>
				<star:ServiceAppointment>
          <star:ServiceAppointmentHeader>
            <!-- Document Identity Group -->
            <xsl:apply-templates select="$varRoot/adf/prospect" />
            <!-- Document Identity Group -->
            <star:AppointmentContactParty>
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
            </star:AppointmentContactParty>
            <star:ServiceAppointmentVehicleLineItem>
              <star:Vehicle>
                <!-- Vehicle -->
                <xsl:apply-templates select="$varRoot/adf/prospect/vehicle"></xsl:apply-templates>
                <!-- Vehicle -->
              </star:Vehicle>
              <!-- odometer -->
              <xsl:variable name="odometer" select="$varRoot/adf/prospect/vehicle/odometer" />
              <xsl:if test="string(number(translate($odometer,',','')))!='NaN'">
                <star:DeliveryDistanceMeasure>
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
                </star:DeliveryDistanceMeasure>
              </xsl:if>
              <!-- odometer -->
              <!--
					<xsl:if test="odometer">
						<star:DeliveryDistanceMeasure>
								<xsl:value-of select="number(odometer)"/>
						</star:DeliveryDistanceMeasure>
					</xsl:if>
		    -->
            </star:ServiceAppointmentVehicleLineItem>
          </star:ServiceAppointmentHeader>
					<star:ServiceAppointmentDetail>
						<xsl:if test="$varRoot/adf/prospect/customer/comments">
						<star:Appointment>
              <!--Workflow will insert date here. This is taken out currently because LMS assumes this is the date time when customer requested service appointment. Currently we recieve this info in Comments in ADF, and there is no way to parse it out. So we are not going to populate this field until we change our lead acceptance to STAR from ADF-->
              <!--<star:AppointmentDateTime>
              </star:AppointmentDateTime>-->

            
              <xsl:if test="string($varRoot/adf/prospect/customer/comments)!=''">
                <star:AppointmentNotes>
                  <xsl:value-of select="string($varRoot/adf/prospect/customer/comments)"/>
                  <!--
                <xsl:for-each select="$varRoot/adf/prospect/vehicle/option">option|optionname=<xsl:value-of select="optionname"></xsl:value-of><xsl:if test="manufacturercode">|manufacturercode=<xsl:value-of select="manufacturercode"></xsl:value-of></xsl:if><xsl:if test="stock">|stock=<xsl:value-of select="stock"></xsl:value-of></xsl:if><xsl:if test="weighting">|weighting=<xsl:value-of select="weighting"></xsl:value-of></xsl:if><xsl:if test="price">|price=<xsl:value-of select="price"></xsl:value-of></xsl:if>|option
								</xsl:for-each>
                -->
                </star:AppointmentNotes>
              </xsl:if>

              <!--DDC Lead Id-->
              <xsl:variable name="varTrackingCode" select="$varRoot/adf/prospect/provider/id[@source='Dealer.com']"></xsl:variable>
              <xsl:if test="$varTrackingCode!=''">
                <star:LeadSourceCode>
                  <xsl:value-of select="$varTrackingCode"/>
                </star:LeadSourceCode>
              </xsl:if>

						</star:Appointment>
						</xsl:if>
					</star:ServiceAppointmentDetail>
				</star:ServiceAppointment>
			</star:ProcessServiceAppointmentDataArea>
		</star:ProcessServiceAppointment>
	</xsl:template>
</xsl:stylesheet>
