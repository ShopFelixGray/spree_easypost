 // Shipments AJAX API
$(document).ready(function () {
    'use strict'; 
  // handle buy postage click
  $('[data-hook=admin_shipment_form] a.ship-postage').on('click', function () {
    var link = $(this);
    var shipment_number = link.data('shipment-number');
    var url = Spree.url(Spree.routes.shipments_api + '/' + shipment_number + '/buy_postage.json');
    $.ajax({
      type: 'PUT',
      url: url,
      data: {
        token: Spree.api_key
      }
    }).done(function () {
      window.location.reload();
    }).error(function (msg) {
      console.log(msg);
    });
  });

});
