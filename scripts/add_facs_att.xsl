<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <!--   Add attributes to lines -->
    <xsl:template match="line">
        <xsl:variable name="n" select="format-number(count(preceding-sibling::line) + 1, '00')"/>
        <line>
            <!--            Add the @n attribute with line number-->
            <xsl:attribute name="n">
                <xsl:value-of select="$n"/>
            </xsl:attribute>
            <!--            If the line is not empty, create a @facs attribute that 
            it is equal to the column letter followed by the line number-->
            <xsl:if test="string-length() gt 0">
                <xsl:attribute name="facs">
                    <xsl:value-of select="'#c' || parent::zone/@n || 'l' || $n"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="node()"/>
        </line>
    </xsl:template>

    <!--    Format the @coords and @shape attributes, created using Image Map generator
        (https://www.image-map.net/) to be compliant with TEI-->
    <xsl:template match="area">
        <xsl:element name="zone">
            <xsl:variable name="number" select="@title => replace('[^\d]+(\d+)', '$1') => number() => format-number('00')"/>
            <xsl:attribute name="xml:id">
               <xsl:value-of select="'cbl' || $number"/>
                <!--<xsl:value-of select="@href"/>-->
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:value-of select="@shape"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@shape eq 'rect'">
                    <xsl:attribute name="ulx">
                        <xsl:value-of select="replace(@coords, '(\d+),(\d+),(\d+),(\d+)', '$1')"/>
                    </xsl:attribute>
                    <xsl:attribute name="uly">
                        <xsl:value-of select="replace(@coords, '(\d+),(\d+),(\d+),(\d+)', '$2')"/>
                    </xsl:attribute>
                    <xsl:attribute name="lrx">
                        <xsl:value-of select="replace(@coords, '(\d+),(\d+),(\d+),(\d+)', '$3')"/>
                    </xsl:attribute>
                    <xsl:attribute name="lry">
                        <xsl:value-of select="replace(@coords, '(\d+),(\d+),(\d+),(\d+)', '$4')"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="points">
                        <xsl:value-of select="replace(@coords, '(\d+,\d+),', '$1 ')"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <note><xsl:value-of select="@title"/></note>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
