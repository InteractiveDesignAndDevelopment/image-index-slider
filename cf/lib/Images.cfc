<!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Image

Requires
  - Image

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

<cfcomponent resultessors="true" output="true">

  <cfproperty name="images" type="array">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(required array items) {
      images = [];

      ArrayEach(items, function(item) {
        ArrayAppend(images, new Image(item));
      });

      return this;
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function aspectRatiosArray() {
      return ArrayReduce(images, function(result, image) {
        ArrayAppend(result, image.aspectRatio);
      }, []);
    }

    public function aspectRatiosList() {
      return ArrayReduce(images, function(result, image) {
        return ListAppend(result, image.getAspectRatio());
      }, '');
    }

    public function narrowest() {
      return sortedByWidth('asc')[1];
    }

    public function narrowestAspectRatio() {
      return sortedByAspectRatio('asc')[1];
    }

    public function shortest() {
      return sortedByHeight('asc')[1];
    }

    public function sortedByAspectRatio(string direction = 'asc') {
      var tempArr = images;
      var multiplier = 0;
      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }
      ArraySort(tempArr, function(a, b) {
        if (a.getAspectRatio() < b.getAspectRatio()) {
          return -1 * multiplier;
        } else if (b.getAspectRatio() < a.getAspectRatio()) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });
      return tempArr;
    }

    public function sortedByHeight(string direction = 'asc') {
      var tempArr = images;
      var multiplier = 0;
      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }
      ArraySort(tempArr, function(a, b) {
        var aTallestSizeHeight = a.getSizes().tallest().height;
        var bTallestSizeHeight = b.getSizes().tallest().height;
        if (aTallestSizeHeight < bTallestSizeHeight) {
          return -1 * multiplier;
        } else if (bTallestSizeHeight < aTallestSizeHeight) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });
      return tempArr;
    }

    public function sortedByPixels(string direction = 'asc') {
      var tempArr = images;
      var multiplier = 0;
      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }
      ArraySort(tempArr, function(a, b) {
        var aLargestSize = a.getSizes().largest();
        var aPixels = aLargestSize.width * aLargestSize.height;
        var bLargestSize = b.getSizes().largest();
        var bPixels = bLargestSize.widht * bLargestSize.height;
        if (aPixels < bPixels) {
          return -1 * multiplier;
        } else if (bPixels < aPixels) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });
      return tempArr;
    }

    public function sortedByWidth(string direction = 'asc') {
      var tempArr = images;
      var multiplier = 0;
      direction = LCase(direction);
      if ('asc' == direction) {
        multiplier = 1;
      } else if ('desc' == direction) {
        multiplier = -1;
      }
      ArraySort(tempArr, function(a, b) {
        var aNarrowestSizeWidth = a.getSizes().narrowest().width;
        var bNarrowestSizeWidth = b.getSizes().narrowest().width;
        if (aNarrowestSizeWidth < bNarrowestSizeWidth) {
          return -1 * multiplier;
        } else if (bNarrowestSizeWidth < aNarrowestSizeWidth) {
          return 1 * multiplier;
        } else {
          return 0;
        }
      });
      return tempArr;
    }

    public function tallest() {
      return sortedByHeight('desc')[1];
    }

    public function toArray() {
      return images;
    }

    public function widest() {
      return sortedByWidth('desc')[1];
    }

    public function widestAspectRatio() {
      return sortedByAspectRatio('desc')[1];
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
