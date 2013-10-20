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
  robot.router.get "/mumble/userList", (req, res) ->
    console.log "User list requested"
    users = robot.brain.data.users
    console.log users
    activeUsers = {}
    for key, value of users
      unless value.room is null
        activeUsers[value.name] = value.room
    
    res.setHeader "Content-Type", "application/json"
    res.end JSON.stringify activeUsers
    
    #res.setHeader 'content-type', 'text/html'
    #res.end helpContents robot.name, emit
    
###
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
    
  robot.router.get "/user/:name/joined/:channel", (req, res) ->
    userName = req.params.name
    mumbleChannel = req.params.channel
    
    console.log "User: #{userName} to Channel: #{mumbleChannel}"
    res.end "JOIN NOTED"
  
  robot.router.get '/status/userList', (req, res) ->
    console.log "User list requested"
    users = robot.brain.users
    activeUsers = {}
    for user of users
      unless user.room is null
        activeUsers[user.name] = user.room
    
    res.setHeader "Content-Type", "application/json"
    res.end JSON.stringify activeUsers
###