# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.datepicker').pickadate({
    labelMonthSelect: 'Select a month',
    labelYearSelect: 'Select a year',
    selectYears: 20,
    selectMonths: true,
    max: true
  })

  $('.radio-inline input[type=radio]').on 'change', (event) ->
    event.preventDefault()
    console.log('yo')
    $.ajax
      url: "/sessions/#{event.currentTarget.value}.json"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        $('#table').addClass('hidden')
      success: (data, textStatus, jqXHR) ->
        $('#table').bootstrapTable('load', data.camp_sessions)
        $('#table tbody tr').removeClass('selected');
        $('.bs-checkbox input[type=checkbox]').prop('checked', false);
        $('.camp-session-selection').addClass('hidden');
        $('.dynamic-camp-session-selection').removeClass('hidden');



$(document).ready(ready)
$(document).on('turbolinks:load', ready)