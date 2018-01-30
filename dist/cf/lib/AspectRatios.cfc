<cfcomponent accessors="true" output="true">

  <cfproperty name="aspectRatiosArray" type="array">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    // Either aspect ratios or dimenensions can be passed in
    // They both become aspect ratios
    public function init(incomingAspectRatios) {
      aspectRatiosArray = [];

      if (! IsDefined('incomingAspectRatios')) {
        return this;
      }

      if (IsArray(incomingAspectRatios)) {
        ArrayEach(incomingAspectRatios, function(ratio) {
          if (IsStruct(ratio) && StructKeyExists(ratio, 'width') && StructKeyExists(ratio, 'height')) {
              ArrayAppend(aspectRatiosArray, structToAspectRatio(ratio));
          } else if (FindNoCase('x', ratio)) {
            ArrayAppend(aspectRatiosArray, stringToAspectRatio(ratio));
          } else if (IsNumeric(ratio)) {
            ArrayAppend(aspectRatiosArray, ratio);
          }
        });
      } else if (Find(',', incomingAspectRatios)) {
        ListEach(incomingAspectRatios, function(ratio) {
          if (FindNoCase('x', ratio)) {
            ArrayAppend(aspectRatiosArray, stringToAspectRatio(ratio));
          } else if (IsNumeric(ratio)) {
            ArrayAppend(aspectRatiosArray, ratio);
          }
        });
      }

      return this;
    }

    public function average() {
      var sum = ArrayReduce(aspectRatiosArray, function(result, item) {
        return result + item;
      }, 0);
      return sum / ArrayLen(aspectRatiosArray);
    }

    function narrowest() {
        var tempArray = aspectRatiosArray;
        ArraySort(tempArray, 'numeric' , 'asc');
        return tempArray[1];
    }

    public function toArray() {
      return aspectRatiosArray;
    }

    public function toList() {
      return ArrayToList(aspectRatiosArray);
    }

    function widest() {
        var tempArray = aspectRatiosArray;
        ArraySort(tempArray, 'numeric' , 'desc');
        return tempArray[1];
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function structToAspectRatio(dimensionsStruct) {
      var width = dimensionsStruct.width;
      var height = dimensionsStruct.height;
      if (0 eq width || 0 eq height) {
        return 0;
      }
      return width / height;
    }

    private function stringToAspectRatio(dimensionsString) {
      var width = ListFirst(dimensionsString, 'xX');
      var height = ListLast(dimensionsString, 'xX');
      return width / height;
    }
  </cfscript>

</cfcomponent>
