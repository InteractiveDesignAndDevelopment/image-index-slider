<cfcomponent accessors="true" output="true">

  <cfproperty name="aString" type="string">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(required string incomingString) {
      aString = incomingString;

      return this;
    }

    public function toCamelCase() {
      return ListReduce(aString, function(camelCase, part, i) {
        var letterFirst = '';
        var letterRest = '';
        if (1 eq i) {
          return camelCase & LCase(part);
        }
        letterFirst = Mid(part, 1, 1);
        letterFirst = UCase(letterFirst);
        letterRest = Mid(part, 2, Len(part) - 1);
        letterRest = LCase(letterRest);
        return camelCase & letterFirst & letterRest;
      }, '', '-');
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
