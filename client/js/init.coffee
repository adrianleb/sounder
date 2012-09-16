Meteor.startup ->
  $ ->
    Sounder.init()
    Player.init()
    Renderer.init()

    _.delay (=>
      Sounder.plugMany()
      console.log 'ready'
      ), 20