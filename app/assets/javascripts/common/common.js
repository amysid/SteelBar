//= require jquery
//= require rails-ujs
//= require jquery-ui
//= require ckeditor/init
//= require ckeditor/ckeditor.js
//= require activestorage
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require turbolinks

function readURL1(input) {
    var img_id = get_img_tag_id();
    // debugger;
    var ext = $(input).val().split('.').pop().toLowerCase();
    // console.log(input.files[0].size / 1024);
    var jpg_check = ext.indexOf("jpg");
    var jpeg_check = ext.indexOf("jpeg");
    var png_check = ext.indexOf("png");

    if (input.files && input.files[0]) {
        if (jpg_check === 0 || jpeg_check === 0 || png_check === 0) {
            if ((input.files[0].size / 1024) > (1024 * 3)) {
                console.log("333333file size checking")
                // debugger;
                $(input).val('');
                alertify.alert('Invalid size, Please choose image below 3 Mb!').setHeader("");
            } else {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $(img_id).attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        } else {
            alertify.alert("Invalid format! Only jpeg, jpg, png").setHeader("");
            $(input).val('');
        }
    }
};

var unique_id = 0;
var img_tag_id = "";

function get_uid() {
    return unique_id++;
};

function set_img_tag_id(obj) {
    img_tag_id = obj.id;
};

function get_img_tag_id() {
    return "#" + img_tag_id;
};

function date_picker(){
    $.fn.datepicker.defaults.format = "yyyy/mm/dd";
    $.fn.datepicker.defaults.todayHighlight = true;
    $.fn.datepicker.defaults.todayBtn = true;
    $(".datetimepicker_start").on("changeDate", function(e) {
        $('.datetimepicker_end').datepicker('setStartDate', e.date);
    });
    $(".datetimepicker_end").on("changeDate", function(e) {
        $('.datetimepicker_start').datepicker('setEndDate', e.date);
    });
}

$(document).on('turbolinks:load',function() {
    // For Date Piker
    date_picker();
    // $.fn.datepicker.defaults.startDate = '0d'
    // End of date picker

    $(".alert").fadeOut(5000);
    $("div .alert").hover(
        function() {
            $(this).stop();
            $(this).fadeIn();
            $(this).fadeOut(2500);
        },
        function() {
            $(this).stop();
            $(this).fadeIn();
            $(this).fadeOut(2500);
        }
    );
});