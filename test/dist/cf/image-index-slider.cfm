<cfscript>

    // writeDump(var = attributes, expand = false, label = 'Element Attributes');
    // writeDump(var = attributes, expand = true, label = 'Element Attributes');
    // exit;

    request.element.isStatic = 0;

    Server.CommonSpot.udf.resources.loadResources('babel-polyfill');
    Server.CommonSpot.udf.resources.loadResources('polyfill-nodelist-foreach');
    Server.CommonSpot.udf.resources.loadResources('element-closest');
    Server.CommonSpot.udf.resources.loadResources('flickity');
    Server.CommonSpot.udf.resources.loadResources('picturefill');
    Server.CommonSpot.udf.resources.loadResources('smartphoto');
    Server.CommonSpot.udf.resources.loadResources('image-index-slider');

    ImageIndex = new lib.ImageIndex(attributes);

    // exit;

    Slider = new lib.Slider(ImageIndex);

    WriteOutput(Slider.toHTML());

</cfscript>
