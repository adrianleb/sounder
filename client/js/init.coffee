Meteor.startup ->
  $ ->
    window.sounder = new Sounder
    # Player.init()
    Renderer.init()

    _.delay (=>
      sounder.plugMany()
      console.log 'ready'
      ), 20