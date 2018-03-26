# Data Structures
This section describes JSON data structures of LiveArt resources, such as products, fonts, colors, graphics and text effects.

## Products List
> Sample mini Products JSON file<br/><small>(product - not resizable, multicolor, with defined limited colors for color area)</small>

```json 
{
  "productCategoriesList": [
    {
      "id": "r1",
      "name": "Clothing",
      "thumb": "products/cool-t-shirt/thumbs/t-shirt-blue.png",
      "categories": [
        {
          "id": "1",
          "name": "Apparel",
          "thumb": "products/cool-t-shirt/thumbs/apparel_cat.jpg",
          "products": [
            {
              "id": "11",
              "categoryId": "1",
              "name": "T-shirt",
              "description": "Sample Colorizable Product with limited colors, and editable area as units values",
              "data": {
                "price": "29",
                "material": "Cotton"
              },
              "thumb": "products/cool-t-shirt/thumbs/t-shirt-blue.png",
              "namesNumbersEnabled": true,
              "multicolor": true,
              "minDPU": 150,
              "minQuantity": 1,
              "locations": [
                {
                  "name": "Front",
                  "image": "products/cool-t-shirt/t-shirt_front.svg",
                  "editableArea": [170,75,410,485],
                  "editableAreaUnits": [4.8,8.2],
                  "clipRect": [170,75,410,485]
                },
                {
                  "name": "Back",
                  "image": "products/cool-t-shirt/t-shirt_back.svg",
                  "editableArea": [170,55,410,485],
                  "editableAreaUnits": [4.8,8.6],
                  "clipRect": [170,75,410,485]
                }
              ],
              "colorizableElements": [
                {
                  "name": "Color",
                  "id": ".bg.fill",
                  "colors": [
                    {
                      "name": "White",
                      "value": "#FFF"
                    },
                    {
                      "name": "Black",
                      "value": "#000"
                    },
                    {
                      "name": "Steel Blue",
                      "value": "#4682B4"
                    }
                  ]
                }
              ],
              "sizes": ["XS","S","M","L","XL","XXL","XXXL"]
            }
          ]
        }
      ]
    }
  ]
}
```
The JSON object that is returned by this link should have the following tree-like structure. The root node of this tree is productCategoriesList — the array of category objects. See description of a category object below.

### Category
A category may be nested if necessary and thus include either child categories or products.

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
id | unique identifier of category object, used for internal needs. | string | yes
name | name of category, visible to the end user. | string | yes
thumbUrl | _deprecated in 0.10.27_ | string | no
thumb | _added in 0.10.27_<br/> path or URL of the category thumbnail | string | no
categories | a nested list of categories, if present | string | no
products | list of product objects (see description below). | array | no

