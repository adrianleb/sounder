window.Renderer = 

  OFFSET: 100
  activeShader: "zoom"
  hue: 0
  hueDirection: "up"
  runRenderer: true

  init: ->
    @initEvents()

  initEvents: ->

    $(@).on 'pause', =>
      @runRenderer = false
      @hueChanger false

    $(@).on 'start', =>
      @runRenderer = true
      @render()
      @hueChanger()
    $(@).on 'changeShader', (e, shader) =>
      $('body').attr('style', '');
      @activeShader = shader

  shader: (value) ->
    if @activeShader is "solid"

      $("body").css "background-color", =>
        "hsl(200,50%,#{(value[@OFFSET] % 100)}%)"

    else if @activeShader is "gradient"
      # console.log "gradient style"
      $("body").css 'background-image', =>
        "-webkit-linear-gradient(45deg,
           hsl(#{@hue},50%,#{(value[@OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[1 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[2 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[3 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[4 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[5 + @OFFSET] % 100)}%)
        )"

    else if @activeShader is "radial"
      # console.log "gradient style"
      $("body").css 'background-image', =>
        "-webkit-radial-gradient(
           hsl(#{@hue},50%,#{(value[@OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[1 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[2 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[3 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[4 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[5 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[6 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[7 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[8 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[9 + @OFFSET] % 100)}%)
          ,hsl(#{@hue},50%,#{(value[10 + @OFFSET] % 100)}%)
        )"

    else if @activeShader is "zoom"
      val = value[@OFFSET] * 2
      $("body").css '-webkit-box-shadow', =>
        "inset 0  -#{val}px 10px hsl(#{@hue},50%,50%)"




  hueChanger: (looping=true) ->
    _.delay ( =>
      if @hue > 250
        @hueDirection = "down"
      else if @hue < 10
        @hueDirection = "up"

      if @hueDirection is "up"
        @hue = @hue + 5
      else if @hueDirection is "down"
        @hue = @hue - 5
      if looping then @hueChanger() 
    ), 1000


  render: ->
    # console.log @runRenderer
    if Renderer.runRenderer
      window.webkitRequestAnimationFrame Renderer.render
      window.Sounder.analyser.getByteFrequencyData Sounder.freqByteData 
      Renderer.shader Sounder.freqByteData
      # console.log Sounder.freqByteData[100]

