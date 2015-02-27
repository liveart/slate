---
title: LiveArt HTML5 Documentation

language_tabs:
  - Sample JSONs

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

LiveArt HTML5 uses JSON format to transfer data, such as information about design, pricing and order, to backend. In order to prepare server-side application for work in pair with LiveArt component, backend services should be ready to receive and deliver valid data structures via HTTP queries. The detailed description of this queries and datatypes is given in the following article.

<aside class="warning">LiveArt HTML5 integration requires profound coding knowledge of GET/POST requests and JSON processing in your native platform. Regardless of the letter, we recommend constantly using Net Inspector and/or Fiddler tool to debug your requests and responses of the API.</aside>

Each request is normally sent as POST request with the payload, contained in `value` parameter. Sometimes additional parameters may include design id or timestamp. Using Inspector properly, you will be able to notice all information that is being sent.

All endpoint URLs can be both relative or absolute. For correct operation of the tool we advise using relative URLs more as you may get into CORS issue if your users will be accessing tool with a different URL than provided in main configuration file. A common example is accessing site with or without the `www`.

# API Endpoints
## GetQuote - POST
> Request example

```json
{
  "product": {
    "id": "21",
    "color": "#9cb8d0",
    "colorName": "Aero"
  },
  "locations": [{
    "name": "Front",
    "colors": 1,
    "colorsList": ["#ee6363"],
    "designedArea": 154271.6304253942,
    "designedAreaRect": 237446.57184553126,
    "objects": [{
      "type": "txt",
      "designedArea": 27038.5473910787,
      "colors": 1,
      "colorsList": ["#ee6363"]
    }],
    "objectCount": 1,
    "letterings": 1,
    "images": 1
  }],
  "quantities": [{
    "size": "S",
    "quantity": 1
  }]
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
id | unique identifier of the product. | string
color | hexadecimal value of product color. | string
colorName | name of product color. | string
name | name of product location | string
colors | amount of the colors which are used at the current location | number
colorsList | list of hexadecimal values of the colors which are used at the current location. | array
designedArea | total area of all decoration objects at the current location (square units). | number
designedAreaRect | area of rectangle, containing all objects in location (square units). | number
objectCount | total count of all decoration objects at the current location. | number
letterings | total count of all text objects at the current location. | number
images | total count of all graphic objects at the current location. | number
objects | list of decoration objects which are present at the current location. | array
type | type of decoration object. | string, possible values: "txt", "svg" and "image"
designedArea | area occupied by the object (in square units). | number
colors | amount of colors used to colorize the object. | number
colorsList | list of RGB colors used to colorize the object. | array
size | name of the product size. | string
quantity | quantity of the size. | number

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

### SERVICE DEFINITION IN CONFIG.JSON
`"saveDesignUrl": "services/saveDesign.php"`

### REQUEST FIELDS DESCRIPTION
Request contains JSON metadata with enclosed SVG which should be extracted with the parsing script and saved. Developers can additionally process SVG to embed images, prepare for conversion into other formats or add additional elements.

Field | Description | Type
----- | ----------- | ----
product.id | unique identifier of the product. | string
product.name | name of product. | string
locations | list of product locations (sides) for each printable side | array
location.name | name of location. | string
location.svg | XML representation of an SVG image which contains the whole design (including product background). | string
quantities | list of selected sizes and their quantities. | array
size | name of the product size. | string
quantity | quantity of the size. | number
prices | list of objects which are related to pricing. The structure is exact to the one you compile for GetQuote service | array

### RESPONSE FIELDS DESCRIPTION
Field | Description | Type
----- | ----------- | ----
id | unique design identifier, it is your responsibility to generate it and keep it's consistency. | string
title | design title which is given by end user. In cases of placing order or sharing design it is generated automatically by LiveArt | string

## UploadImage - POST/Multipart
This service is used to upload user image from local file or URL. After uploading process image is shown on preview area and ready to be moved or resized. Allowed file extensions: *.jpg, *.png, *.gif, *.svg.

<aside class="warning">Make sure to update the rights to your accepting folder as writable for web user. LiveArt will not check this.</aside>

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

### SERVICE DEFINITION IN CONFIG.JSON
To bind LiveArt HTML5 to the server side Upload Image service, you will need to define the uploadImageUrl property in config JSON. The value has to be a link to a backend service. See example below:
`"uploadImageUrl": "services/uploadImage.php"`

## GetDesigns - GET
> Response Example

```json
{
  "designs": [
    {"id": "20130419-175034-29813", "title": "My First Design", "date": "2013.04.19 17:50"},
    {"id": "20130419-175828-96476", "title": "My Second Design", "date": "2013.04.19 17:58"}
  ]
}
```

This service is called to get the list of saved designs for certain email. The backend service should use the email from GET parameter as key to filter designs for particular account.

### SERVICE DEFINITION IN CONFIG.JSON
Please note that using the token is mandatory. It will be replaced in request with actual email, provided by the user.

`"getDesignsUrl": "services/loadDesigns.php?email=${email}"`

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

### SERVICE DEFINITION IN CONFIG.JSON
The token will automatically replaced with an associated design_id fetched either from URL `design_id` parameter or selected design from list of designs, after user clicked to load a previously saved design.
"loadDesignUrl": "services/loadDesign.php?design_id=${design_id}"

### RESPONSE DESCRIPTION
The provided response should correspond the request example from SaveDesign service.