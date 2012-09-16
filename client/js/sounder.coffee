class Sounder

  # audioSources: []

  init: ->
    @initEvents()
    @context = new window.webkitAudioContext()
    @analyser = @context.createAnalyser()
    @_plug @analyser, @context.destination
    console.log 'welcome to ', @context, @analyser


  constructor: ->
    @loaded = false
    @source = undefined
    @audio = undefined
    console.log @
    # @renderer = new Renderer
    @player = new Player
    @init()

  initEvents: ->
    $(@).on 'newTrack', (e, track) => @plugOne track

  plugMany: ->
    for plug in $('audio')
      do (plug) =>
        $(@player).trigger 'newAudio', plug
        source = @context.createMediaElementSource(plug)
        source.connect @analyser
        # @audioSources.push source

    # @audioSources

  plugOne: (el)->
    $(@player).trigger 'newAudio', el
    source = @context.createMediaElementSource(el)
    source.connect @analyser
    # @audioSources.push source

  _plug: (input, output) ->
    input.connect output



