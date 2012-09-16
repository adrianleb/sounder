window.Sounder =

  loaded: false
  source: undefined
  audio: undefined
  # audioSources: []

  init: ->
    @initEvents()
    @context = new window.webkitAudioContext()
    @analyser = @context.createAnalyser()
    @freqByteData = new Uint8Array(@analyser.frequencyBinCount)
    @_plug @analyser, @context.destination
    console.log 'welcome to ', @context, @analyser


  initEvents: ->
    $(@).on 'newTrack', (e, track) => @plugOne track
    
  plugMany: ->
    for plug in $('audio')
      do (plug) =>
        $(Player).trigger 'newAudio', plug
        source = @context.createMediaElementSource(plug)
        source.connect @analyser
        # @audioSources.push source

    # @audioSources

  plugOne: (el)->
    $(Player).trigger 'newAudio', el
    source = @context.createMediaElementSource(el)
    source.connect @analyser
    # @audioSources.push source

  _plug: (input, output) ->
    input.connect output