### Product
Product is perhaps one of the most complex objects in LiveArt, presenting numerous options of usage that can be combined. The child objects like Locations, Colors and ColorizableElements are described later in this section.

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
categoryId | unique identifier of category to which belongs the product. | string | yes
colorizableElements | indicates list of elements of the product that can be colorized, e.g. uniform or multiple panel products. Works same as colorizableElements for artwork gallery. | structure | no
colors | list of available colors for the product. See description of color object below. If the list is not indicated, the product is considered as non-colorizable. | array of color objects | no
data | arbitrary object with additional product fields to pass to front-end, e.g. material, cost, etc. | object | no
description | description of product, visible to the end user. | string | no
hideEditableAreaBord​er | If true, the printable area border is not rendered. | boolean | no
id | unique identifier of product object, used for internal needs. | string | yes
locations | list of available locations for the products (for example, front, back and so forth). See description of location object below. | array | yes
minDPU | overrides general config property for certain product. Refer to config option description for more information | number | no
minQuantity | set the minimal order quantity for current product. Default value is 1. If total quantity is less — Order button is blocked with informational tooltip. | number | no
multicolor | whether product can be colorizable. This requires special SVG image of product to be prepared in a same way as multicolor artwork and colorizableElements to be indicated | boolean | no
name | name of product, visible to the end user. | string | yes
namesNumbersEnabled | enable tab for adding names and/or numbers placeholders to design, and fill appropriate table | boolean | false
pantones | _added in v0.10.14_<br/> object to override default pantones setting from config.<br/>Sample: ```{ "useForDecoration": false, "useForProduct": false }```<br/>(```useForDecoration``` — enabling/disabling pantones for the art, ```useForProduct``` — enabling/disabling pantones for colorizing ```multicolor``` product )| object | false
resizable | defines whether the product dimensions can be changed by user. Setting this to true is typical for products like business cards, signs or banners.<br/>Available in 2 modes: <ul><li>User input mode (see details below)</li><li>Predefined values - see option `editableAreaSizes` description </li></ul> User input mode has some peculiar properties:<ul><li>`editableAreaUnits` — is an optional location attribute, but for resizable products becomes required;</li><li>default size will be taken from `editableAreaUnits`;</li><li>one may additionally setup default product size via `defaultProductSize` attribute in main configuration file;</li><li>all product location should have same size;</li><li>if resizable product has more than one `location` object, `editableAreaUnits` are required only for first location in list; other loation's editableAreaUnits will be ignored.</li></ul> | boolean | no
editableAreaSizes | defines preselected possible sizes for user, works only if resizable attribute is ```true```.<br/>Sample definition: `"editableAreaSizes":[{"label":"2x2in", "width":2, "height":2}]`<br/>_Note_: this option ignores `editableAreaUnits`, `editableAreaUnitsRan​ge`, and `editableAreaUnitsRestrictRotation` options in `product.location`  | object | no
showRuler | indicates whether ruler should be shown. Depends on ```editableAreaUnits``` values for each location (becomes obligatory attribute).<br/>Default value: ```false```. | boolean | no
sizes | list of available sizes for certain product. Type: array. If not indicated, only Quantity field will be rendered on the checkout panel. | array | no
template | _deprecated in v0.10.30_<br/>  See migration guide in [Product Templates KB article](https://liveart.uservoice.com/knowledgebase/articles/1814230#migration_notes). | string | no
thumbUrl | _deprecated in v0.10.27_<br/>Use ```thumb``` instead. | string | no
thumb | _added in 0.10.27_<br/> URL to thumbnail image (allowed file extensions: *.jpg, *.png, *.gif, *.svg, dimensions: 110px x 110px) which will be shown in the products catalog. | string | yes
defaultTemplateId  | _added in v0.10.30_<br/>  ID of the template to be loaded by default | string | no

### Location
JSON representation of product location which contains the following properties:

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
name | name of location, visible to the end user. | string | yes
image | url to background image (allowed file extensions: *.jpg, *.png, *.gif, *.svg) of the product for the current location. | string | yes
mask | url to the mask image, that will be applied to the product background image. If config option includeMaskInDesign is true — included into output design svg file. | string | no
overlayInfo | url to the image with additional location graphical markup (safe, trim, print areas, additional comments). This image is not included into svg design output. | string | no
editableArea | list of 4 number that represent coordinates of top left (first two numbers) and bottom right points (last two). On design is rendered as rectangle; if config option includePrintingAreaInDesign is true, editable area is included into output design svg file. Default values: canvas width and height. | array | no
editableAreaUnits | list of 2 number that represent width and height of editable area in real-life units, e.g. millimeters or inches. NOTE: Is required for product with `"resizable": true` attribute. If such product has more than one location, editableAreaUnits of not first location are ignored. | array/numbers | no
editableAreaUnitsRan​ge | this sets min/max ranges and steps for dimensions of resizable product. Example:`"editableAreaUnitsRan​ge": [[5, 150, 1],[5, 100, 1]]`, where [min, max, step (optional, default = 1)]. Note: By default max value is used for longer side, not width only | array | no
editableAreaUnitsRestrictRotation | If `true` set product max width value from first array and height — value from second array respectively from `editableAreaUnitsRan​ge`. Default value: false | boolean | no
clipRect | list of 2 coordinates for top left and bottom right corners of clipped area. It is very handy to copy these from editableArea if the design should be cropped at the sides of editableArea. | array | no

<aside class="notice">
Please pay attention that all coordinates or measurements should be numbers, not strings.
</aside>

### Color
JSON representation of product color which contains the following properties:

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
name | name of color, visible to the end user. | string | yes
value | hexadecimal value of color. | string | yes
location | list of locations for which this color is available. Used only for products with `"multicolor": false` attribute<br/><br/>Each object in `location` array consist of properties: | array | no

   | | |  |  | 
---| ---|--------- | ----------- | ---- | --------
   |name | name of `location` for which current color is available.<br/><small>If name is invalid — image will be used for product location with the same index</small> | string | yes
   |image | url to background image (allowed file extensions: *.jpg, *.png, *.gif, *.svg) for current location and color | string | yes
   |mask | _optional_ url to mask image (allowed file extensions: *.jpg, *.png, *.gif, *.svg) for current location and color | string | no

## Fonts List
> Fonts JSON structure example

```json
{
    "fonts": [
        { "name": "Action", "fontFamily": "Action Man", "ascent": 22, "vector": "fonts/Action-Man/Action_Man.font.js" },
        { "name": "Arial", "fontFamily": "Arial", "ascent": 23, "vector": "fonts/Arial/Arial.font.js" },
		{ "name": "Bebas Neue", "fontFamily": "Bebas Neue", "ascent": 23, "boldAllowed": false, "italicAllowed": false, "vector": "fonts/Bebas-Neue/Bebas_Neue.font.js"},      
        { "name": "Capture It", "fontFamily": "Capture it", "ascent": 23, "boldAllowed": false, "italicAllowed": false, "vector": "fonts/Capture-It/Capture_It.font.js"},
    ]
}
```

The JSON object that is returned by fonts service should have main `fonts` node with the following properties:

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
name | name of font, visible to the end user. The name will be automatically written with the font. | string | yes
fontFamily | name of typeface that is used by this font. | string | yes
ascent | should be indicated, as height in pixels for 32pt font size. This parameter is essential for calculating correct measurements in resizable products and size-sensitive price calculations. Normal values are 22-29. | number | no
boldAllowed, italicAllowed | if false, disables respective control. Usable if font does not have bold or italic typefaces. | boolean | no
vector | vector representation of the font glyphs for vector text effects. Can be obtained by running the font through http://cufon.shoqolate.com/generate/ tool. | path,URL | no

## Colors List
> Colors JSON example

```json
{
  "colors": [
      { "name": "Black", "value": "#000000" },
      { "name": "Dim Gray", "value": "#696969" },
      { "name": "Gray", "value": "#808080" },
      { "name": "Silver", "value": "#C0C0C0" },
      { "name": "White", "value": "#FFFFFF" }
	]
}
```

The JSON object that is returned by this link should have the following properties:

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
name | name of color, visible to the end user. | string | yes
value | hexadecimal value of color. | string | yes

## Graphics List
> Graphics JSON example

```json
{
  "graphicsCategoriesList": [{
      "id": "r1",
      "name": "Animals",
      "thumb": "gallery/raster/thumbs/crab.png",
      "categories": [{
          "id": "1",
          "name": "Raster",
		  "thumb": "gallery/raster/thumbs/crab.png",
          "graphicsList": [{
              "id": "11",
              "categoryId": "1",
              "name": "Crab",
              "description": "crab",
              "colors": "-1",
              "thumb": "gallery/raster/thumbs/crab.png",
              "image": "gallery/raster/crab.png"
          }]
        }, {
          "id": "4",
          "name": "Multicolor",
          "thumb": "gallery/Icons/multicolor/png/butterfly.png",
          "graphicsList": [{
              "id": "42",
              "categoryId": "4",
              "name": "Lion",
              "description": "lion",
              "multicolor": true,
              "thumb": "gallery/Icons/multicolor/png/lion.png",
              "image": "gallery/Icons/multicolor/svg/lion.svg",
              "colorizableElements": [{
                  "name": "Muzzle",
                  "id": ".muzzle.fill",
                  "colors": [
                    { "name": "Yellow", "value": "#F4EB21" },
                    { "name": "Green", "value": "#69F946" }
                  ]
                },
                {
                  "name": "Mane",
                  "id": ".mane.fill",
                  "colors": [
                    { "name": "Orange", "value": "#FAA744" },
                    { "name": "Dark Red", "value": "#600308" }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

The JSON object that is returned by this link should have the following tree-like structure. The root node of this tree is `graphicsCategoriesList` — the array of root graphic category objects. Each category has its categories list or graphics list, represented by Graphic Object.

### Graphic Object
The artwork can be in the following web formats: JPG, GIF, PNG or SVG. For best vector representation we recommend using SVG format. You can easily export your vector grahics into SVG from Adobe Illustrator or CorelDraw.

JSON representation of graphics, contains the following properties:

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
id | unique identifier of product object, used for internal needs. | string | yes
categoryId | unique identifier of category to which belongs the image. | string | yes
colors | number of colors, present in the image. This will be used for correct get quote request if decoration price depends on number of colors (e.g. screenprinting). Type: string or array of strings. Possible values: <ul><li> `"-1"` — process colors is required, e.g. if the graphic is photo; </li><li> `"0"` — default value (need graphic to be `"colorize": true` and get colors information from selected fill color/outline/multicolor layers); </li><li> integer (e.g. `"5"`) — number of unique graphic colors;</li><li> array of hex web colors (e.g. `["#FFFFFF", "#000000"]`) — list of colors for accurate counting <br/>(in case of `"multicolor" : true` - added to colors list)</li></ul> | mixed<br/>(string, array of strings) | no
colorize | acceptable values: true, false. This optional attribute tells designer whether the image can be colorized by user. Please note that this option works with SVG images only. Default value: false. | boolean | no
colorizableElements | list of colorizable layers inside the SVG image. Please look for applicable samples of such SVG images inside your development package. | array/objects | no
description | short description of the image, visible to the end user. | string | no
multicolor | acceptable values: true, false. Optional attribute for indicating whether artwork can be colorized in multiple layers. Works in conjunction with colorizableElements attribute and mutually exclusive with colorize. Default value: false. | boolean | no
thumb | url to thumbnail image (allowed file extensions: *.jpg, *.png, *.gif, *.svg, dimensions: 110px x 110px) which will be shown in the graphics catalog. | string | no
image | url to the full size image (allowed file extensions: *.jpg, *.png, *.gif, *.svg) which will be shown at the preview area. | string | yes

## Text Effects List
> Example

```json
{
  "textEffects": [
    { "name": "curveUp", "label": "Curve Up", "fxName": "arc", "paramName": "Angle", "paramValName": "a", "min": 10, "max": 360, "step": 5},
    { "name": "curveDown", "label": "Curve Down", "fxName": "arc", "paramName": "Angle", "paramValName": "a", "min": -10, "max": -360, "step": 5},
    { "name": "archUp", "label": "Arch Up", "fxName": "vectorArchUp", "paramName": "Angle", "paramValName": "a", "min": 0, "max": 1, "step": 0.1},
    { "name": "archDown", "label": "Arch Down", "fxName": "vectorArchDown", "paramName": "Angle", "paramValName": "a", "min": 0, "max": 1, "step": 0.1},
    { "name": "simpleWave", "label": "Simple Wave", "paramName": "Wave", "paramValName": "d", "min": 0.1, "max": 1, "step": 0.1},
    { "name": "widen", "label": "Widen", "paramName": "Distort Level", "paramValName": "d", "min": 0, "max": 1, "step": 0.1},
    { "name": "wedge", "label": "Wedge", "paramName": "Distort Level", "paramValName": "d", "min": 1, "max": 2, "step": 0.1},
    { "name": "pinch", "label": "Pinch", "paramName": "Pinch Level", "paramValName": "d", "min": 0, "max": 1, "step": 0.1},
    { "name": "bulge", "label": "Bulge", "paramName": "Bulge Level", "paramValName": "d", "min": 1, "max": 2, "step": 0.1},
    { "name": "slantLeft", "label": "Slant Left", "paramName": "Slant Level", "paramValName": "d", "min": 0, "max": 1, "step": 0.1},
    { "name": "slantRight", "label": "Slant Right", "paramName": "Slant Level", "paramValName": "d", "min": 1, "max": 2, "step": 0.1},
    { "name": "slantUp", "label": "Slant Up", "paramName": "Slant Level", "paramValName": "d", "min": 1, "max": 2, "step": 0.1},
    { "name": "slantDown", "label": "Slant Down", "paramName": "Slant Level", "paramValName": "d", "min": 0, "max": 1, "step": 0.1}
  ]
}

```

Text FX is an experimental flexible feature that was added to LiveArt HTML5 allowing users to apply a number of effects on the text. Default effects are vector and not require ImageMagick (_starting 0.10.24_). 

<aside class="warning">
0.10.24 update:

Raster Effects are deprecated. To enable them back please refer to changelog (e.g. <a href="https://github.com/liveart/liveartjs/blob/master/README.md#01024-release-notes">README</a> or <a href="https://liveart.uservoice.com/knowledgebase/articles/1188664">Migration Text Effects to 0.10.25 Notes</a>)
Please note that the default script requires ImageMagick and all fonts to be installed on your server. Also this works in conjunction with getText.php script and any effect you add should be implemented in it.
</aside>

Attribute | Description | Type | Required
--------- | ----------- | ---- | --------
name | unique identifier of the effect | string | yes
label | label for the effect as it will appear to the user. | string | no
fxName(optional) | working name of the effect if different to name or label. Is used in the script | string | no
paramName | title of the effect parameter as it will appear for user, e.g. "Distort", "Angle" | string | yes
paramValName | working name of the effect parameter, used if different to paramName. | string | yes
min/max | numeric values for respective min and max of the effect parameter. The parameter will be rendered to user as slider control. | number | yes
step | numeric step value for effect parameter control. | number | yes

Effects List:

- Vector effects:
  - Curve Up/Down
  - Arch Up/Down (_added in 0.10.25_)
  - Wave
  - Widen/Wedge (_added in 0.10.25_)
  - Pinch/Bulge (_added in 0.10.25_)
  - Slant Left/Right/Up/Down (_added in 0.10.25_)
- Raster effects (_deprecated in 0.10.24_)
  - Arch Up/Down
  - Inflate
  - Perspective
  - Wave 