# Configuration
> Sample configuration

```json
{
    "productsList": {
        "url": "config/products.json"
    },
    "defaultProductId": "11",
    "fonts": {
        "url": "config/fonts.json"
    },
    "colors": {
        "url": "config/colors.json",
        "pantones_url": "config/pantones.json"
    },
    "graphicsList": {
        "url": "config/graphics.json"
    },
    "social": {
        "url": "config/social.json"
    },
    "options": {
        "deleteOnDoubleClick": false,
        "includeProductInDesign": true,
        "includePrintingAreaInDesign": true,
		"includeMaskInDesign": true,
        "fontsCSSUrl": "http://yoursite.com/designer/fonts/fonts.css",
        "zoomEnabled": true,
        "minZoom": 50,
        "maxZoom": 150,
        "checkeredBackground": true,
        "unit": "in",
        "unit2": "ft",
        "unitConversionMult": 12,
        "showProductSelector": true,
        "checkTextFXThrottle": 400,
		"minDPU": 300,
        "showUploadedColorsDialog": false,
        "fitProductImage" :  false,
        "enableSnapGuides": true
    },
    "textEffects": {
        "config": "config/textEffects.json",
		"url": "services/getTextZ.php"
    },
    "defaultNameObjectText": "NAMES HERE",
    "defaultNumberObjectText": "00",
    "assetsUrl": "assets/",
    "galleryBaseUrl": "",
    "getQuoteUrl": "services/getQuote.php",
    "getDesignsUrl": "services/getDesigns.php?email=${email}",
    "saveDesignUrl": "services/saveDesign.php",
    "loadDesignUrl": "services/loadDesign.php?design_id=${design_id}",
    "redirectUrl": "services/order.php?design_id=${design_id}",
    "uploadImageUrl": "services/uploadImage.php",
    "shareLinkUrl": "index.html?design_id=${design_id}",
    "redirectWindow": "parent"
}
```

LiveArt JS uses JSON format for its main configuration file and data configuration files for resources such as products and gallery images. The primary configuration file contains all the necessary options, as well as REST-like endpoints for server-side integration.

<aside class="notice">
While the LiveArt loads configuration by default out of static JSON files, you can generate all of the below automatically. For example, for product list you might want to export it from the database of your shop. In case of static files, you can indicate a path instead of URL.
</aside>

### Properties description
Property | Description | Type
-------- | ----------- | ----
productsList | indicates a URL returning a Product JSON structure | URL
defaultProductId | id of a product should be loaded upon start of LiveArt. | string, optional
defaultProductSize | if default product is resizable, this attribute sets default size (will override editableAreaUnits from product configuration) in units, set by configuration. | array of numbers, optional
fonts | indicates a URL returning Fonts JSON structure | URL 
colors | indicates a URL returning Colors JSON structure. These are the colors for fonts and colorizable artwork | URL
colors.pantones_url | _added in v0.10.4_<br/>Colors JSON with Pantones. Available for fonts and colorizable artwork, and in color picker appears in separate tab. To disable this feature — remove the field.<br/>Note: for colorizing ```multicolor``` products refer to Product List configuration | URL
graphicsList | indicates a URL returning Gallery JSON structure. | URL
social | indicates a URL returning social networks configuration for uploading photos<br>_Added to v0.10.10_ | URL
options | contains the list of options which control visual appearance and behaviour of the designer area. See detailed description below. | object
textEffects | location for text effects configuration file and URL to service to obtain image of the text effect with certain parameters. See Data Structures section for details on using the text effects. To disable text effects completely, leave both fields empty. | URL
defaultNameObjectText, defaultNumberObjectText | a default text/number text, rendered in placeholder for Names or Numbers list respectively. | string
assetsUrl | relative or absolute URL to the assets folder. Assets folder contains necessary css, images and javascript libraries that make LiveArt HTML5 component work. | URL
galleryBaseUrl | an absolute URL to the folder where artwork gallery is located. This could be useful if you'd like the gallery to reside on different server or folder rather than default one. | URL
getQuoteUrl | a link to a backend service which gets a record with a current design and returns the information about pricing, such as a price per item, discount amount, total price and so on in JSON format. | URL
getDesignsUrl | a link to a backend service which returns the list of saved designs in JSON format. | URL
saveDesignUrl | a link to a backend service which gets the description of design in JSON format, saves it and returns its unique identifier, url, etc. | URL
loadDesignUrl | a link to a backend service which returns a single design using its unique identifier. | URL
redirectUrl | a link to a backend service which places order and redirects user to some another page, for example, shopping cart. | URL
uploadImageUrl | a link to a backend service which uploads user image from local file or URL. After uploading process image is shown on preview area and ready to be moved or resized. Allowed file extensions: *.jpg, *.png, *.gif, *.svg. | URL
shareLinkUrl | this parameter defines the template of the shared link url. Sharing a design calls a saveDesign service that should return an identifier under which design was saved. This id will be replaced in ${design_id} token and presented to user that may copy it and load the design later. | URL
redirectWindow | window target whne redirecting to ```redirectUrl```. Used for LiveArt inside the iframe. Possible values: ""(default), "parent", or "top" (same logic as links inside iframe) | string

