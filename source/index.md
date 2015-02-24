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

### Response field description
<aside class="notice">
The response should be compiled and provided as `Content-Type: application/json`, with no extra content. This is important as otherwise LiveArt may not parse your response and update prices respectively.
</aside>

The only expected node is designated as `prices`, type array each elements of which may contain the following fields.

Field | Description | Type
----- | ----------- | ----
label | title of price line, e.g. Item Price, Discount, etc. | string
price | the actual price of the price line | string
isTotal | defines whether this price line designates total and will be bolded in LiveArt | boolean, optional