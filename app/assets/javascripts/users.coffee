$(document).on 'turbolinks:load', ->
  $('.tiptext').mouseover(->
    $(this).children('.description').show()
    return
  ).mouseout ->
    $(this).children('.description').hide()
    return
