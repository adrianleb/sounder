Template.controls.events
  'click #url' : ->
    newAudio = new Audio()
    newAudio.src = $('#urlfield').val()
    # newAudio.id = $('#urlfield').val()
    _.delay (=>
      $(sounder).trigger 'newTrack', newAudio
      $(sounder.player).trigger 'playLast'
      ), 20
    # console.log newAudio
    # $('#source')[0].src = $('#urlfield').val()
    # Sounder.player $('#play')[0], $('#source')[0]

  'click .play' : (e) -> 
    e.preventDefault()
    console.log $(e.currentTarget).data 'index'
    $(sounder.player).trigger 'playIndex', $(e.currentTarget).data 'index'
    # Sounder.player e.currentTarget, $('audio')[0]


  'click #play2' : (e) ->
    $(sounder.player).trigger 'playIndex', 1

  'click .shaders a' : (e) ->
    $(Renderer).trigger 'changeShader', $(e.currentTarget).data 'shader'

  'click #controlsOpener' : (e) ->
    e.preventDefault()
    $('#controlsWrap').toggleClass 'open'
  'click #inputOpener' : (e) ->
    e.preventDefault()
    $('#inputWrap').toggleClass 'open'
