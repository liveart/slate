---
title: LiveArt HTML5 Documentation

language_tabs:
  - Sample code

toc_footers:
  - <a href='http://liveart.uservoice.com/' target='_blank'>Uservoice Portal</a>
  - <a href='https://extranet.newtonideas.com/open.aspx/NI/LAJS/SUBMIT/HDTICKET' target='_blank'>Report a bug</a>
  - <a href='http://www.developflash.com/Blog' target='_blank'>LiveArt Blog</a>

includes:
  - configuration
  - data
  - structure
  - errors

search: true
---
# Introduction

###Current version: 0.10.28

LiveArt HTML5 uses JSON format to transfer data, such as information about design, pricing and order, to backend. In order to prepare server-side application for work in pair with LiveArt component, backend services should be ready to receive and deliver valid data structures via HTTP queries. The detailed description of this queries and datatypes is given in the following article.

<aside class="warning">LiveArt HTML5 integration requires profound coding knowledge of GET/POST requests and JSON processing in your native platform. Regardless of the letter, we recommend constantly using Net Inspector and/or Fiddler tool to debug your requests and responses of the API.</aside>

Each request is normally sent as POST request with the payload, contained in `value` parameter. Sometimes additional parameters may include design id or timestamp. Using Inspector properly, you will be able to notice all information that is being sent.

All endpoint URLs can be both relative or absolute. For correct operation of the tool we advise using relative URLs more as you may get into CORS issue if your users will be accessing tool with a different URL than provided in main configuration file. A common example is accessing site with or without the `www`.

# API Endpoints
## GetQuote - POST
> Request example

```json
{
  "colors": 4,
  "isFullColor": false,
  "colorsNum": 4,
  "colorsList": [
    "#FFFFFF",
    "#000000",
    "#F4EB21",
    "#FAA744"
  ],
  "product": {
    "id": "21",
    "productColors": [
      {
        "id": ".bg.fill",
        "name": "Aero",
        "value": "#9cb8d0"
      }
    ],
    "color": "#9cb8d0",
    "colorName": "Aero",
    "size": {
      "width": 3,
      "height": 10,
      "label": "3x10in"
    }
  },
  "locations": [
    {
      "name": "Front",
      "colors": 4,
      "isFullColor": false,
      "colorsNum": 4,
      "colorsList": [
        "#FFFFFF",
        "#000000",
        "#F4EB21",
        "#FAA744"
      ],
      "objectCount": 2,
      "letterings": 1,
      "images": 1,
      "designedArea": "9",
      "designedAreaRect": "9",
      "designedWidth": "3",
      "designedHeight": "3",
      "objects": [
        {
          "type": "txt",
          "text": "text",
          "designedArea": "0.44",
          "colorsNum": 1,
          "colors": 1,
          "colorsList": [
            "#ee6363"
          ]
        },
        {
          "type": "svg",
          "id": "42",
          "isUploaded": false,
          "designedArea": "7.20",
          "colorsList": [
            "#000000",
            "#F4EB21",
            "#FAA744"
          ],
          "colorsNum": 3,
          "colors": 3,
          "isFullColor": false
        }
      ]
    }
  ],
  "namesNumbers": [
    {
      "name": "forward",
      "numberText": "07",
      "size": "L"
    },
    {
      "name": "goalkeeper",
      "numberText": "02",
      "size": "L"
    }
  ],
  "quantities": [
    {
      "size": "S",
      "quantity": 1
    },
    {
      "size": "L",
      "quantity": 2
    },
    {
      "size": "XL",
      "quantity": 0
    }
  ]
}
```

> Response example

```json
{
  "prices": [{
    "label": "Item Price",
    "price": "$ 94.62"
   }, {
    "label": "Discount",
    "price": "$ -6.00"
   }, {
    "label": "Total",
    "price": "$ 904.20",
    "isTotal": true
  }]
}
```

This service is used to get the price of a current design. It is called every time when end user is making some changes to the design or product selection.

