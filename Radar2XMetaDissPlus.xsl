<?xml version="1.0" encoding="UTF-8"?>
<!-- 
 SOFTWARE LICENSE AGREEMENT
 Data-Transformer: XSLT for Radar/XML © 2025 by Martin Gruner | https://orcid.org/0009-0001-9393-3015
 Creator Affilation: University Library Würzburg | https://ror.org/00fbnyb24
 is licensed under CC BY-SA 4.0
 Creative Commons Attribution-ShareAlike 4.0 International
 
 This license requires that reusers give credit to the creator. 
 It allows reusers to distribute, remix, adapt, and build upon the material in any medium or format, even for commercial purposes.
 If others remix, adapt, or build upon the material, they must license the modified material under identical terms.
 
 This XSLT transforms RADAR/XML to XMetaDissPlus
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:r_elem="http://radar-service.eu/schemas/descriptive/radar/v09/radar-elements"
    xmlns:r_ds="http://radar-service.eu/schemas/descriptive/radar/v09/radar-dataset"
    xmlns:xMetaDiss="http://www.d-nb.de/standards/xmetadissplus/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:ddb="http://www.d-nb.de/standards/ddb/" xmlns:pc="http://www.d-nb.de/standards/pc/"
    xmlns:cc="http://www.d-nb.de/standards/cc/" xmlns:doi="http://www.d-nb.de/standards/doi/"
    xmlns:urn="http://www.d-nb.de/standards/urn/" xmlns:hdl="http://www.d-nb.de/standards/hdl/"
    xmlns:thesis="http://www.ndltd.org/standards/metadata/etdms/1.0/"
    xmlns:dini="http://www.d-nb.de/standards/xmetadissplus/type/"
    xmlns="http://www.d-nb.de/standards/subject/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="r_elem r_ds">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!-- Language variable with Fallback to "eng" -->
    <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="normalize-space(/r_ds:radarDataset/r_elem:language) = 'deu'"
                >ger</xsl:when>
            <xsl:when test="normalize-space(/r_ds:radarDataset/r_elem:language) = 'eng'"
                >eng</xsl:when>
            <xsl:otherwise>eng</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/r_ds:radarDataset">
        <xMetaDiss:xMetaDiss>
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:text>http://www.d-nb.de/standards/xmetadissplus/ xmdpSchema25/xmetadissplus.xsd</xsl:text>
            </xsl:attribute>
           <!-- Title -->
            <xsl:if test="r_elem:title">
                <dc:title>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="$lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="r_elem:title"/>
                </dc:title>
            </xsl:if>
            <!-- Date Type -->
            <dc:type xsi:type="dini:PublType">researchdata</dc:type>
            <!-- Creator -->
            <xsl:for-each select="r_elem:creators/r_elem:creator">
                <dc:creator xsi:type="pc:MetaPers">
                    <pc:person>
                        <pc:name type="nameUsedByThePerson">
                            <xsl:if test="r_elem:givenName">
                                <pc:foreName>
                                    <xsl:value-of select="r_elem:givenName"/>
                                </pc:foreName>
                            </xsl:if>
                            <xsl:if test="r_elem:familyName">
                                <pc:surName>
                                    <xsl:value-of select="r_elem:familyName"/>
                                </pc:surName>
                            </xsl:if>
                        </pc:name>
                        <xsl:if test="r_elem:creatorAffiliation">
                            <pc:affiliation>
                                <cc:universityOrInstitution>
                                    <cc:name>
                                        <xsl:value-of
                                            select="normalize-space(r_elem:creatorAffiliation)"/>
                                    </cc:name>
                                </cc:universityOrInstitution>
                            </pc:affiliation>
                        </xsl:if>
                        <xsl:if test="r_elem:nameIdentifier[@nameIdentifierScheme = 'ORCID']">
                            <ddb:ORCID>
                                <xsl:value-of select="r_elem:nameIdentifier"/>
                            </ddb:ORCID>
                        </xsl:if>
                    </pc:person>
                </dc:creator>
            </xsl:for-each>
            <!-- Keywords -->
            <xsl:for-each select="r_elem:keywords/r_elem:keyword">
                <dc:subject xsi:type="xMetaDiss:noScheme">
                    <xsl:value-of select="."/>
                </dc:subject>
            </xsl:for-each>
            <!-- Software to Keywords, too -->
            <xsl:for-each select="r_elem:software/r_elem:softwareType/r_elem:softwareName">
                <dc:subject xsi:type="xMetaDiss:noScheme">
                    <xsl:value-of select="."/>
                </dc:subject>
            </xsl:for-each>
            <!-- Abstract -->
            <xsl:for-each select="r_elem:descriptions/r_elem:description">
                <dcterms:abstract>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="$lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dcterms:abstract>
            </xsl:for-each>
            <!-- Publisher -->
            <xsl:for-each select="r_elem:publishers/r_elem:publisher">
                <dc:publisher xsi:type="cc:Publisher" type="dcterms:ISO3166">
                    <cc:universityOrInstitution>
                        <cc:name>
                            <xsl:value-of select="."/>
                        </cc:name>
                    </cc:universityOrInstitution>
                </dc:publisher>
            </xsl:for-each>
            <!-- Contributor -->
            <xsl:for-each select="r_elem:contributors/r_elem:contributor">
                <dc:contributor xsi:type="pc:MetaPers">
                    <pc:person>
                        <pc:name type="nameUsedByThePerson">
                            <xsl:if test="r_elem:givenName">
                                <pc:foreName>
                                    <xsl:value-of select="r_elem:givenName"/>
                                </pc:foreName>
                            </xsl:if>
                            <xsl:if test="r_elem:familyName">
                                <pc:surName>
                                    <xsl:value-of select="r_elem:familyName"/>
                                </pc:surName>
                            </xsl:if>
                        </pc:name>
                        <xsl:if test="r_elem:contributorAffiliation">
                            <pc:affiliation>
                                <cc:universityOrInstitution>
                                    <cc:name>
                                        <xsl:value-of
                                            select="normalize-space(r_elem:contributorAffiliation)"
                                        />
                                    </cc:name>
                                </cc:universityOrInstitution>
                            </pc:affiliation>
                        </xsl:if>
                    </pc:person>
                </dc:contributor>
            </xsl:for-each>
            <!-- Year -->
            <xsl:if test="r_elem:publicationYear">
                <dcterms:issued>
                    <xsl:value-of select="r_elem:publicationYear"/>
                </dcterms:issued>
            </xsl:if>
            <!-- DOI DC -->
            <xsl:if test="r_elem:identifier[@identifierType = 'DOI']">
                <dc:identifier>
                    <xsl:attribute name="xsi:type">dcterms:URI</xsl:attribute>
                    <xsl:value-of select="concat('https://doi.org/', r_elem:identifier)"/>
                </dc:identifier>
            </xsl:if>
            <!-- Language -->
            <dc:language>
                <xsl:value-of select="$lang"/>
            </dc:language>
            <!-- Related Identifier -->
            <xsl:for-each
                select="r_elem:relatedIdentifiers/r_elem:relatedIdentifier[not(@relationType = 'IsPublishedIn')]">
                <ddb:relatedIdentifier>
                    <xsl:attribute name="type">
                        <xsl:choose>
                            <xsl:when test="@relatedIdentifierType = 'DOI'">doi</xsl:when>
                            <xsl:otherwise>other</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </ddb:relatedIdentifier>
            </xsl:for-each>
            <!-- Transfer -->
            <xsl:if
                test="r_elem:relatedIdentifiers/r_elem:relatedIdentifier[@relationType = 'IsPublishedIn']">
                <ddb:transfer ddb:type="dcterms:URI">
                    <xsl:value-of
                        select="concat('https://doi.org/', r_elem:relatedIdentifiers/r_elem:relatedIdentifier[@relationType = 'IsPublishedIn'])"
                    />
                </ddb:transfer>
            </xsl:if>
            <!-- DOI DBB -->
            <xsl:if test="r_elem:identifier[@identifierType = 'DOI']">
                <ddb:identifier ddb:type="DOI">
                    <xsl:value-of select="r_elem:identifier"/>
                </ddb:identifier>
            </xsl:if>
            <!-- Rights -->
            <xsl:for-each select="r_elem:rights/r_elem:controlledRights">
                <ddb:rights ddb:kind="domain">
                    <xsl:value-of select="."/>
                </ddb:rights>
                <ddb:licence ddb:licenceType="access">
                    <xsl:value-of select="."/>
                </ddb:licence>
            </xsl:for-each>
        </xMetaDiss:xMetaDiss>
    </xsl:template>
    <xsl:template match="r_elem:* | r_ds:*">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
