<cfcomponent accessors="true" output="true">

  <cfproperty name="dimensions" type="array">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(incomingDimensions) {
      // WriteOutput('<hr>');
      // WriteOutput('<div>Incoming Dimensions</div>');
      // WriteDump(var = incomingDimensions, label = 'Incoming Dimensions');

      if (! IsDefined('incomingDimensions')) {
        return;
      }

      if (isArray(incomingDimensions)) {
        // WriteOutput('<div>Array</div>');
        ArrayEach(incomingDimensions, function(dimensions) {
          if (IsStruct(dimensions) &&
            StructKeyExists(dimensions, 'width') &&
            StructKeyExists(dimensions, 'height')) {
            ArrayAppend(dimensions, structToDimensionsStruct(dimensions));
          } else if (FindNoCase('x', dimensions)) {
            ArrayAppend(dimensions, stringToDimensionsStruct(dimensions));
          }
        });
      } else if (IsStruct(incomingDimensions) &&
        StructKeyExists(incomingDimensions, 'width') &&
        StructKeyExists(incomingDimensions, 'height')) {
        ArrayAppend(dimensions, structToDimensionsStruct(incomingDimensions.width));
      } else if (0 lt Find(',', incomingDimensions)) {
        ListEach(incomingDimensions, function(dimensions) {
          if (FindNoCase('x', dimensions)) {
            ArrayAppend(dimensions, stringToDimensionsStruct(dimensions));
          }
        });
      } else if (0 lt FindNoCase('x', incomingDimensions)) {
        ArrayAppend(dimensions, stringToDimensionsStruct(incomingDimensions));
      }

      // WriteDump(var = dimensions, label = 'Dimensions Array');
      // WriteOutput('<hr>');

      return this;
    }

    public function aspectRatios() {
      return new AspectRatios(dimensions);
    }

    public function max() {
      var tempArray = dimensions;
      return structToDimensionsString(sort(tempArray, 'desc')[1]);
    }

    public function minHeight() {
      var heights = ArrayMap(dimensions, function(dimensions) {
        return dimensions.height;
      });
      ArraySort(heights, 'numeric');
      return heights[1];
    }

    public function sort() {
      var direction = 'asc';
      var tempArray = dimensions;

      if (StructKeyExists(arguments, '1')) {
        if (IsArray(arguments['1'])) {
          tempArray = arguments['1'];
        } else {
          direction = arguments['1'];
        }
      }

      if (StructKeyExists(arguments, '2')) {
        direction = arguments['2'];
      }

      // WriteOutput('<div>Sorting</div>');
      // WriteDump(var = tempArray, label = 'Before Sorting');

      ArraySort(tempArray, function(a, b) {
        var comparison = 0;
        var aPixels = a.width * a.height;
        var bPixels = b.width * b.height;
        if (aPixels lt bPixels) {
            comparison = -1;
        }
        if (bPixels lt aPixels) {
            comparison = 1;
        }
        if ('desc' eq LCase(direction)) {
            comparison *= -1;
        }
        return comparison;
      });

      if (not StructKeyExists(arguments, '1') ||
        (StructKeyExists(arguments, '1')
        && not IsArray(arguments['1']))) {
        dimensions = tempArray;
      }

      // WriteDump(var = tempArray, label = 'After Sorting');

      return tempArray;
    }

    public function toArray() {
      return ArrayMap(dimensions, function(dimensionsStruct) {
        return structToDimensionsString(dimensionsStruct);
      });
    }

    public function toAspectRatiosList() {
      return new AspectRatios(dimensions).toList();
    }

    public function toAspectRatiosArray() {
      return new AspectRatios(dimensions).toArray();
    }

    public function toList() {
      return ArrayToList(toArray());
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function stringToDimensionsStruct(aString) {
      var width = ListFirst(aString, 'xX');
      var height = ListLast(aString, 'xX');
      var dimensionsStruct = {
        'width' = width,
        'height' = height
      };
      return dimensionsStruct;
    }

    private function structToDimensionsString(aStruct) {
      return '#aStruct.width#x#aStruct.height#';
    }

    private function structToDimensionsStruct(aStruct) {
      return {
        'width' = aStruct.width,
        'height' = aStruct.height
      };
    }

  </cfscript>

</cfcomponent>
