<cfcomponent accessors="true" output="true">

  <cfproperty name="inverseAspectRatiosArray" type="array">

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
    public function init(incomingInverseAspectRatios) {
      inverseAspectRatiosArray = [];

      if (! IsDefined('incomingInverseAspectRatios')) {
        return this;
      }

      if (IsArray(incomingInverseAspectRatios)) {
        ArrayEach(incomingInverseAspectRatios, function(ratio) {
          if (IsStruct(ratio) && StructKeyExists(ratio, 'width') && StructKeyExists(ratio, 'height')) {
              ArrayAppend(inverseAspectRatiosArray, structToInverseAspectRatio(ratio));
          } else if (FindNoCase('x', ratio)) {
            ArrayAppend(inverseAspectRatiosArray, stringToInverseAspectRatio(ratio));
          } else if (IsNumeric(ratio)) {
            ArrayAppend(inverseAspectRatiosArray, ratio);
          }
        });
      } else if (Find(',', incomingInverseAspectRatios)) {
        ListEach(incomingInverseAspectRatios, function(ratio) {
          if (FindNoCase('x', ratio)) {
            ArrayAppend(inverseAspectRatiosArray, stringToInverseAspectRatio(ratio));
          } else if (IsNumeric(ratio)) {
            ArrayAppend(inverseAspectRatiosArray, ratio);
          }
        });
      }

      return this;
    }

    public function average() {
      var sum = ArrayReduce(inverseAspectRatiosArray, function(result, item) {
        return result + item;
      }, 0);
      return sum / ArrayLen(inverseAspectRatiosArray);
    }

    function narrowest() {
        var tempArray = inverseAspectRatiosArray;
        ArraySort(tempArray, 'numeric' , 'asc');
        return tempArray[1];
    }

    public function toArray() {
      return inverseAspectRatiosArray;
    }

    public function toList() {
      return ArrayToList(inverseAspectRatiosArray);
    }

    function widest() {
        var tempArray = inverseAspectRatiosArray;
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

    private function structToInverseAspectRatio(dimensionsStruct) {
      var width = dimensionsStruct.width;
      var height = dimensionsStruct.height;
      if (0 eq width || 0 eq height) {
        return 0;
      }
      return height / width;
    }

    private function stringtoInverseAspectRatio(dimensionsString) {
      var width = ListFirst(dimensionsString, 'xX');
      var height = ListLast(dimensionsString, 'xX');
      return height / width;
    }
  </cfscript>

</cfcomponent>
