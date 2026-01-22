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
 
 This XSLT transforms RADAR/XML to DCat/XML
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dct="http://purl.org/dc/terms/" xmlns:dcat="http://www.w3.org/ns/dcat#"
  xmlns:dcatde="http://dcat-ap.de/def/dcatde/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:adms="http://www.w3.org/ns/adms#"
  xmlns:vcard="http://www.w3.org/2006/vcard/ns#">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/*[local-name() = 'radarDataset']">
    <rdf:RDF>
      <dcat:Dataset>
        <dct:publisher xmlns:dct="http://purl.org/dc/terms/">
          <foaf:Organization xmlns:foaf="http://xmlns.com/foaf/0.1/"
            rdf:about="https://www.rz.uni-wuerzburg.de/dienste/forschung-digital/wuedata">
            <foaf:name>Universitätsbibliothek Würzburg</foaf:name>
          </foaf:Organization>
        </dct:publisher>
        <!--Category-->
        <dcat:theme rdf:resource="http://publications.europa.eu/resource/authority/data-theme/TECH"/>
        <!-- Date modified -->
        <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">
          <xsl:value-of select="current-date()"/>
        </dct:modified>
        <!-- Year -->
        <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">
          <xsl:value-of select="*[local-name() = 'publicationYear']"/>
        </dct:issued>
        <dct:identifier>
          <xsl:value-of select="*[local-name() = 'identifier']"/>
        </dct:identifier>
        <dct:title>
          <xsl:value-of select="*[local-name() = 'title']"/>
        </dct:title>
        <xsl:for-each
          select="*[local-name() = 'additionalTitles']/*[local-name() = 'additionalTitle']">
          <dct:alternative>
            <xsl:value-of select="."/>
          </dct:alternative>
        </xsl:for-each>
        <!-- Description -->
        <dct:description>
          <xsl:for-each select="*[local-name() = 'descriptions']/*[local-name() = 'description']">
            <xsl:value-of select="@descriptionType"/>
            <xsl:text>:
              </xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>
            </xsl:text>
          </xsl:for-each>
        </dct:description>
        <xsl:for-each select="*[local-name() = 'creators']/*[local-name() = 'creator']">
          <dct:creator>
            <foaf:Person>
              <foaf:givenName>
                <xsl:value-of select="*[local-name() = 'givenName']"/>
              </foaf:givenName>
              <foaf:familyName>
                <xsl:value-of select="*[local-name() = 'familyName']"/>
              </foaf:familyName>
              <foaf:name>
                <xsl:value-of select="*[local-name() = 'creatorName']"/>
              </foaf:name>
              <foaf:affiliation>
                <foaf:Organization>
                  <foaf:name>
                    <xsl:value-of select="*[local-name() = 'creatorAffiliation']"/>
                  </foaf:name>
                </foaf:Organization>
              </foaf:affiliation>
            </foaf:Person>
          </dct:creator>
        </xsl:for-each>
        <xsl:for-each select="*[local-name() = 'contributors']/*[local-name() = 'contributor']">
          <dct:contributor>
            <foaf:Person>
              <foaf:givenName>
                <xsl:value-of select="*[local-name() = 'givenName']"/>
              </foaf:givenName>
              <foaf:familyName>
                <xsl:value-of select="*[local-name() = 'familyName']"/>
              </foaf:familyName>
              <foaf:name>
                <xsl:value-of select="*[local-name() = 'contributorName']"/>
              </foaf:name>
              <foaf:affiliation>
                <foaf:Organization>
                  <foaf:name>
                    <xsl:value-of select="*[local-name() = 'contributorAffiliation']"/>
                  </foaf:name>
                </foaf:Organization>
              </foaf:affiliation>
            </foaf:Person>
          </dct:contributor>
        </xsl:for-each>

        <xsl:for-each select="*[local-name() = 'keywords']/*[local-name() = 'keyword']">
          <dcat:keyword>
            <xsl:value-of select="."/>
          </dcat:keyword>
        </xsl:for-each>

        <xsl:for-each select="*[local-name() = 'subjectAreas']/*[local-name() = 'subjectArea']">
          <dct:subject>
            <xsl:value-of select="*[local-name() = 'controlledSubjectAreaName']"/>
          </dct:subject>
          <xsl:if test="*[local-name() = 'additionalSubjectAreaName']">
            <dct:subject>
              <xsl:value-of select="*[local-name() = 'additionalSubjectAreaName']"/>
            </dct:subject>
          </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="*[local-name() = 'geoLocations']/*[local-name() = 'geoLocation']">
          <dct:spatial>
            <dct:Location>
              <dct:title>
                <xsl:value-of select="*[local-name() = 'geoLocationRegion']"/>
              </dct:title>
              <xsl:if test="*[local-name() = 'geoLocationBox']">
                <dcat:bbox>
                  <xsl:value-of select="
                      concat(
                      *[local-name() = 'geoLocationBox']/*[local-name() = 'southWestPoint']/*[local-name() = 'longitude'], ',',
                      *[local-name() = 'geoLocationBox']/*[local-name() = 'southWestPoint']/*[local-name() = 'latitude'], ',',
                      *[local-name() = 'geoLocationBox']/*[local-name() = 'northEastPoint']/*[local-name() = 'longitude'], ',',
                      *[local-name() = 'geoLocationBox']/*[local-name() = 'northEastPoint']/*[local-name() = 'latitude']
                      )"/>
                </dcat:bbox>
              </xsl:if>
            </dct:Location>
          </dct:spatial>
        </xsl:for-each>
        <xsl:for-each select="*[local-name() = 'software']/*[local-name() = 'softwareType']">
          <dct:conformsTo>
            <dct:Standard>
              <dct:title>
                <xsl:value-of select="*[local-name() = 'softwareName']"/>
              </dct:title>
              <xsl:if test="*[local-name() = 'alternativeSoftwareName']">
                <dct:alternative>
                  <xsl:value-of select="*[local-name() = 'alternativeSoftwareName']"/>
                </dct:alternative>
              </xsl:if>
            </dct:Standard>
          </dct:conformsTo>
        </xsl:for-each>

        <xsl:for-each
          select="*[local-name() = 'relatedIdentifiers']/*[local-name() = 'relatedIdentifier']">
          <dct:isPartOf rdf:resource="https://doi.org/{.}"/>
        </xsl:for-each>
        <dct:accessRights
          rdf:resource="http://publications.europa.eu/resource/authority/access-right/PUBLIC"/>
        <xsl:for-each
          select="*[local-name() = 'fundingReferences']/*[local-name() = 'fundingReference']">
          <dct:conformsTo>
            <dct:Standard>
              <dct:title>
                <xsl:value-of select="*[local-name() = 'awardTitle']"/>
              </dct:title>
              <dct:identifier>
                <xsl:value-of select="*[local-name() = 'awardNumber']"/>
              </dct:identifier>
              <dct:description>
                <xsl:value-of select="*[local-name() = 'funderName']"/>
              </dct:description>
              <xsl:if test="*[local-name() = 'awardURI']">
                <dct:source>
                  <xsl:value-of select="*[local-name() = 'awardURI']"/>
                </dct:source>
              </xsl:if>
            </dct:Standard>
          </dct:conformsTo>
        </xsl:for-each>
        <!--Distribution with Format, acessURL and Licence-->
        <dcat:distribution>
          <dcat:Distribution>
            <!-- Language -->
            <dct:language>
              <xsl:attribute name="rdf:resource">
                <xsl:choose>
                  <xsl:when test="normalize-space(string(*[local-name() = 'language'])) = 'deu'"
                    >http://publications.europa.eu/resource/authority/language/DEU</xsl:when>
                  <xsl:when test="normalize-space(string(*[local-name() = 'language'])) = 'eng'"
                    >http://publications.europa.eu/resource/authority/language/ENG</xsl:when>
                  <xsl:otherwise><xsl:value-of select="*[local-name() = 'language']"
                    />http://publications.europa.eu/resource/authority/language/ENG</xsl:otherwise>
                </xsl:choose>

              </xsl:attribute>
            </dct:language>
            <dcat:accessURL rdf:resource="https://dx.doi.org/{*[local-name()='identifier']}"/>
            <dct:format
              rdf:resource="http://publications.europa.eu/resource/authority/file-type/HTML"/>

            <!-- Licence-->
            <xsl:for-each select="*[local-name() = 'rights']/*[local-name() = 'controlledRights']">
              <dct:license>
                <xsl:choose>
                  <xsl:when test=". = 'CC BY 4.0 Attribution'">
                    <xsl:attribute name="rdf:resource"
                      >http://dcat-ap.de/def/licenses/cc-by/4.0</xsl:attribute>
                  </xsl:when>
                  <xsl:when test=". = 'CC BY-NC-SA 4.0 Attribution-NonCommercial-ShareAlike'">
                    <xsl:attribute name="rdf:resource"
                      >https://creativecommons.org/licenses/by-nc-sa/4.0/</xsl:attribute>
                  </xsl:when>
                  <xsl:when test=". = 'CC BY-NC-ND 4.0 Attribution-NonCommercial-NoDerivs'">
                    <xsl:attribute name="rdf:resource"
                      >https://creativecommons.org/licenses/by-nc-nd/4.0/</xsl:attribute>
                  </xsl:when>
                  <xsl:when test=". = 'CC BY-SA 4.0 Attribution-ShareAlike'">
                    <xsl:attribute name="rdf:resource"
                      >http://dcat-ap.de/def/licenses/cc-by-sa/4.0</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="rdf:resource"
                      >http://publications.europa.eu/resource/authority/access-right/PUBLIC</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </dct:license>
            </xsl:for-each>
            <dcatde:licenseAttributionByText>
              <xsl:value-of select="*[local-name() = 'rights']/*[local-name() = 'controlledRights']" />
             </dcatde:licenseAttributionByText>
            <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">
              <xsl:value-of select="current-date()"/>
            </dct:modified>
            <!-- Title -->
            <dct:title>
              <xsl:value-of select="*[local-name() = 'title']"/>
            </dct:title>
          </dcat:Distribution>
        </dcat:distribution>
      </dcat:Dataset>
    </rdf:RDF>
  </xsl:template>
</xsl:stylesheet>