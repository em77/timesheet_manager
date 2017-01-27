$(document).on "turbolinks:load", ->
  $(".datetimepicker").datetimepicker(
    stepping: 1, format: "YYYY-MM-DD hh:mm A")
  return
