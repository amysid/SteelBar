$(document).on('ready turbolinks:load',function(){  
  $("#session_create").validate({
  errorPlacement: function (error, element) {
    error.insertAfter(element.next());
  },
    rules: {
      "user[email]":{
        required: true,
        minlength: 6,
        maxlength: 32,
        email: true
        // emailRegex: true

      },
      "user[password]":{
        required: true,
        minlength: 8,
        maxlength: 16
      }
   }
  });

  $("#req_password").validate({
  errorPlacement: function (error, element) {
    error.insertAfter(element.next());
  },
    rules: {
      "user[email]":{
        required: true,
        email: true
        // emailRegex: true
      }
   }
  });
});
