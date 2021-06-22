<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"
        html-version="5.0"/>
    <xsl:function name="functx:escape-for-regex" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            replace($arg,
            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
            "/>
        
    </xsl:function>
    <xsl:function name="functx:substring-before-last" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        
        <xsl:sequence select="
            if (matches($arg, functx:escape-for-regex($delim)))
            then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
            else ''
            "/>        
    </xsl:function>
    <xsl:template match="/">
        <xsl:result-document href="../docs/index.html">
            <html>
                <head>
                    <title>Prototype: édition hyperdiplomatique</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" type="text/css" href="css/main.css"/>
                    <script src="js/highlight.js"/>
                    <script src="js/form_radio.js"/>
                    <script src="js/form_checkboxes.js"/>
                    <script src="js/jquery-1.7.1.min.js"/>
                    <script src="js/jquery.imagemapster.min.js"/>
                </head>
                <body>
                    <main>
                        <h1>Prototype: édition hyperdiplomatique</h1>
                        <h2>Édition</h2>
                        <h3>Éxplorer</h3>
                        <form id="criteria">
                            <fieldset>
                                <input type="radio" name="abbreviation" value="ex" id="ex"/>
                                <label for="ex">Abréviations développées</label>
                                <input type="radio" checked="checked" name="abbreviation"
                                    value="abb" id="abb"/>
                                <label for="abb">Marques d’abréviation</label>
                            </fieldset>
                            <fieldset>
                                <input type="radio" id="reg" value="reg" name="unite"/>
                                <label for="reg">Union / séparation des éléments selon les unités
                                    lexicales</label>
                                <input checked="checked" type="radio" value="orig" id="orig"
                                    name="unite"/>
                                <label for="orig">Disposition originale</label>
                            </fieldset>
                            <fieldset>
                                <input type="checkbox" value="cod" id="cod" checked="checked"/>
                                <label for="cod">Visualiser notices techniques</label>
                                <input type="checkbox" value="mark" id="mark"
                                    checked="checked"/>
                                <label for="mark">Visualiser éléments fonctionnels de la
                                    copie</label>
                                <input type="checkbox" value="marginalia" id="marginalia"
                                    checked="checked"/>
                                <label for="marginalia">Visualiser annotations</label>
                            </fieldset>
                            <fieldset><input type="checkbox" value="b" id="b"/><label for="b">Visualiser
                            copiste <em>b</em> (<span class="b">magenta</span>)</label>
                            <input type="checkbox" value="colocci" id="colocci"/><label for="colocci">Visualiser
                                la main d’A. Colocci (<span class="colocci">olive</span>)</label></fieldset>

                        </form>
                        <div id="edition">
                            <div id="boundList">
                                <xsl:apply-templates select="//body/div"/>
                            </div>
                            <img src="{descendant::graphic/@url}" usemap="#158v" alt="f. 158v"/>
                            <button id="refresh">Réinitialiser</button>
                        </div>

                        <map name="158v">
                            <xsl:apply-templates select="//zone"/>
                        </map>
                    </main>
                    <script>
                        $(document).ready(function () {
                        var img = $('img'),
                        list = $('#boundList');
                        
                        
                        // bind selection of a data-id to the UL we created. The "listSelectedClass"
                        // option causes the class "selected" to be added or removed
                        // from the element in "boundList" whose "data-id" attribute has a value
                        // matching the mapKey for the selected area.
                        
                        img.mapster({
                        mapKey: 'data-id',
                        boundList: list.find('*'),
                        listKey: 'data-id',
                        listSelectedClass: 'selected',
                        fillColor: 'ffffff',
                        stroke: true,
                        singleSelect: true
                        });
                        
                        // bind click event
                        
                        $(document).on('mouseenter', '#boundList *[data-id]', function (e) {
                        
                        var el = $(e.target);
                        el.toggleClass('selected');
                        //debugger;
                        img.mapster('set', null, el.attr('data-id'));
                        // changing selections manually doesn't result in the boundList
                        // being fired, we still have to set the data-id on the list item
                        }).on('mouseleave', '.selected', function (e) {
                        e.preventDefault();
                        
                        img.mapster('set', false, img.mapster('get'));
                        });
                        });</script>
                    <script>
                        $('#refresh').click(function() {
                        location.reload(true);
                        });
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="div">
        <div class="{@type}">
            <ol class="lines">
                <xsl:apply-templates select="l | lb"/>
            </ol>
            <xsl:apply-templates select="ab"/>

        </div>
    </xsl:template>
    <xsl:template match="ab">
        <div id="outside">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="l">
        <li>
            <xsl:if test="@facs">
                <xsl:attribute name="data-id" select="substring(@facs, 2)"/>
            </xsl:if>
            <xsl:if test="not(add|num)">
                <xsl:attribute name="data-hand">b</xsl:attribute>
            </xsl:if>
            <xsl:if test="add/@place eq 'right'">
                <xsl:attribute name="class">hasRight</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="text()[ancestor::l][following-sibling::am]">
        <xsl:variable name="lastCharacter" select="substring(., string-length(.), 1)" />
        <xsl:value-of select="functx:substring-before-last(., $lastCharacter)"/>
    </xsl:template>
    <xsl:template match="lb">
        <li>&#8199;</li>
    </xsl:template>
    <xsl:template match="seg">
        <span data-id="{substring(@facs, 2)}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="pc|num">
        <span data-id="{substring(@facs, 2)}" class="mark">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="choice">
        <span class="orig">
            <xsl:apply-templates select="orig"/>
        </span>
        <span class="reg">
            <xsl:apply-templates select="reg"/>
        </span>
    </xsl:template>
    <xsl:template match="ex">
        <xsl:variable name="text" select="preceding-sibling::text()[1]"/>
        <xsl:choose>
            <xsl:when test="not(parent::expan)">
                <span class="expan"><xsl:value-of select="substring($text, string-length($text), 1)"/><span class="ex"><xsl:apply-templates/></span></span>
            </xsl:when>
            <xsl:otherwise>
                <span class="ex"><xsl:apply-templates/></span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="am">
        <xsl:variable name="text" select="preceding-sibling::text()[1]"/>
        <xsl:choose>
            <xsl:when test="not(following-sibling::expan)">                
                <span class="am">
                    <xsl:value-of select="substring($text, string-length($text), 1) || current()"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="am">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <span class="am">
            <xsl:value-of select="substring($text, string-length($text), 1) || current()"/>
        </span>
    </xsl:template>
    <xsl:template match="expan">
        <span class="expan">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="add">
        <ins class="{@place} marginalia" data-id="{substring(@facs, 2)}">
            <xsl:if test="@hand">
                <xsl:attribute name="data-hand" select="substring(@hand, 2)"/>
            </xsl:if>
            <xsl:apply-templates/>
        </ins>
    </xsl:template>
    <xsl:template match="catchwords">
        <span class="cod" data-id="{substring(@facs,2)}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="zone">
        <area href="#" shape="{@type}" alt="{normalize-space(note)}" title="{normalize-space(note)}"
            data-id="{@xml:id}">
            <xsl:choose>
                <xsl:when test="@type eq 'rect'">
                    <xsl:attribute name="coords"
                        select="@ulx || ',' || @uly || ',' || @lrx || ',' || @lry"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="coords" select="replace(@points, '\s+', ',')"/>
                </xsl:otherwise>
            </xsl:choose>
        </area>
        <xsl:text>
            
        </xsl:text>
    </xsl:template>
</xsl:stylesheet>
