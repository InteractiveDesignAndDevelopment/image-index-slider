<!--- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

ImageIndex

This object provides useful properties and methods for the CommonSpot standard
element Image Index.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= --->

<cfcomponent accessors="true" output="true">

  <cfproperty name="instanceID" type="numeric">
  <cfproperty name="elementComponentClasses">
  <cfproperty name="photoClasses">
  <cfproperty name="titleClasses">
  <cfproperty name="descriptionClasses">
  <cfproperty name="images">

  <cfscript>

    /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    ██ ███    ██ ██ ████████
    ██ ████   ██ ██    ██
    ██ ██ ██  ██ ██    ██
    ██ ██  ██ ██ ██    ██
    ██ ██   ████ ██    ██

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

    public function init(required struct attributes) {
      instanceID = attributes.ELEMENTINFO.ID;
      elementComponentClasses = new ElementComponentClasses(attributes.ELEMENTINFO.ClassNames.Element);
      photoClasses = new ElementComponentClasses(attributes.ELEMENTINFO.ClassNames.Photo);
      titleClasses = new ElementComponentClasses(attributes.ELEMENTINFO.ClassNames.Title);
      descriptionClasses = new ElementComponentClasses(attributes.ELEMENTINFO.ClassNames.Description);
      images = new Images(attributes.ELEMENTINFO.ElementData.Items);

      // Debugging
      // WriteDump(var = elementComponentClasses, label = 'ImageIndex: elementComponentClasses');
      // WriteDump(var = photoClasses, label = 'ImageIndex: photoClasses');
      // WriteDump(var = titleClasses, label = 'ImageIndex: titleClasses');
      // WriteDump(var = descriptionClasses, label = 'ImageIndex: descriptionClasses');
      // WriteDump(var = images.toArray(), label = 'ImageIndex: images');
      // WriteDump(var = images.shortest(), label = 'ImageIndex: images: shortest');

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

  </cfscript>

</cfcomponent>
