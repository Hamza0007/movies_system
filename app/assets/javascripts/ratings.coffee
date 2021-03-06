# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:change', ->

  $('.avg-star-rating').raty
    path: '/assets/'
    readOnly: true
    score: ->
      $(this).attr 'data-score'

  $('.star-rating').raty
    path: '/assets/'
    score: ->
      $(this).attr 'data-score'
    click: (score, evt) ->
      movie_id = $('#movie-container').data('movie')
      id = $('#movie-container').data('rating')
      if id == ''
        $.ajax
          type: 'POST'
          url: '/movies/' + movie_id + '/ratings'
          data: rating:
            score: score
          dataType: 'json'
          success: (data) ->
            $('.avg-star-rating').raty 'set', score: data.average
            $('#movie-container').data 'rating', data.id
      else
        $.ajax
          type: 'PATCH'
          url: '/movies/' + movie_id + '/ratings/' + id
          data: rating:
            score: score
          dataType: 'json'
          success: (data) ->
            $('.avg-star-rating').raty 'set', score: data.average
