ready = ->

  intervalID = null
  id = $('.process').text()
  return if isNaN(parseInt(id))

  url = '/admin/categories/' + id + '/status'

  processResponse = (response) ->
    $('#' + id + '_rows_count').text(response.rows)
    $('#' + id + '_status').text(capitalize(response.status))

    if response.status == 'success'
      clearInterval(intervalID)
      $('#' + id + '_status').css('background-color', 'rgb(205, 238, 205)')

  capitalize = (string) ->
      string.charAt(0).toUpperCase() + string.substring(1).toLowerCase();

  executeStautsRequest = ->
    $.get(url, {}, (response)->
      processResponse(response)
    , "json")

  intervalID = setInterval(executeStautsRequest, 1000)

  return null

$(document).ready(ready)



