window.ClientSideValidations.validators.remote['postal_format'] = function(element, options) {
  if (element.val() != "" && !/^[0-9]{3}-[0-9]{4}$/i.test(element.val())) {
    return options.message;
  }
}
