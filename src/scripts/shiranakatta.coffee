# Description
#   shiranakatta
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   知らなかった　そんなの… - send image url
#
# Author:
#   Ayumu Yamauchi
#
module.exports = (robot) ->
  robot.hear /[し知]らなかった.*そんなの/, (res) ->
    res.send 'http://s3-ap-northeast-1.amazonaws.com/shiranakatta/sonnano.jpg'
