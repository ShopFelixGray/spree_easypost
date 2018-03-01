// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'

//= require spree/backend/create_scan_form
//= require spree/backend/buy_postage

Spree.routes.scan_form = Spree.pathFor('api/v1/scan_form')