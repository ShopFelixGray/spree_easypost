 // Scan Form AJAX API
 $(document).ready(function () {
  'use strict'; 
  // handle buy scan form create click
  $('#submitScanForm').on('click', function () {
    var stock_location_id = $('#stockLocation').val();
    var url = Spree.url(Spree.routes.scan_form);
    $.ajax({
      type: 'POST',
      url: url,
      data: {
        token: Spree.api_key,
        stock_location_id: stock_location_id
      }
    }).done(function (data) {
      window.open(data.responseJSON.scan_form);
    }).error(function (err) {
      window.alert(err.responseJSON.error.message);
    });
  });
});