To bind LiveArt HTML5 to the server side GetQuote service, you will need to define the getQuoteUrl property in config JSON. The value has to be a link to a backend service. See example below:

### Service definition in config.json
`"getQuoteUrl": "services/getQuote.php"`
<aside class="success">
If you need to switch off the pricing aspect of your application, simply leave `getQuoteUrl` empty!
</aside>

### Request fields description
Field | Description | Type
----- | ----------- | ----
product.id | unique identifier of the product. | string
product.productColors | _optional_: product colorizable areas list<br/>(only for multicolor products). | array of colorizable area objects
product.color | hexadecimal value of product color.<br/>_v0.10.6 change: optional_;<br/><small>Added only if product has colors. In case of multicolor product - added only if product has one colorizable area only.</small>| string
product.colorName | name of product color.<br/>_v0.10.6 change: optional_;<br/><small>Same  behaviour as product.color.</small>| string
product.size | _optional_ configured product size in units. Available only if ```product.locations.editableAreaUnits``` is defined or product has property ```resizable = true```<br/>Attributes: <ul><li>```width``` (number)</li><li>```height``` (number)</li><li>```label```(optional, string) — only if ```product.editableAreaSizes``` is defined</li></ul> | object
colorsList | legacy list of hexadecimal values of the colors which are used on all product locations (array of strings). If any of locations has full color print - "processColors" (string). | mix
colors | legacy amount of colors used on all locations (number). If any of locations has full color print - "processColors" (string).<br/>_v0.10.13 change:_ adding to amount not-specified colors from graphics config (i.e. graphic.colors = "7"); | mix
colorsNum | amount of the colors which are used on all locations<br/>_added in v0.10.13_ | number
isFullColor | bool to indicate full colors at least on one location<br/>_added in v0.10.13_ | bool
namesNumbers | list of names and numbers. Empty if current product does not support names/numbers.  | array
quantities | quantity of the sizes. Also includes entered size values from names/numbers list. | number
location.name | name of product location | string
location.isFullColor | full color print flag<br/>_added in v0.10.4_ | bool
location.colors | legacy amount of the colors which are used at the current location (number) or string "processColors" in case of full print | mixed
location.colorsNum | amount of the colors which are used at the current location<br/>_added in v0.10.4_ | number
location.colorsList | list of hexadecimal values of the colors which are used at the current location. | array of strings
location.designedArea | total area of all decoration objects at the current location (square units). <br/>_v0.10.6 change: optional_;<br/><small>Added only if location has proper design area sizes configration.</small>| string
location.designedAreaRect | area of rectangle, containing all objects in location (square units). <br/>_v0.10.6 change: optional_;<br/><small>Same  behaviour as location.designedArea.</small>| string
location.designedWidth | _v0.10.6 added_ optional attribute <br/> Width of designed area rect in units | string
location.designedHeight | _v0.10.6 added_ optional attribute <br/> Height of designed area rect in units | string
location.objectCount | total count of all decoration objects at the current location. | number
location.letterings | total count of all text objects at the current location. | number
location.images | total count of all graphic objects at the current location. | number
location.objects | list of decoration objects which are present at the current location. | array
location.objects.type | type of decoration object. Possible values: ```"txt"```, ```"svg"``` and ```"image"``` | string
location.objects.text | _optional_: only for ```type="text"``` objects - text value | string
location.objects.id | _optional_: only for gallery graphic objects - graphics id value | string
location.objects.designedArea | area occupied by the object (in square units). <br/>_v0.10.6 change: optional_;<br/><small>Same  behaviour as location.designedArea.</small>| number
location.objects.colors | legacy amount of colors used to colorize the object. See more in location.colors | mix
location.objects.colorsList | list of RGB colors used to colorize the object. | array of strings
location.objects.colorsNum | amount of colors used to colorize the object<br/>_added in v0.10.4_ | number
location.objects.isFullColor | object full color print flag<br/>_added in v0.10.4_ | bool
location.objects.isUploaded | _optional_: only for objects ```type="svg / image"```. Indicates that object was uploaded by user<br/>_added in v0.10.19_ | bool

