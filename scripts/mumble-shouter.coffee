# Description:
#   Connect to and query a Mumble server
#
# Dependencies:
#    None
#
# Configuration:
#   HUBOT_MUMBLE_PARTNER_URL
#
# Commands:
#   hubot <keyword> tweet - Returns a link to a tweet about <keyword>
#

module.exports = (robot) ->
	robot.enter (msg) ->
    # Hit partner endpoint with info
    user = msg.envelope.user
    userName = encodeURIComponent user.name
    userRoom = encodeURIComponent user.room
    robot.http(process.env.HUBOT_MUMBLE_PARTNER_URL)
      .path("/user/#{userName}/joined/#{userRoom}")
      .get() (err, res, body) ->
        # error checking code here
        console.log "Partner says: #{body}"
    
	robot.leave (msg) ->
		console.log msg.envelope
    
  robot.router.get '/status/userList', (req, res) ->
    console.log "User list requested"
    res.end "DONE"
    ###
    users = robot.brain.users
    activeUsers = {}
    for user of users
      unless user.room is null
        activeUsers[user.name] = user.room
    
    res.setHeader "Content-Type", "application/json"
    res.end JSON.stringify activeUsers
    ###