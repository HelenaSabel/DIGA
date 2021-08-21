<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"
        html-version="5.0"/>
    <xsl:template match="/">
        <xsl:result-document href="../docs/A56r.html">
            <html>
                <head>
                    <title>Prototype: édition hyperdiplomatique</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" type="text/css" href="css/main.css"/>
                    <link rel="stylesheet" type="text/css" href="css/a.css"/>
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
                        <p>Survolez la transcription pour voir le texte correspondant dans le
                            fac-simil et survolez l’image pour voir sa transcription.</p>
                        <h3>Modifier les critères d’édition</h3>
                        <div class="criteria">
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
                                    <label for="reg">Union / séparation des éléments selon les
                                        unités lexicales</label>
                                    <input checked="checked" type="radio" value="orig" id="orig"
                                        name="unite"/>
                                    <label for="orig">Disposition originale</label>
                                </fieldset>
                                <fieldset>
                                    <input type="checkbox" value="cod" id="cod" checked="checked"/>
                                    <label for="cod">Visualiser notices techniques</label>
                                    <input type="checkbox" value="corr" id="corr" checked="checked"/>
                                    <label for="corr">Visualiser corrections</label>
                                    <input type="checkbox" value="marginalia" id="marginalia"
                                        checked="checked"/>
                                    <label for="marginalia">Visualiser annotations</label>
                                </fieldset>
                                <fieldset>
                                    <input type="checkbox" value="b" id="α"/>
                                    <label for="α">Visualiser copiste <em>α</em> (<span class="α"
                                            >magenta</span>)</label>
                                    <input type="checkbox" value="correcteur" id="correcteur"/>
                                    <label for="correcteur">Visualiser main correcteur (<span
                                            class="correcteur">olive</span>)</label>
                                    <input type="checkbox" value="reviseur" id="reviseur"/>
                                    <label for="reviseur">Visualiser main réviseur (<span
                                            class="reviseur">turquoise</span>)</label>
                                    <input type="checkbox" value="rubricateur" id="rubricateur"/>
                                    <label for="rubricateur">Visualiser main rubricateur (couleur de
                                        l’initiale)</label>
                                    <input type="checkbox" value="tardive" id="tardive"/>
                                    <label for="tardive">Visualiser main tardive (<span
                                            class="tardive">coral</span>)</label>
                                </fieldset>

                            </form>
                            <button id="refresh">Réinitialiser</button>
                        </div>
                        <div id="edition">
                            <div id="boundList">
                                <xsl:apply-templates select="//zone[@type eq 'column']"/>
                            </div>
                            <div>
                                <img src="{descendant::graphic/@url}" usemap="#A56r" alt="f. 56r"
                                    style="width:783px;height:1001px"/>
                            </div>
                        </div>

                        <map name="A56r">
                            <xsl:apply-templates select="//zone[not(@type eq 'column')]"/>
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
    <xsl:template match="zone[@type eq 'column']">
        <div class="left">
            <xsl:apply-templates select="add[@place eq 'left']"/>
        </div>
        <div class="c{@subtype}">
            <ol class="lines">
                <xsl:apply-templates select="line"/>
            </ol>
        </div>
        <div class="right">
            <xsl:apply-templates select="add[@place eq 'right']"/>
        </div>
    </xsl:template>
    <xsl:template match="line">
        <li>
            <xsl:if test="@facs">
                <xsl:attribute name="data-id" select="substring(@facs, 2)"/>
            </xsl:if>
            <xsl:if test="not(subst | hi[@rend eq 'rubricateur'])">
                <xsl:attribute name="data-hand">α</xsl:attribute>
            </xsl:if>
            <xsl:if test="string-length(.) lt 1">
                <xsl:text>&#8199;</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="hi">
        <xsl:choose>
            <xsl:when test="@rend eq 'lettreAttente'">
                <span data-id="{substring(@facs, 2)}" class="cod attente">
                    <xsl:if test="@hand">
                        <xsl:attribute name="data-hand" select="substring(@hand, 2)"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span data-hand="{substring(@hand, 2)}" class="{@rend} {@style} black">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="orig | reg | abbr | expan | ex">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="seg">
        <span data-hand="{substring(@hand, 2)}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="add[parent::subst]">
        <span class="corr">⸢</span>
        <ins data-id="{substring(@facs, 2)}">
            <xsl:if test="@hand">
                <xsl:attribute name="data-hand" select="substring(@hand, 2)"/>
            </xsl:if>
            <xsl:apply-templates/>
        </ins>
        <span class="corr">⸣</span>
    </xsl:template>
    <xsl:template match="add[not(parent::subst)]">
        <ins class="{@place} marginalia" data-id="{substring(@facs, 2)}"
            style="display:block;position:relative;top:{count(preceding-sibling::line)}em">
            <xsl:if test="@hand">
                <xsl:attribute name="data-hand" select="substring(@hand, 2)"/>
            </xsl:if>
            <xsl:apply-templates/>
        </ins>
    </xsl:template>
    <xsl:template match="zone[not(@type eq 'column')]">
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
