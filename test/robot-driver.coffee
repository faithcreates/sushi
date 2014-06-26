{Promise} = require 'q'
{Robot, TextMessage} = require 'hubot'

class RobotDriver
  @DEFAULT_TIMEOUT = 100 # ms

  constructor: ->
    @timeout = @DEFAULT_TIMEOUT
    @robot = null # initialize in start()
    @adapter = null # initialize in start()
    @started = false
    @users = []

  start: (options = {}) ->
    throw new Error('already started') if @started
    @started = true
    new Promise (resolve, reject) =>
      @robot = new Robot(null, 'mock-adapter', false, 'sushi')
      @robot.adapter.on 'connected', =>
        @adapter = @robot.adapter
        (options.scripts or []).forEach (script) =>
          script @robot
        (options.users or []).forEach (user) =>
          @users.push @robot.brain.userForId(user.id, {
            name: user.name,
            room: user.room
          })
        resolve()
      @robot.run()

  stop: ->
    throw new Error('call receiveMessage() after start()') unless @started
    @started = false
    @robot.shutdown()
    Promise.resolve()

  receiveMessage: (envelope, message) ->
    throw new Error('call receiveMessage() after start()') unless @started
    promise = new Promise (resolve, reject) =>
      setTimeout ->
        reject new Error('timeout')
      , @timeout
      @adapter.on 'send', (envelope, strings) ->
        resolve
          name: 'send'
          envelope: envelope
          strings: strings
    @adapter.receive new TextMessage(envelope, message)
    promise

module.exports = RobotDriver
