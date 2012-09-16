Template.hello.events
  'click #url' : ->
    newAudio = new Audio()
    newAudio.src = $('#urlfield').val()
    # newAudio.id = $('#urlfield').val()
    _.delay (=>
      $(Sounder).trigger 'newTrack', newAudio
      $(Player).trigger 'playLast'
      ), 20

    # console.log newAudio
    # $('#source')[0].src = $('#urlfield').val()
    # Sounder.player $('#play')[0], $('#source')[0]

  'click .play' : (e) -> 
    e.preventDefault()
    console.log $(e.currentTarget).data 'index'
    $(Player).trigger 'playIndex', $(e.currentTarget).data 'index'
    # Sounder.player e.currentTarget, $('audio')[0]


  'click #play2' : (e) ->
    $(Player).trigger 'playIndex', 1

  'click .shaders a' : (e) ->
    $(Renderer).trigger 'changeShader', $(e.currentTarget).data 'shader'

  'click #playlistOpener' : (e) ->
    e.preventDefault()
    $('#playlistWrap').toggleClass 'open'
