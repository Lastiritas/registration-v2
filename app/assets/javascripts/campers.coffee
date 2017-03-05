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

console.log('here')
$(document).ready(ready)
$(document).on('turbolinks:load', ready)