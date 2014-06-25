# Description
#   hello
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot hello - say hello
#
# Author:
#   Ayumu Yamauchi
#
module.exports = (robot) ->
  robot.respond /HELLO$/i, (res) ->
    res.send 'Hello!'
