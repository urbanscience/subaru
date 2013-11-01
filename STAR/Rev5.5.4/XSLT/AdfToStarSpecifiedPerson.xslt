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
	<xsl:template match="contact">
		<star:SpecifiedPerson>
			<xsl:for-each select="name">
				<xsl:if test="@part ='first' " >
          <xsl:if test="string(.)!=''">
            <star:GivenName>
              <xsl:value-of select="string(.)"/>
            </star:GivenName>
          </xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="name">
			  	<xsl:if test="@part ='middle' ">
				  <xsl:if test="string(.) != ''">
					<star:MiddleName>
						<xsl:value-of select="string(.)"/>
					</star:MiddleName>
				   </xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="name">
				<xsl:if test="@part ='surname' or @part='last' ">
          <xsl:if test="string(.)!=''">
            <star:FamilyName>
              <xsl:value-of select="string(.)"/>
            </star:FamilyName>
          </xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="name">
				<xsl:if test="@part ='suffix' ">
          <xsl:if test="string(.)!=''">
            <star:NameSuffix>
              <xsl:value-of select="string(.)"/>
            </star:NameSuffix>
          </xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="name">
				<xsl:if test="@part ='full' ">
          <xsl:if test="string(.)!=''">
            <star:PreferredName>
              <xsl:value-of select="string(.)"/>
            </star:PreferredName>
          </xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="address">
        <!--only one address can be sent to STAR. So if adf has more than 1 address select first address in ADF-->
        <xsl:if test ="position()=1">
        <!--<xsl:if test="street and city and country">-->
		
				<star:ResidenceAddress>
					<xsl:if test="@type">
						<star:AddressType><xsl:value-of select="@type"></xsl:value-of></star:AddressType>
					</xsl:if>
					<xsl:variable name="varStreetCount" select="count(street)"></xsl:variable>
					<xsl:for-each select="street">
						<xsl:choose>
							<xsl:when test="position()=1">
                <xsl:if test="string(.)!=''">
                  <star:LineOne>
                    <xsl:value-of select="string(.)"/>
                  </star:LineOne>
                </xsl:if>
							</xsl:when>
							<xsl:when test="position()=2">
                <xsl:if test="string(.)!=''">
                  <star:LineTwo>
                    <xsl:value-of select="string(.)"/>
                  </star:LineTwo>
                </xsl:if>
							</xsl:when>
							<xsl:when test="position()=3">
                <xsl:if test="string(.)!=''">
                  <star:LineThree>
                    <xsl:value-of select="string(.)"/>
                  </star:LineThree>
                </xsl:if>
							</xsl:when>
							<xsl:when test="position()=4">
                <xsl:if test="string(.)!=''">
                  <star:LineFour>
                    <xsl:value-of select="string(.)"/>
                  </star:LineFour>
                </xsl:if>
							</xsl:when>
							<xsl:when test="position()=5">
                <xsl:if test="string(.)!=''">
                  <star:LineFive>
                    <xsl:value-of select="string(.)"/>
                  </star:LineFive>
                </xsl:if>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="apartment">
            <xsl:if test="string(.)!=''">
              <star:BuildingNumber>
                <xsl:value-of select="string(.)"/>
              </star:BuildingNumber>
            </xsl:if>
					</xsl:for-each>
					<xsl:for-each select="city">
            <xsl:if test="string(.)!=''">
              <star:CityName>
                <xsl:value-of select="string(.)"/>
              </star:CityName>
            </xsl:if>
					</xsl:for-each>
										
					<!--<xsl:for-each select="country">
						<star:CountryID>
							<xsl:choose>
								<xsl:when test="string(.)='USA'">US</xsl:when>
							</xsl:choose>
						</star:CountryID>
					</xsl:for-each>-->
					
					
           <star:CountryID>US</star:CountryID>
             <!--
             <xsl:variable name="varCountryCount" select="count(country)"></xsl:variable>
						<xsl:choose>
							<xsl:when test="string(number($varCountryCount))=0">
							  <star:CountryID>US</star:CountryID>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="country">
									<star:CountryID>
										<xsl:value-of select="string(.)"/>
									</star:CountryID>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
              -->
					<xsl:for-each select="postalcode">
            <xsl:if test="string(.)!=''">
              <star:Postcode>
                <xsl:value-of select="string(.)"/>
              </star:Postcode>
            </xsl:if>
					</xsl:for-each>
					<xsl:for-each select="regioncode">
            <xsl:if test="string(.)!=''">
              <star:StateOrProvinceCountrySub-DivisionID>
                <xsl:value-of select="string(.)"/>
              </star:StateOrProvinceCountrySub-DivisionID>
            </xsl:if>
					</xsl:for-each>
				</star:ResidenceAddress>
        </xsl:if>
  
      </xsl:for-each>
			<xsl:for-each select="phone">
				<xsl:if test=".!=''">
				<star:TelephoneCommunication>
					<star:ChannelCode>
					<xsl:choose>
						<xsl:when test="@type='voice' and @time='day'">Day Phone</xsl:when>
						<xsl:when test="@type='voice' and @time='evening'">Evening Phone</xsl:when>
						<xsl:when test="@type='voice' and @time='afternoon'">Afternoon Phone</xsl:when>
						<xsl:when test="@type='voice' and @time='nopreference'">No Preference</xsl:when>
						<xsl:when test="@type='voice' and @time='morning'">Morning</xsl:when>
						<xsl:when test="@type='voice' and not(@time)">Day Phone</xsl:when>
						<!--<xsl:when test="@type='voice' and (@time!='day' or @time!='evening' or @time!='afternoon' or @time!='nopreference')">Day Phone</xsl:when>-->
            <xsl:when test="@type='voice' and not(@time='day') and not(@time!='evening') and not(@time='afternoon') and not(@time='nopreference')">Day Phone</xsl:when>
            <xsl:when test="@type='pager' ">Pager</xsl:when>
						<xsl:when test="@type='cell' or @type='cellphone' ">Cell Phone</xsl:when>
						<xsl:otherwise>Other</xsl:otherwise>
					</xsl:choose>
					</star:ChannelCode>
					<star:LocalNumber><xsl:value-of select="text()"></xsl:value-of></star:LocalNumber>
				</star:TelephoneCommunication>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="email">
				<star:URICommunication>
					<star:URIID><xsl:value-of select="text()"></xsl:value-of></star:URIID>
					<star:ChannelCode>Home Email</star:ChannelCode>
				</star:URICommunication>
			</xsl:for-each>


      <xsl:if test="email/@preferredcontact or phone/@preferredcontact" >
        <star:ContactMethodTypeCode>
          <xsl:variable name="varPhoneTime" select="/adf/prospect/customer/contact/phone[@preferredcontact='1']/@time"></xsl:variable>
          <xsl:variable name="varPhoneType" select="/adf/prospect/customer/contact/phone[@preferredcontact='1']/@type"></xsl:variable>
          <xsl:variable name="varEmailType" select="/adf/prospect/customer/contact/email[@preferredcontact='1']"></xsl:variable>

          <xsl:choose>
            <xsl:when test="$varEmailType!= ''">
              <xsl:text>Home Email</xsl:text>
            </xsl:when>
            <xsl:when test="$varPhoneType!=''">
              <xsl:choose>
                <xsl:when test="$varPhoneType='cellphone' or $varPhoneType='cell'">Cell Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='day' ">Day Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='evening' ">Evening Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='afternoon' ">Day Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='nopreference' ">Day Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='morning' ">Day Phone</xsl:when>
                <xsl:when test="$varPhoneType='voice' and (not($varPhoneTime='day') and not($varPhoneTime='evening') and not($varPhoneTime='afternoon') and not($varPhoneTime='nopreference')) ">Day Phone</xsl:when>
                <!--<xsl:when test="$varPhoneType='voice' and ($varPhoneTime!='day' or $varPhoneTime!='evening' or $varPhoneTime!='afternoon' or $varPhoneTime!='nopreference') ">Day Phone</xsl:when>-->
                <xsl:when test="$varPhoneType='voice' and $varPhoneTime='' ">Day Phone</xsl:when>
                <xsl:when test="$varPhoneType='fax' ">Home Fax</xsl:when>
                <xsl:when test="$varPhoneType='pager' ">Pager</xsl:when>
                <!--<xsl:otherwise>
                  <xsl:text>N/A</xsl:text>
                </xsl:otherwise>-->
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>N/A</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </star:ContactMethodTypeCode>
      </xsl:if>


    </star:SpecifiedPerson>
</xsl:template>
</xsl:stylesheet>