### Response fields description
<aside class="notice">
The response should be compiled and provided as `Content-Type: application/json`, with no extra content. This is important as otherwise LiveArt may not parse your response and update prices respectively.
</aside>

The only expected node is designated as `prices`, type array each elements of which may contain the following fields.

Field | Description | Type
----- | ----------- | ----
label | title of price line, e.g. Item Price, Discount, etc. | string
price | the actual price of the price line | string
isTotal | defines whether this price line designates total and will be bolded in LiveArt | boolean, optional

## SaveDesign - POST
> Request Example

```json
{
  "data": {
    "product": {
      "id": "11",
      "name": "Cool Tee 1"
    },
    "locations": [{
      "name": "Front",
      "svg": "<svg><!-- svg content is omitted here due to its large size --></svg>"
    }, {
      "name": "Back",
      "svg": "<svg><!-- svg content is omitted here due to its large size --></svg>"
    }],
    "quantities": [{
      "size": "XS",
      "quantity": 1
    }],
    "prices": [{
      "label": "Item Price",
      "price": "$ 12.01"
    }, {
      "label": "Discount",
      "price": "$ -3.00"
    }, {
      "label": "Total",
      "price": "$ 324.30",
      "isTotal": true
    }]
  }
}
```

> Response Example

```json
{
  "design": {
    "id": "20130514-131710-50632", "title": "Lorem Ipsum"
  }
}
```

SaveDesign service is called in the following cases:

 * User is placing order;
 * User is saving design for later use using Save for Later link;
 * User is sharing design. In this case design is saved anonymously if user is not authenticated;

<br/>

###<h3>SERVICE DEFINITION IN CONFIG.JSON</h3>
`"saveDesignUrl": "services/saveDesign.php"`

###<h3>POST REQUEST FIELDS DESCRIPTION</h3>
Request fields

Field | Description | Type
----- | ----------- | ----
data | main object — see detailed description below | object
title | <i>optional:</i> title for saved design (input by user). For shared desgins - empty string. For ordered designs - not included | string
email | <i>optional:</i> only if user entered email before (e.g. for saving design) | string
type | `saved` for saved designs (including ordered) and `shared` for shared designs<br/>_added 0.10.21_: `ordered` for ordered designs (before - `saved` type was used) | string
quote | <i>optional:</i> quote objects. Only for ordered designs | object
id | <i>optional:</i> only for saved (and ordered) designs, if design was previously saved/loaded | string
design | _optional_, _added 0.10.21_: object for shorthand descrion `{title?: string, type: string (saved|shared|ordered)}`| object

<h3>DATA FIELD DESCRIPTION</h3>
Request contains JSON metadata with enclosed SVG which should be extracted with the parsing script and saved. Developers can additionally process SVG to embed images, prepare for conversion into other formats or add additional elements.

Field | Description | Type
----- | ----------- | ----
product.id | unique identifier of the product. | string
product.name | name of product. | string
product.template | based template id | string
product.productColors | _optional_: product colorizable areas list<br/>(only for multicolor products)<br/>_v0.10.14 change: always presented for  m-color products (previous: only for 1-color m-color products)_ | array of colorizable area objects
product.color | hexadecimal value of product color.<br/>_v0.10.14 change: also used for m-color products(1st color)_ | string
product.colorName | name of product color.<br/>_v0.10.14 change:  also used for m-color products(1st color)_ | string
product.size | _optional_ configured product size in units. Available only if ```product.locations.editableAreaUnits``` is defined or product has property ```resizable = true```<br/>Attributes: <ul><li>```width``` (number)</li><li>```height``` (number)</li><li>```label```(optional, string) — only if ```product.editableAreaSizes``` is defined</li></ul> | object
locations | list of product locations (sides) for each printable side | array
location.name | name of location. | string
location.svg | XML representation of an SVG image which contains the whole design (including product background). | string
location.editableArea | location editable area;<br/>Not resizable products: same value as configured; <br/>Resizable products: actual value of resized area in coordinate system of canvas<br/>Format: ```"X1 Y1 X2 Y2"``` | string
quantities | list of selected sizes and their quantities. | array
prices | list of objects which are related to pricing. The structure is exact to the one you compile for GetQuote service | array
namesNumbers | list for team names and numbers. Actual only if ```product.namesNumbersEnabled = true```, otherwise — empty array | array of objects
notes | _added v0.10.19+_ Design notes entered by user | string

