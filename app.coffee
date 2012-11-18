
io        = require('socket.io')
express   = require('express')
http      = require('http')
fs        = require('fs')

PORT = process.env.PORT || 7007

app    = express()
server = http.createServer(app)

server.listen(PORT)
console.log("\t :: Express :: Listening on port #{PORT}")

app.get '/', (req, res) ->
  res.sendfile 'www/index.html'

app.get '/*', (req, res) ->
  path = "www/#{req.params[0]}";
  fs.lstat path, (err,stats)->
    if not err
      res.sendfile path
    else
      res.sendfile 'www/index.html'

sio = io.listen(server)

sio.configure ->
  @set 'log level', 0
  @set 'authorization', (handshakeData, callback)->
    callback(null, true)

sio.on 'connection', (client)->
  console.log "Client connected #{client.id}"

  client.on 'login', (data)->
    console.log data

  client.on 'disconnect', ->
    console.log "Client disconnected #{client.id}"


