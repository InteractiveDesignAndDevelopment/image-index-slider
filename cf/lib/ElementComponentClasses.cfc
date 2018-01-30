<cfcomponent accessors="true" output="true">

  <cfproperty name="classes" type="array">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(incomingClasses) {
      classes = ListToArray(incomingClasses, ' ');
      return this;
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██    ██ ██████  ██      ██  ██████
    ██   ██ ██    ██ ██   ██ ██      ██ ██
    ██████  ██    ██ ██████  ██      ██ ██
    ██      ██    ██ ██   ██ ██      ██ ██
    ██       ██████  ██████  ███████ ██  ██████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function hasClass(required string klass) {
      return ArrayContains(classes, klass);
    }

    public function dataAttributeOf(required string key, string attributeName) {
      var value = valueOf(key);
      if (! isDefined('value')) {
        return '';
      }
      if (isDefined('attributeName')) {
        return dataAttribute(attributeName, value);
      }
      return dataAttribute(key, value);
    }

    public function hasValueOf(required string key) {
      var value = valueOf(key);
      return isDefined('value');
    }

    public function toArray() {
        return classes;
    }

    public function toList() {
        return ArrayToList(classes, ' ');
    }

    public function valueOf(required string key) {
      var value = '';

      ArrayEach(classes, function(klass) {
        if (0 < Find(key, klass)) {
          value = valueFromClass(klass, key);
        }
      });

      if (0 lt Len(value)) {
        return value;
      }
    }

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██████  ██████  ██ ██    ██  █████  ████████ ███████
    ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
    ██████  ██████  ██ ██    ██ ███████    ██    █████
    ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
    ██      ██   ██ ██   ████   ██   ██    ██    ███████

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    private function dataAttribute(required string name, value) {
      name = Replace(name, 'data-', '');
      if (isDefined('value')) {
        return 'data-#name#="#value#"';
      } else {
        return 'data-#name#';
      }
    }

    private function valueFromClass(required string klass, key) {
      if (isDefined('key')) {
        return Replace(klass, '#key#-', '');
      } else {
        return ListLast(klass, '-');
      }
    }
  </cfscript>

</cfcomponent>
