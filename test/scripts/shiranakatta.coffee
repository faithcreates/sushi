require '../helper'

describe 'shiranakatta', ->
  beforeEach ->
    @script = require('../../src/scripts/shiranakatta')

  describe 'receive "知らなかった　そんなの…"', ->
    beforeEach (done) ->
      @message = '知らなかった　そんなの…'
      @driver
        .start
          scripts: [@script]
          users: [{ id: '1', name: 'bouzuya', room: '#general' }]
        .then =>
          @bouzuya = @driver.users[0]
        .then ->
          done()
        , done

    it 'send "http://s3-ap-northeast-1.amazonaws.com/shiranakatta/sonnano.jpg"', (done) ->
      @driver
        .receiveMessage @bouzuya, @message
        .then (e) ->
          expect e.name
            .to.equal 'send'
          expect e.strings[0]
            .to.equal 'http://s3-ap-northeast-1.amazonaws.com/shiranakatta/sonnano.jpg'
        .then ->
          done()
        , done

  describe 'receive "しらなかった そんなの"', ->
    beforeEach (done) ->
      @message = 'しらなかった そんなの'
      @driver
        .start
          scripts: [@script]
          users: [{ id: '1', name: 'bouzuya', room: '#general' }]
        .then =>
          @bouzuya = @driver.users[0]
        .then ->
          done()
        , done

    it 'send "http://s3-ap-northeast-1.amazonaws.com/shiranakatta/sonnano.jpg"', (done) ->
      @driver
        .receiveMessage @bouzuya, @message
        .then (e) ->
          expect e.name
            .to.equal 'send'
          expect e.strings[0]
            .to.equal 'http://s3-ap-northeast-1.amazonaws.com/shiranakatta/sonnano.jpg'
        .then ->
          done()
        , done

  describe 'receive "しらなかった"', ->
    beforeEach (done) ->
      @message = 'しらなかった'
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
