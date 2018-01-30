<!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Thumbnail

Requires
  - CommonSpot ADF

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

<cfcomponent accessors="true" output="true">

  <cfproperty name="width" type="numeric">
  <cfproperty name="height" type="numeric">
  <cfproperty name="path" type="string">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(string cpimage, numeric width, numeric height, string path) {
      var csDataImage = '';

      if (IsDefined('cpimage')) {
        // WriteOutput('<div>Thumbnail: CPIMAGE = #cpimage#</div>');
        csDataImage = application.adf.csData.decipherCPIMAGE(cpimage);
        // WriteDump(var = csDataImage, label = 'Thumbnail: csDataImage');
        // exit;
        width = csDataImage.ORIGWIDTH;
        height = csDataImage.ORIGHEIGHT;
        path = csDataImage.ResolvedURL.SERVERRELATIVE;
      }

      setWidth(thumbnailWidth(width, height));
      setHeight(thumbnailHeight(height, width));
      setPath(thumbnailPath(path));

      return this;
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function isExtant() {
      if (! IsDefined('path')) {
        return false;
      }
      return FileExists(Expandpath(path));
    }

    public function toStruct() {
      return {
        'width' = width,
        'height' = height,
        'path' = path
      };
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function thumbnailWidth(required numeric width, required numeric height) {
      var aspectRatio = width / height;
      return 1 <= aspectRatio ? 150  : Round(150 * aspectRatio);
    }

    private function thumbnailHeight(required numeric height, required numeric width) {
      var aspectRatio = width / height;
      return 1 <= aspectRatio ? Round(150 / aspectRatio) : 150;
    }

    private function thumbnailPath(required string path) {
      return ReplaceNoCase(path, '/images/', '/images/csthumbnail_large/');
    }

  </cfscript>

</cfcomponent>
