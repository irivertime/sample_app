# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
limitTextBox = (box, charsDisplay, charactersAllowed) ->
  change_color = ->
    if $box.val().length > charactersAllowed
      document.getElementById("charCount").style.color = "red"
      document.getElementById("tooPost").disabled = true
    else
      document.getElementById("charCount").style.color = "#333333"
      document.getElementById("tooPost").disabled = false
  $box = $(box)
  $charsDisplay = $(charsDisplay)
  $charsDisplay.html charactersAllowed - ($box.val().length)
  change_color()
  $box.on "input propertychange dragdrop", (event) ->
    $charsDisplay.html charactersAllowed - ($box.val().length)
    change_color()

$(document).ready ->
  limitTextBox "#micropost_content", "#charCount", 140
