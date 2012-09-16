class Player


  initEvents: (el) ->
    $(@).on 'newAudio', (e, el) =>
      console.log 'new source', el
      @audioPlayers.push el
      @renderPlaylist()

    $(@).on 'playLast', (e) => @playLast()
    $(@).on 'playIndex', (e, index) => 
      if @currentTrack is index and @isPlaying
        @pauseCurrent()
      else
        @currentTrack = index
        @playIndex


  constructor: ->
    @audioPlayers = []
    @currentPlaying = null
    @isPlaying = false
    @currentTrack = 0
    console.log @
    @initEvents()
    @

  renderPlaylist: ->
    $('#playlist').html ''
    for player in @audioPlayers
      do (player) =>
        index = @audioPlayers.indexOf player
        tmpl = "<a class='play' data-index='#{index}' href='#'>track-#{index}</a>"
        $('#playlist').append tmpl

  pauseCurrent: ->
    current = _.filter @audioPlayers, (a) ->
      a.paused is false
    # current = @audioPlayers[@currentTrack]
    for audio in current
      do (audio) ->
        audio.pause()
    $(Renderer).trigger 'pause'

    @isPlaying = false


  playLast: ->
    if @isPlaying
      @pauseCurrent()
    last = @audioPlayers[@audioPlayers.length - 1]
    last.play()
    $(Renderer).trigger 'start'
    @isPlaying = true

  playIndex: () ->
    console.log @audioPlayers
    console.log @currentTrack
    if @isPlaying
      @pauseCurrent()
    last = @audioPlayers[@currentTrack]
    last.play()
    $(Renderer).trigger 'start'
    @isPlaying = true
