<!--- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Slider

Render the HTML for the Slider renderhandler of the Image Index CommonSpot
standard element.

Requires
  - Color
  - ImageIndex

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- --->

<cfcomponent accessors="true" output="true">

  <cfproperty name="ImageIndex">

  <cfscript>
    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(ImageIndex) {
      setImageIndex(ImageIndex);
      return this;
    }
  </cfscript>

    <!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

    <cffunction name="toHTML" returnType="string" access="public">
      <cfscript>
        var html = '';
      </cfscript>
      <cfsavecontent variable = "html">
        <cfoutput>

          #styleTag()#

          <div class="#imageIndexSliderClasses()#" id="image-index-slider-#ImageIndex.getInstanceID()#" #imageIndexSliderDataAttributes()#>

            <div class="#themeClasses()#">

              <div class="#carouselClasses()#">

                <cfset jsIndex = 0>
                <cfloop array="#ImageIndex.getImages().toArray()#" index="image">
                  <div class="#cellClasses()#" id="image-index-slider-#ImageIndex.getInstanceID()#-cell-#jsIndex#">
                    <figure class="image-index-slider-cell__figure">
                      <a class="#linkClasses()#" href="#image.getSizes().largest().path#" #linkDataAttributes(image)#>
                        <img alt="#imgAlt(image)#"
                          class="image-index-slider-cell__thumbnail"
                          src="#image.getSizes().smallest().path#"
                          srcset="#thumbnailSrcSet(image)#" />
                      </a>
                      <cfif isTitleRendered(image) || isDescriptionRendered(image)>
                        <figcaption class="#captionClasses()#">
                          <cfif isTitleRendered(image)>
                            <div class="#titleClasses()#">
                              #image.getTitle()#
                            </div>
                          </cfif>
                          <cfif isDescriptionRendered(image)>
                            <div class="#descriptionClasses(image)#">
                              #image.getDescription()#
                            </div>
                          </cfif>
                        </figcaption>
                      </cfif>
                    </figure>
                  </div>

                  <cfset ++jsIndex>
                </cfloop>

              </div>

            </div>

          </div>

        </cfoutput>
      </cfsavecontent>
      <cfscript>
        return html;
      </cfscript>
    </cffunction>

    <!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

    <cfscript>

      private function imgAlt(image) {
        var attributeValue = '';
        if (0 lt Len(image.getTitle())) {
          attributeValue = image.getTitle();
        }
        if (0 lt Len(image.getDescription())) {
          if (0 lt Len(attributeValue)) {
            attributeValue &= ' ';
          }
          attributeValue &= image.getDescription();
        }
        return attributeValue;
      }

      private function isTitleRendered(image) {
        var isTitleVisible = ImageIndex.getTitleClasses().hasClass('visible');
        var isTitleBlank = 0 eq Len(image.getTitle());
        return isTitleVisible && ! isTitleBlank;
      }

      private function isDescriptionRendered(image) {
        var isDescriptionVisible = ImageIndex.getDescriptionClasses().hasClass('visible');
        var isDescriptionBlank = 0 eq Len(image.getDescription());
        var isSameAsTitle = false;
        var cleanDescription = '';
        var cleanTitle = '';
        if (IsDefined('title')) {
          cleanTitle = LCase(image.getTitle());
          cleanTitle = Replace(cleanTitle, ' a ', '', 'all');
          cleanTitle = Replace(cleanTitle, ' an ', '', 'all');
          cleanTitle = Replace(cleanTitle, ' the ', '', 'all');
          cleanTitle = REReplace(cleanTitle, '\W', '', 'all');
          cleanDescription = LCase(description);
          cleanDescription = Replace(cleanDescription, ' a ', '', 'all');
          cleanDescription = Replace(cleanDescription, ' an ', '', 'all');
          cleanDescription = Replace(cleanDescription, ' the ', '', 'all');
          cleanDescription = REReplace(cleanDescription, '\W', '', 'all');
          isSameAsTitle = cleanTitle == cleanDescription;
        }
        return isDescriptionVisible && ! isDescriptionBlank && ! isSameAsTitle;
      }

      private function themeClasses() {
        var themeName = ImageIndex.getElementComponentClasses().valueOf('theme');

        if (! isDefined('themeName')) {
          themeName = 'default';
        }

        themeName = new HyphenatedString(themeName).toCamelCase();

        return 't-#themeName#';
      }

      private function styleTag() {
        var style = [];

        var id = ImageIndex.getInstanceID();
        var maxAspectRatio = ImageIndex.getImages().widestAspectRatio().getAspectRatio();
        var minHeight = ImageIndex.getImages().shortest().getSizes().largest().height;
        var elementBackgroundColor = ImageIndex.getElementComponentClasses().valueOf('background-color');
        var photoBackgroundColor = ImageIndex.getPhotoClasses().valueOf('background-color');
        var captionBackgroundColor = ImageIndex.getPhotoClasses().valueOf('caption-background-color');
        var titleColor = ImageIndex.getTitleClasses().valueOf('color');
        var titleSize = ImageIndex.getTitleClasses().valueOf('size');
        var descriptionColor = ImageIndex.getDescriptionClasses().valueOf('color');
        var descriptionSize = ImageIndex.getDescriptionClasses().valueOf('size');

        ArrayAppend(style, '<style>');

        ArrayEach(ImageIndex.getImages().toArray(), function(image, i) {
          var thisAspectRatio = image.getAspectRatio();
          var thisInverseAspectRatio = image.getInverseAspectRatio();
          var figureMaxWidth = '#100 * (thisAspectRatio / maxAspectRatio)#%';
          var linkMaxWidth = '#minHeight / thisInverseAspectRatio#px';
          i = i - 1;  // Use a zero-based index for JS integration
          ArrayAppend(style, '##image-index-slider-#id#-cell-#i# .image-index-slider-cell__figure { max-width: #figureMaxWidth#; }');
          ArrayAppend(style, '##image-index-slider-#id#-cell-#i# .image-index-slider-cell__link { max-width: #linkMaxWidth#; }');
        });

        if (IsDefined('elementBackgroundColor')) {
          elementBackgroundColor = new Color(elementBackgroundColor).toRGBA();
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider__carousel {');
          ArrayAppend(style, 'background-color: #elementBackgroundColor#;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('photoBackgroundColor')) {
          photoBackgroundColor = new Color(photoBackgroundColor).toRGBA();
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__cell {');
          ArrayAppend(style, 'background-color: #photoBackgroundColor#;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('captionBackgroundColor')) {
          captionBackgroundColor = new Color(captionBackgroundColor).toRGBA();
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__caption {');
          ArrayAppend(style, 'background-color: #captionBackgroundColor#;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('titleColor')) {
          titleColor = new Color(titleColor).toRGBA();
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__title {');
          ArrayAppend(style, 'color: #titleColor#;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('titleSize')) {
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__title {');
          ArrayAppend(style, 'font-size: #titleSize#px;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('descriptionColor')) {
          descriptionColor = new Color(descriptionColor).toRGBA();
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__description {');
          ArrayAppend(style, 'color: #descriptionColor#;');
          ArrayAppend(style, '}');
        }

        if (IsDefined('descriptionSize')) {
          ArrayAppend(style, '##image-index-slider-#id# .image-index-slider-cell__description {');
          ArrayAppend(style, 'font-size: #descriptionSize#px;');
          ArrayAppend(style, '}');
        }

        ArrayAppend(style, '</style>');

        return ArrayToList(style, chr(10));
      }

      /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

       ██████ ██       █████  ███████ ███████ ███████ ███████
      ██      ██      ██   ██ ██      ██      ██      ██
      ██      ██      ███████ ███████ ███████ █████   ███████
      ██      ██      ██   ██      ██      ██ ██           ██
       ██████ ███████ ██   ██ ███████ ███████ ███████ ███████

      =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

      private function cellClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider-cell');
        if (ImageIndex.getDescriptionClasses().hasClass('visible')) {
          ArrayAppend(classes, 'image-index-slider-cell--with-description');
        }
        if (ImageIndex.getTitleClasses().hasClass('visible')) {
          ArrayAppend(classes, 'image-index-slider-cell--with-title');
        }
        return ArrayToList(classes, ' ');
      }

      private function captionClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider-cell__caption');
        return ArrayToList(classes, ' ');
      }

      private function carouselClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider__carousel');
        return ArrayToList(classes, ' ');
      }

      private function descriptionClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider-cell__description');
        return ArrayToList(classes, ' ');
      }

      private function imageIndexSliderClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider');
        return ArrayToList(classes, ' ');
      }

      private function linkClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider-cell__link');
        return ArrayToList(classes, ' ');
      }

      private function titleClasses() {
        var classes = [];
        ArrayAppend(classes, 'image-index-slider-cell__title');
        return ArrayToList(classes, ' ');
      }

      /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

      ██████   █████  ████████  █████       █████  ████████ ████████ ██████  ██ ██████  ██    ██ ████████ ███████ ███████
      ██   ██ ██   ██    ██    ██   ██     ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██      ██
      ██   ██ ███████    ██    ███████     ███████    ██       ██    ██████  ██ ██████  ██    ██    ██    █████   ███████
      ██   ██ ██   ██    ██    ██   ██     ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██           ██
      ██████  ██   ██    ██    ██   ██     ██   ██    ██       ██    ██   ██ ██ ██████   ██████     ██    ███████ ███████

      =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

      private function imageIndexSliderDataAttributes() {
        var dataAttributes = [];
        var autoPlay = ImageIndex.getElementComponentClasses().dataAttributeOf('auto-play');

        if (IsDefined('autoPlay')) {
          ArrayAppend(dataAttributes, 'data-auto-play=#autoPlay#');
        }

        return ArrayToList(dataAttributes, ' ');
      }

      private function linkDataAttributes(required image) {
        var dataAttributes = [];
        var captionValue = imgAlt(image);

        if (0 lt Len(captionValue)) {
          ArrayAppend(dataAttributes, 'data-caption="#captionValue#"');
        }

        ArrayAppend(dataAttributes, 'data-group="#ImageIndex.getInstanceID()#"');

        return ArrayToList(dataAttributes, ' ');
      }

      private function thumbnailSrcSet(required struct image) {
        var sizes = [];

        ArrayEach(image.getSizes().toArray(), function(size) {
          ArrayAppend(sizes, '#size.path# #size.width#w');
        });

        return ArrayToList(sizes, ', ');
      }

    </cfscript>

</cfcomponent>
