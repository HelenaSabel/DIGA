<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"
        html-version="5.0"/>
    <xsl:template match="/">
        <xsl:result-document href="../web/index.html">
            <html>
                <head>
                    <title>Protype</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" type="text/css" href="css/main.css"/>
                    <script src="js/highlight.js"/>
                    <script src="js/jquery-1.7.1.min.js"/>
                    <script src="js/jquery.imagemapster.min.js"/>
                </head>
                <body>
                    <main>
                        <div class="edition">
                            <div id="boundList">
                                <xsl:apply-templates select="//body/div"/>
                            </div>
                        </div>
                    </main>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="div">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="class" select="@type"></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="l">
        <xsl:choose>
            <xsl:when test="string-length(.) eq 0">
                <p> </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:if test="@facs">
                        <xsl:attribute name="data-ref" select="@facs"/>
                        <xsl:attribute name="id" select="replace(@facs, '#', 'tr_')"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="seg | metamark">
        <span data-ref="{@facs}" id="{replace(@facs, '#', 'tr_')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="choice">
        <span class="orig"><xsl:apply-templates select="orig"/></span>
        <span class="reg"><xsl:apply-templates select="reg"/></span>
    </xsl:template>
    <xsl:template match="am|ex|expan">
        <span class="{name()}"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="add">
        <ins class="{@place}" data-ref="{@facs}"><xsl:apply-templates/></ins>
    </xsl:template>
    <xsl:template match="catchwords">
        <span class="reclame"><xsl:apply-templates/></span>
    </xsl:template>
</xsl:stylesheet>
