module.exports="<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <title>H5F Test Suite</title>\r\n  <!-- Load local QUnit (grunt requires v1.0.0 or newer). -->\r\n  <link rel=\"stylesheet\" href=\"../libs/qunit/qunit.css\" media=\"screen\">\r\n  <script src=\"../src/H5F.js\"></script>\r\n  \r\n</head>\r\n<body>\r\n  <h1 id=\"qunit-header\">H5F Test Suite</h1>\r\n  <h2 id=\"qunit-banner\"></h2>\r\n  <div id=\"qunit-testrunner-toolbar\"></div>\r\n  <h2 id=\"qunit-userAgent\"></h2>\r\n  <ol id=\"qunit-tests\"></ol>\r\n  <form id=\"qunit-fixture\">\r\n    <fieldset>\r\n      <legend>Your details</legend>\r\n      \r\n      <ol>\r\n        <li>\r\n          <label for=\"fullname\">Name *</label> \r\n          <input type=\"text\" id=\"fullname\" name=\"fullname\" placeholder=\"Full name\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"email\">Email *</label> \r\n          <input type=\"email\" id=\"email\" name=\"email\" placeholder=\"e.g. ryan@example.net\" title=\"Please enter a valid email\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"url\">Website *</label> \r\n          <input type=\"url\" id=\"url\" name=\"url\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"tel\">Phone *</label> \r\n          <input type=\"tel\" id=\"tel\" name=\"tel\" pattern=\"\\d{10}\" placeholder=\"Please enter a ten digit phone number\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"date\">Date *</label> \r\n          <input type=\"date\" id=\"date\" name=\"date\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"nickname\">Nick name</label> \r\n          <input type=\"text\" id=\"nickname\" name=\"nickname\" pattern=\"\\w{4,}\" placeholder=\"A nickname that is atleast four characters\" />\r\n        </li>\r\n        <li>\r\n          <label for=\"postcode\">Post code *</label>\r\n          <input id=\"postcode\" name=\"postcode\" type=\"number\" min=\"1001\" step=\"2\" max=\"8000\" required />\r\n        </li>\r\n        <li>\r\n          <label for=\"other\">Other</label> \r\n          <input type=\"text\" id=\"other\" name=\"other\" placeholder=\"Other information\" />\r\n        </li>\r\n        <li>\r\n          <label for=\"gen\">Generic</label> \r\n          <input type=\"text\" id=\"gen\" name=\"gen\" placeholder=\"Other information\" />\r\n        </li>\r\n        <li>\r\n          <label for=\"gen\">Checkbox</label> \r\n          <input type=\"checkbox\" required id=\"chkbox\" name=\"chkbox\" />\r\n        </li>\r\n      </ol>\r\n    </fieldset>\r\n  </form>\r\n  <script type=\"text/javascript\">\r\n    H5F.setup(document.getElementById(\"qunit-fixture\"));\r\n  </script>\r\n  <script src=\"../libs/qunit/qunit.js\"></script>\r\n  <script src=\"../libs/qunit/qunit-tap.js\"></script>\r\n  <script type=\"text/javascript\">\r\n    qunitTap(QUnit, function() { console.log.apply(console, arguments); });\r\n  </script>\r\n  <script src=\"H5F_test.js\"></script>\r\n</body>\r\n</html>\r\n";
