Meteor.startup ->
  $ ->
    window.sounder = new Sounder
    # Player.init()
    Renderer.init()

    _.delay (=>
      console.log window.location
      if window.location.pathname
        src = window.location.pathname
        console.log src.indexOf ".mp3"
        if src.indexOf ".mp3" isnt -1
          newAudio = new Audio()
          newAudio.src = src.substr(1)
          _.delay (=>
            $(sounder).trigger 'newTrack', newAudio
            $(sounder.player).trigger 'playLast'
          ), 20
      sounder.plugMany()
      console.log 'ready'
      ), 20
