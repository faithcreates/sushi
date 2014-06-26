{expect} = require 'chai'
RobotDriver = require './robot-driver'

global.expect = expect

beforeEach ->
  @driver = new RobotDriver

afterEach ->
  @driver.stop()
