# Package Structure
LiveArt JS (HTML5) is a Javascript application which uses allows user add text or image objects to stage and manipulate them with mouse or gestures on tablets. A number of Javascript technologies are used and part of the code is open to modifications.

Please note that a particular package which may be released to you may differ in its files or features if you have also ordered custom modifications to original software. Contact LiveArt team to obtain specific details pertaining your package.

Once unpacked, the LiveArt JS package consists of the following structure (subject to change).

`/index.html`

Main page containing the designer. This can be used as base or embedded with an iframe into your website or ecommerce application.

`/LiveArtJS.js`

The core LiveArt JS code, copyrighted and protected from unauthorised access. This particular library is locked to your website domain for protection when launched on production.

`/LA.js`

The Knockout controlling scripts for the designer page. You can edit these scripts (but not recommended to do so) to amend the logic of specific designer elements or behavior by yourself. Please note that since the code is copyrighted you cannot redistribute it withouth LiveArt consent.

`/LA.config.js`

_version: 0.10.5+<br/>_
Seperated from LA.js configuration for more easier LA.js support. Used to:

* override canvas dimension (see _/setup/README.txt_ for more details)
* default product/design/graphic parsing from GET vars
* custom place order handler
* _added in v0.10.10_ core translation dictionary (see usage manual on [KB: How to add translations to LiveArt](https://liveart.uservoice.com/knowledgebase/articles/917133-how-to-add-translations-to-liveart))

`/assets`

The folder contains Bootstrap files, required for designer running, images and additional libraries.

`/config`

Main LiveArt JS configuration files. The format of the files is JSON.

`/fonts`

The folder with fonts, which you can add to designer along with fonts.css fonts declaration file.

`/files`

_version: 0.10.27+<br/>_
Default folder for saving designs. Package contains sample design templates (global and product-related) — also called "Design Ideas".

`/gallery`

Artwork graphics gallery. Please note that graphics added here should be also referred in respective JSON configuration file.

`/lib`

Additional low-level core Javascript libraries handling designer. This folder also contains standard libraries such as Knockout and JQuery.

`/products`

Demo products images and thumbnails.

`/setup`

_version: 0.10.2+<br/>_
LiveArt setup scripts. Read _README.txt_ inside for more information.