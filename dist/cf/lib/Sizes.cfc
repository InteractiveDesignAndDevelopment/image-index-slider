<!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Sizes

Requires
  - CommonSpot

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

<cfcomponent accessors="true" output="true">

  <cfproperty name="sizes" type="array">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(required numeric id) {
      var ImageAPI       = Server.CommonSpot.api.getObject('Image');
      var imageSizePaths = ImageAPI.getImageSizePaths(id);
      var largestSize    = 0;
      var thumbnail      = 0;

      // There is only one image in the results, just get it
      imageSizePaths = imageSizePaths[id];

      // WriteDump(imageSizePaths);
      // exit;

      sizes = [];

      ArrayEach(imageSizePaths.Images, function(image) {
        // WriteDump(var = image, label = 'Sizes: image');
        var keyPath = StructFindValue(imageSizePaths.ImageSizes, image.ServerRelative);
        // WriteDump(keyPath);
        var dimensions = ListFirst(keyPath[1].path, '.');

        // Debugging
        // WriteOutput('<div>Sizes: dimensions = #dimensions#</div>');

        ArrayAppend(sizes, {
          'width'  = ListFirst(dimensions, 'xX'),
          'height' = ListLast(dimensions, 'xX'),
          'path'   = image.ServerRelative
        });
      });

      largestSize = largest();

      thumbnail = new Thumbnail(
        width = largestSize.width,
        height = largestSize.height,
        path = largestSize.path);

      if (thumbnail.isExtant()) {
        ArrayAppend(sizes, thumbnail.toStruct());
      }

      return this;
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function largest() {
      return sortedByPixels('desc')[1];
    }

    public function narrowest() {
      return sortedByWidth('asc')[1];
    }

    public function shortest() {
      return sortedByHeight('asc')[1];
    }

    public function smallest() {
      return sortedByPixels('asc')[1];
    }

    public function sortedByHeight(string direction = 'asc') {
      var tempArr = sizes;
      var multiplier = 0;

      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }

      // WriteOutput('<h2>Before Sorting</h2>');
      // WriteDump(tempArr);

      ArraySort(tempArr, function(a, b){
        if (a.height < b.height) {
          return -1 * multiplier;
        } else if (b.height < a.height) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });

      // WriteOutput('<h2>After Sorting</h2>');
      // WriteDump(tempArr);

      return tempArr;
    }

    public function sortedByPixels(string direction = 'asc') {
      var tempArr = sizes;
      var multiplier = 0;

      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }

      // WriteOutput('<h2>Before Sorting</h2>');
      // WriteDump(tempArr);

      ArraySort(tempArr, function(a, b){
        var aPixels = a.width * a.height;
        // writeOutput('<div>#a.width# * #a.height# = aPixels = #aPixels#');
        var bPixels = b.width * b.height;
        // writeOutput('<div>#b.width# * #b.height# = bPixels = #bPixels#');
        if (aPixels < bPixels) {
          return -1 * multiplier;
        } else if (bPixels < aPixels) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });

      // WriteOutput('<h2>After Sorting</h2>');
      // WriteDump(tempArr);

      return tempArr;
    }

    public function sortedByWidth(string direction = 'asc') {
      var tempArr = sizes;
      var multiplier = 0;

      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }

      // WriteOutput('<h2>Before Sorting</h2>');
      // WriteDump(tempArr);

      ArraySort(tempArr, function(a, b){
        if (a.width < b.width) {
          return -1 * multiplier;
        } else if (b.width < a.width) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });

      // WriteOutput('<h2>After Sorting</h2>');
      // WriteDump(tempArr);

      return tempArr;
    }

    public function tallest() {
      return sortedByHeight('desc')[1];
    }

    public function toArray() {
      return sortedByPixels();
    }

    public function widest() {
      return sortedByWidth('desc')[1];
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  </cfscript>

</cfcomponent>
