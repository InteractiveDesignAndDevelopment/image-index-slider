<cfcomponent accessors="true" output="true">

  <cfproperty name="decR" type="numeric">
  <cfproperty name="decG" type="numeric">
  <cfproperty name="decB" type="numeric">
  <cfproperty name="decA" type="numeric">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init() {
      if (1 eq StructCount(arguments) && not IsNumeric(arguments[1])) {
        setHex(arguments[1]);
      } else if (3 eq StructCount(arguments) || 4 eq StructCount(arguments)) {
        setDecR(arguments[1]);
        setDecG(arguments[2]);
        setDecB(arguments[3]);
        if (4 eq arguments.length) {
          if (0 < Find('.', arguments[4])) {
            setDecA(255 * arguments[4]);
          } else {
            setDecA(arguments[4]);
          }
        } else {
          setDecA(255);
        }
      }

      // Debugging
      // WriteDump(var = arguments, label = 'Arguments');
      // WriteOutput('<div>decR = #decR#</div>');
      // WriteOutput('<div>decG = #decG#</div>');
      // WriteOutput('<div>decB = #decB#</div>');
      // WriteOutput('<div>decA = #decA#</div>');

      return this;
    }

    public function getHexR() {
      return FormatBaseN(getDecR(), 16);
    }

    public function getHexG() {
      return FormatBaseN(getDecG(), 16);
    }

    public function getHexB() {
      return FormatBaseN(getDecB(), 16);
    }

    public function getHexA() {
      return FormatBaseN(getDecA(), 16);
    }

    public function toHex() {
      return '###getHexR()##getHexG()##getHexB()#';
    }

    public function toHexA() {
      return '###getHexR()##getHexG()##getHexB()##getHexA()#';
    }

    public function toRGB() {
      return 'rgb(#getDecR()#,#getDecG()#,#getDecB()#)';
    }

    public function toRGBA() {
      var fracA = getDecA() / 255;
      return 'rgba(#getDecR()#,#getDecG()#,#getDecB()#,#fracA#)';
    }

    public function setHex(required string hex) {
      setDecR(InputBaseN(hexPart(hex, 'r'), 16));
      setDecG(InputBaseN(hexPart(hex, 'g'), 16));
      setDecB(InputBaseN(hexPart(hex, 'b'), 16));
      setDecA(InputBaseN(hexPart(hex, 'a'), 16));
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function hexPart(required string hex, required string part) {
      var start = 0;
      var count = 0;
      var hexPart = '';

      if ((3 eq Len(hex) || 6 eq Len(hex)) && 'a' eq part) {
        return 'ff';
      }

      if ('r' eq part) {
        start = 1;
      } else if ('g' eq part) {
        start = 2;
      } else if ('b' eq part) {
        start = 3;
      } else if ('a' eq part) {
        start = 4;
      }

      if (3 eq Len(hex) || 4 eq Len(hex)) {
        count = 1;
      } else if (6 eq Len(hex) || 8 eq Len(hex)) {
        count = 2;
        start *= 2;
      }

      hexPart = Mid(hex, start, count);

      if (1 eq Len(hexPart)) {
        hexPart &= hexPart;
      }

      return LCase(hexPart);
    }

  </cfscript>

</cfcomponent>
