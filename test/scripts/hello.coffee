require '../helper'

describe 'hello', ->
  beforeEach ->
    @script = require('../../src/scripts/hello')

  describe 'receive "@sushi hello"', ->
    beforeEach (done) ->
      @message = '@sushi hello'
      @driver
        .start
          scripts: [@script]
          users: [{ id: '1', name: 'bouzuya', room: '#general' }]
        .then =>
          @bouzuya = @driver.users[0]
        .then ->
          done()
        , done

    it 'send "Hello!"', (done) ->
      @driver
        .receiveMessage @bouzuya, @message
        .then (e) ->
          expect e.name
            .to.equal 'send'
          expect e.strings[0]
            .to.equal 'Hello!'
        .then ->
          done()
        , done

  describe 'receive "@sushi hello!!!"', ->
    beforeEach (done) ->
      @message = '@sushi hello!!!'
      @driver
        .start
          scripts: [@script]
          users: [{ id: '1', name: 'bouzuya', room: '#general' }]
        .then =>
          @bouzuya = @driver.users[0]
        .then ->
          done()
        , done

    it 'send no message', (done) ->
      @driver
        .receiveMessage @bouzuya, @message
        .then ->
          done new Error('failure')
        , (e) ->
          expect e.message
            .to.equal 'timeout'
        .then ->
          done()
        , done

  describe 'receive "@bouzuya hello"', ->
    beforeEach (done) ->
      @message = '@bouzuya hello'
      @driver
        .start
          scripts: [@script]
          users: [{ id: '1', name: 'bouzuya', room: '#general' }]
        .then =>
          @bouzuya = @driver.users[0]
        .then ->
          done()
        , done

    it 'send no message', (done) ->
      @driver
        .receiveMessage @bouzuya, @message
        .then ->
          done new Error('failure')
        , (e) ->
          expect e.message
            .to.equal 'timeout'
        .then ->
          done()
        , done
