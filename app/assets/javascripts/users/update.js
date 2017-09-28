//= require bootstrap-select

$(document).ready(function() {
  $('.selectpicker').selectpicker();
});

$('.update').click(function () {
  $('.selectpicker').prop('disabled', false);
});

$("#user_post_code").blur(function(){
  var postal_code = this.value;
  if(postal_code !=="" && /^[0-9]{3}-[0-9]{4}$/i.test(postal_code)) {
    $.ajax({
      method: "POST",
      url: "/postaddress",
      data: { value: postal_code},
      success: function (response) {
        if(response.address == ""){
          $("#user_address").val("");
        }else{
          $("#user_address").val(response.address);
        }
      },
      failure: function (response) {
        // $("#user_address").attr("placeholder", "Error occured while retrieving address").placeholder();
      }
    });
  }
});
