// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(document).ready(function() {limitTextBox("#message", "#charCount", 140);});

function limitTextBox(box, charsDisplay, charactersAllowed) {
    var $box = $(box), $charsDisplay = $(charsDisplay);
    $charsDisplay.html(charactersAllowed - ($box.val().length));
    change_color();

    function change_color() {
        if($box.val().length > charactersAllowed) {
            document.getElementById("charCount").style.color="red";
            document.getElementById("tooPost").disabled=true;
        }
        else{
            document.getElementById("charCount").style.color="#333333";
            document.getElementById("tooPost").disabled=false;
        }
    }

    $box.on('input propertychange dragdrop', function(event) {
        $charsDisplay.html(charactersAllowed - ($box.val().length));
        change_color()

    });

}