### RESPONSE FIELDS DESCRIPTION
Field | Description | Type
----- | ----------- | ----
id | unique design identifier, it is your responsibility to generate it and keep it's consistency. | string
title | design title which is given by end user. In cases of placing order or sharing design it is generated automatically by LiveArt | string

## UploadImage - POST/Multipart
> Response example

```json
{
  "url":"files\/uploads\/some_image.jpg"
}
```

> In case of error

```json
{
  "error": { "message":"Incorrect image type!" }
}
```

This service is used to upload user image from local file or URL. After uploading process image is shown on preview area and ready to be moved or resized. Allowed file extensions by default: *.jpg, *.png, *.gif, *.svg.

<aside class="warning">Make sure to update the rights to your accepting folder as writable for web user and server is ready to accept large files (e.g. photos). LiveArt will not check this.</aside>

###<h3>SERVICE DEFINITION IN CONFIG.JSON</h3>

To bind LiveArt HTML5 to the server side Upload Image service, you will need to define the ```uploadImageUrl``` property in config JSON. The value has to be a link to a backend service.<br/>
See example below:
```"uploadImageUrl": "services/uploadImage.php"```

###<h3>SERVICE FUNCTIONS</h3>

* regular file upload: **POST method (multipart/form-data)**. Variable name: ```image``` - file uploaded by user
* file upload by URL: **POST method (application/x-www-form-urlencoded)**. Variable name: ```fileurl``` - absolute file URL (entered by user or response from 3rd party API (e.g. Social Networks))<br/> Note: _v0.10.19_ changes: ```fileurl``` is encoded string (usage: ```urldecode($POST['fileurl'])```)

##<h2>GetDesigns - GET</h2>
> Response Example

```json
{
  "designs": [
    {"id": "20130419-175034-29813", "title": "My First Design", "date": "2013.04.19 17:50"},
    {"id": "20130419-175828-96476", "title": "My Second Design", "date": "2013.04.19 17:58"}
  ]
}
```

This service is called to get the list of saved designs for certain email. The backend service should use the email (and product as option) from GET parameter as key(s) to filter designs for particular account.

### <h3>SERVICE DEFINITION IN CONFIG.JSON</h3>
Tokens Description:
- `${email}` - mandatory token. It will be replaced in request with actual email, provided by the user.
- `${product_id}` (added in _0.10.24_) - optional token for filtering designs list by current product

`"getDesignsUrl": "services/loadDesigns.php?email=${email}&product_id=${product_id}"`

### RESPONSE FIELDS DESCRIPTION

Field | Description | Type
----- | ----------- | ----
id | unique design identifier, should be unique per design. | string
title | design title which is given by end user. | string
date | date when design was saved. | string

## LoadDesign - GET
This service is called to load the Design JSON of a previously saved design. The service is called in the following cases:

* To load the previously saved design for certain email;
* To preload the shared design from a previously saved link;
* To preload LiveArt with design using a `design_id` in the URL;

<br/><br/>

### SERVICE DEFINITION IN CONFIG.JSON
The token will automatically replaced with an associated design_id fetched either from URL `design_id` parameter or selected design from list of designs, after user clicked to load a previously saved design.
"loadDesignUrl": "services/loadDesign.php?design_id=${design_id}"

<br/><br/>

### RESPONSE DESCRIPTION
The provided response should correspond the request example from SaveDesign service.

## SaveTemplate - POST
> Request Example

