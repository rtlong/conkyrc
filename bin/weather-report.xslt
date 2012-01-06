<!--

 This XSLT is used to translate an XML response from the wunderground.com
 XML API.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
	<xsl:output method="text" disable-output-escaping="yes"/>
	<xsl:template match="current_observation">
    <xsl:text>Temp: </xsl:text><xsl:value-of select="temperature_string"/><xsl:text> • </xsl:text>
    <xsl:text>Humid: </xsl:text><xsl:value-of select="relative_humidity"/><xsl:text>% • </xsl:text>
    <xsl:text>Wind: </xsl:text><xsl:value-of select="wind_string"/><xsl:text> • </xsl:text>
    <xsl:text>Press: </xsl:text><xsl:value-of select="pressure_string"/><xsl:text> • </xsl:text>
    <xsl:text>DP: </xsl:text><xsl:value-of select="dewpoint_string"/><xsl:text></xsl:text>
	</xsl:template>
</xsl:stylesheet>