### Options Description
Property | Description | Default
-------- | ----------- | ------
deleteOnDoubleClick | boolean value which defines whether user can remove any object from working area by simple double-click or double tap (for mobile devices). | false
includeProductInDesign | boolean value which defines whether product background image is included into output mockup of the design.<br/>**Warning**: recomended value - ```true```, othervise image will be hidden (```display="none"```), but some software (e.g. ImageMagic) will ignore this fact.<br/> Alternate way — remove manually node with ```id="productImage"``` | false
includePrintingAreaInDesign | boolean value which defines whether constraints of area available for printing are included in output mockup of design. | false
includeMaskInDesign | boolean value which defines whether product locations mask are included in output mockup of design.<br/>**Warning**: recomended value - ```true```, othervise image will be hidden (```display="none"```), but some software (e.g. ImageMagic) will ignore this fact.<br/> Alternate way — remove manually node with ```id="productMask"``` | false
fontsCSSUrl | URL to the location of fonts CSS definitions that will be available for the user. In default package URL — ```"/fonts/fonts.css"``` Used for stand-alone SVG preview (for proper text fonts rendering in browser)| ""
zoomEnabled | boolean value, defines whether zoom tool will be enabled inside designer.
minZoom, maxZoom, zoomStep (optional) | numeric values, defining min, max, and step values for the zoom control respectively, in percents. | 50, 150, 10
checkeredBackground | If enabled, shows checkered background where no product background is rendered. The asset for background is located in ```assets/img/bg-fill.png``` | true
unit, unit2, unitConversionMult | units, shown for custom sizes products. Possible values are ```"in"```, ```"ft"```, and ```12``` or ```"cm"```, ```"m"```, and ```10``` and so on. Use ```unitConversionMult``` to indicate respective multiplier for proper conversion of ```unit``` to ```unit2```. | "", "", 10
showProductSelector | possible values: ```true```/```false```. Defines whether Select Product form is shown. If ```false```, make sure you indicate the ```defaultProductId``` to preload the product. | true
checkTextFXThrottle | type: milliseconds. A delay in events for typing text, before LiveArt will trigger the server script to obtain new image for certain raster effect. | 400
minDPU | Set this property to show warning message if user will size raster image more than safe dimensions to meet suggested print quality standarts. Also this feature requires `editableArea` and `editableAreaUnits` (see Product Location Object) for each product location to use this feature (for correct unit/pixel ratio). Warning message is configured in html ('*#dpu-exceeded-popup*'). If user ignores such warning and continues design editing - on Place Order will be fired additional pop-up. Also may be re-defined for certain products (see Product Object). | 0
showUploadedColorsDialog | Defines whether to show after image upload pop-up with colors choises for uploaded image (default palette and 'Process Colors' checkbox). If value == `false` uploaded images are treated as 'Process Colors' | true
fitProductImage | If `true` — product images are fitted and centered in the canvas. Small product images are only centered. Editable Area coordinates are still binded to canvas dimensions (not product image)<br>_Added to v0.10.5_ | false
enableSnapGuides | If `true` — enabling snapping objects while dragging to another objects, editable area center or sides. Also helps to set object's rotation angle to 0°, 90°, 180°, and 270°<br>_Added to v0.10.17_  | true