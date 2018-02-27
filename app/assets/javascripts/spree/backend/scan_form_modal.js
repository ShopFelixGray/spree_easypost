var scanForm = function() {
  var formModal = document.getElementById('formModal')
  var stockLocation = document.getElementById('stockLocation')
  var submit = document.getElementById('submitScanForm')
  var token = document.getElementById('api_key_token')

  if (formModal && token) {
    var makeRequest = function() {
      fetch('/api/v1/scan_form', { 
        credentials: 'same-origin',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Spree-Token': token.value
        },
        body: JSON.stringify({ stock_location_id: stockLocation.value }) 
      })
      .then(function(res) { console.log(res) })
    }


    submit.addEventListener('click', makeRequest)
  }
}

window.addEventListener('DOMContentLoaded', scanForm)