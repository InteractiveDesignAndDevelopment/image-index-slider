<!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Image

Requires
  - Sizes

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

<cfcomponent accessors="true" output="true">

  <cfproperty name="id" type="numeric">
  <cfproperty name="title">
  <cfproperty name="description">
  <cfproperty name="aspectRatio" type="numeric">
  <cfproperty name="inverseAspectRatio" type="numeric">
  <cfproperty name="sizes">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(required struct item) {
      var ImageAPI = Server.CommonSpot.api.getObject('Image');
      var imageSizePaths = ImageAPI.getImageSizePaths(item.id)[item.id];

      // WriteDump(item);

      title = item.title;
      description = item.description;
      aspectRatio = imageSizesToAspectRatio(imageSizePaths.ImageSizes);
      inverseAspectRatio = imageSizesToInverseAspectRatio(imageSizePaths.ImageSizes);
      sizes = new Sizes(item.id);

      return this;
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function imageSizesToAspectRatio(required imageSizes) {
      return new AspectRatios(StructKeyArray(imageSizes)).average();
    }

    private function imageSizesToInverseAspectRatio(required imageSizes) {
      return new InverseAspectRatios(StructKeyArray(imageSizes)).average();
    }

  </cfscript>

</cfcomponent>
