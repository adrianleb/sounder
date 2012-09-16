window.Renderer = 

  OFFSET: 100
  BARS: 103
  BARWIDTH: 60
  BARSOFFSET: 0
  activeShader: "paper"
  hue: 0
  theI:0
  hueDirection: "up"
  runRenderer: true
  points: []
  path: null
  changeHue: true

  init: ->
    @initEvents()
    @initPaper()
    # 
    # middle = new paper.Point 300, 200
    # @path.moveTo(start)
    # @path.lineTo(start.add([ 200, -30 ]))
    # @path.lineTo middle
    paper.view.draw()


  initPaper: ->
    paper.setup $('canvas')[0]
    @path = new paper.Path()
    @path.strokeColor = 'black'
    @path.fillColor = '#000000'
    @path.strokeWidth = 1
    console.log 'started engine'
    # @TOTALWIDTH = $('canvas')[0].width
    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height
    @initPoints()

  initPoints: ->
    console.log @BARS
    i = 0
    # @BARS = Math.round(@TOTALWIDTH / @BARWIDTH);
    while i < @BARS 
      # console.log 'something'
      w = (@TOTALWIDTH - (@TOTALWIDTH * (i / @BARS)))
      point = new paper.Point w, @TOTALHEIGHT
      @path.add point
      # @points.push point
      # @BARSOFFSET += 1
      i += 1
      # console.log @points
    # for point in @points
    #   do (point) =>
        
    #     console.log 'drew'
    # @path.segments[1].point.x = @TOTALWIDTH


  updatePos: ->
    i = 1
    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height

    while i < (@BARS - 2)
      w = (@TOTALWIDTH - (@TOTALWIDTH * (i / @BARS)))
      @path.segments[i].point.x = w
      i += 1

    # @path.segments[4].point.x = @TOTALWIDTH
    # @path.segments[1].point.x = @TOTALWIDTH
    # @path.segments[@BARS - 20].point.x = 0
    # @path.segments[@BARS - 1].point.x = 0

    @path.segments[0].point.y = @TOTALHEIGHT 
    @path.segments[1].point.y = @TOTALHEIGHT 
    @path.segments[@path.segments.length - 1].point.y = @TOTALHEIGHT 
    @path.segments[@path.segments.length - 2].point.y = @TOTALHEIGHT

  initEvents: ->

    $(@).on 'drawPoints', =>


    $(@).on 'pause', =>
      @runRenderer = false
      # @hueChanger false

    $(@).on 'start', =>
      @runRenderer = true
      @render()
      # @hueChanger()
    $(@).on 'changeShader', (e, shader) =>
      $('body').attr('style', '');
      @activeShader = shader

    debouncedresize = _.debounce ( =>
      console.log 'pie'
      @updatePos()
    ), 10
    $(window).resize => 
      debouncedresize()


  shader: (value) ->
    if @activeShader is "solid"

      $("body").css "background-color", =>
        "hsl(#{@hue},#{(value[@OFFSET] /10)}%,10%)"

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

    if @activeShader is "paper"
      i = 1
      while i < (@BARS - 1)
        # magnitude = value[ Math.round((@BARS  - i) * (value.length / @BARS - 2)) ] * 2
        # magnitude = value[Math.round(i * 8.3)] * 2
        magnitude = value[Math.round((i * 8.3))] * 2
        @path.segments[i].point.y = (@TOTALHEIGHT) - magnitude
        i += 1

      @path.fillColor = "hsla(#{ 255 - (value[@OFFSET] % 255)},30%,80%, 0.1)"
      @path.strokeColor = "hsla(#{255 - (value[@OFFSET] % 255)},20%,60%, 0.2)"
      # @path.smooth()
      $("body").css "background-color", =>
        "hsla(#{ 255 - (value[@OFFSET] % 255)},20%,10%, 1)"
      paper.view.draw()




  hueChanger: (looping=true) ->
    if Renderer.changeHue
      window.webkitRequestAnimationFrame Renderer.hueChanger
      # console.log 'hue changed'
      if Renderer.hue > 250
        Renderer.hueDirection = "down"
      else if Renderer.hue < 10
        Renderer.hueDirection = "up"

      if Renderer.hueDirection is "up"
        Renderer.hue = Renderer.hue + 1
      else if Renderer.hueDirection is "down"
        Renderer.hue = Renderer.hue - 1


  render: ->
    # console.log @runRenderer
    if Renderer.runRenderer
      window.webkitRequestAnimationFrame Renderer.render
      freqByteData = new Uint8Array(sounder.analyser.frequencyBinCount)
      window.sounder.analyser.getByteFrequencyData freqByteData 
      Renderer.shader freqByteData
      # console.log Sounder.freqByteData[100]

