<!-- 

 This XSLT is used to translate an XML response from the weather.com
 XML API. 

 You can format this file to your liking. Two things you may feel 
 like doing:

	1) Modify the layout of the fields or static text already defined
	2) Add other fields from the XML response file that aren't referenced in this
	   XSLT. You can grab a full list by just doing a: 
           wget "http://xoap.weather.com/weather/local/$LOCID?cc=*&unit=$UNITS" 
           (change $LOCID and $UNITS to suit your needs)
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
