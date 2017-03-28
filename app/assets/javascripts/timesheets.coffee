$(document).on "turbolinks:load", ->
  $(".datetimepicker").datetimepicker(
    stepping: 1, format: "YYYY-MM-DD hh:mm A")
  $("#edit-notes-toggler").click ->
    if $("#pay-period-notes-form-wrapper").is ":hidden"
      # Toggle #pay-period-notes-form-wrapper slide down
      $("#pay-period-notes-form-wrapper").slideToggle("slow")
      # Change icon on toggler
      $("#edit-notes-toggler span").removeClass("glyphicon-triangle-bottom")
      $("#edit-notes-toggler span").addClass("glyphicon-triangle-top")
    else
      # Toggle #pay-period-notes-form-wrapper slide up
      $("#pay-period-notes-form-wrapper").slideToggle("slow")
      # Change icon on toggler
      $("#edit-notes-toggler span").removeClass("glyphicon-triangle-top")
      $("#edit-notes-toggler span").addClass("glyphicon-triangle-bottom")
    return
  return