```json
{
  "data": {
    "product": {
      "id": "11",
      "name": "Cool Tee 1"
    },
    "locations": [{
      "name": "Front",
      "svg": "<svg><!--
      svg content is omitted here due to its large size
      --></svg>"
    }, {
      "name": "Back",
      "svg": "<svg><!--
      svg content is omitted here due to its large size
      --></svg>"
    }],
    "quantities": [{
      "size": "XS",
      "quantity": 1
    }],
    "prices": [{
      "label": "Item Price",
      "price": "$ 12.01"
    }, {
      "label": "Total",
      "price": "$ 324.30",
      "isTotal": true
    }]
  },
  "name": "Simple Template",
  "type": "template",
  "productId": "11"
}
```

> Response Example

```json
{
  "template": {
    "id": "template-20171020-120454-10506",
    "name": "Simple Template"
  }
}
```

SaveTemplate service is added in `version: 0.10.27`. Called to save or update <i>temaplates</i> / <i>design ideas</i>.

<br/>

###<h3>SERVICE DEFINITION IN CONFIG.JSON</h3>
`"saveTemplateUrl": "services/saveTemplate.php"`

###<h3>POST REQUEST FIELDS DESCRIPTION</h3>
Request fields

Field | Description | Type
----- | ----------- | ----
data | main object — see detailed description in `SaveDesign - POST` data field description  | object
name | title for saved template (input by user) | string
type | `template` for design which is set upped by admin. Objects in such design can contains additional restrictions. If product contains at least one template - template is opened instead of clear product. <br/> `design idea` for design which has no product, can be added to products which have no templates <br/> | string
productId | <i>optional:</i> for `template` type only | string

### RESPONSE FIELDS DESCRIPTION
Field | Description | Type
----- | ----------- | ----
id | unique design identifier, should be unique per template. | string
name | template title | string

##GetTemplates - GET
> Response Example

```json
{
  "templatesCategoriesList": [
    {
      "id": "hipster",
      "name": "Hipster Logos",
      "thumb": "files/template-id/design_preview.png",
      "templatesList": [
        {
          "id": "template-20170928-152458-17800",
          "type": "design idea",
          "date": "2017.09.28 15:24",
          "thumb": "files/template-id/design_preview.png",
          "name": "Thinking"
        }
      ],
      "categories": []
    },
    {
      "id": "simple",
      "name": "Simple",
      "thumb": "files/template-id/design_preview.png",
      "templatesList": [
        {
          "id": "template-20170921-141139-10609",
          "type": "design idea",
          "date": "2017.09.21 14:11",
          "thumb": "files/template-id/design_preview.png",
          "name": "LiveArt"
        }
      ],
      "categories": []
    }
  ]
}
```
GetTemplates service is added in `version: 0.10.27`. Called to get list of <i>templates or design ideas</i>. Response structure similar to graphics or products list.

### <h3>SERVICE DEFINITION IN CONFIG.JSON</h3>
`"getTemplatesUrl": "services/getTemplates.php?product_id=${product_id}"`

Tokens Description:
- `${product_id}` - </br> If `product_id` is empty - service should return complex art design ideas </br> if `product_id` is not empty - service should return templates for provided product.


### REQUEST FIELDS DESCRIPTION

Field | Description | Type
----- | ----------- | ----
product_id | <i>optional:</i> will be provided as replaced ${product_id} token in getTemplatesUrl | string

### RESPONSE FIELDS DESCRIPTION
Field | Description | Type
----- | ----------- | ----
id | unique template/template category identifier, should be unique. | string
name | template/template category title | string
type | `template` for design which is set upped by admin. Objects in such design can contains additional restrictions. If product contains at least one template - template is opened instead of clear product. <br/> `design idea` for design which has no product, can be added to products which have no templates <br/> | string
date | create/update date | string
thumb | url to thumbnail image (allowed file extensions: *.jpg, *.png, *.gif, *.svg, dimensions: 110px x 110px) which will be shown in the templates catalog. | string
productId | <i>optional:</i> for type `template` only | string
categories | <i>optional:</i> can not exists with templatesList on the same level | array/objects
