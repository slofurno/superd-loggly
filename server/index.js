const http = require('http')
const util = require('util')
const request = require('request')
const express = require('express')
const log4js = require('log4js')

const logger = log4js.getLogger()
const app = express()
const server = http.createServer()

app.get('/', (req, res) => {
  //http://unix:/tmp/asdf.sock:/pokemon
  request('http://127.0.1.4:4444/pokemon', (err, response, body) => {
    if (err) {
      return logger.error(err)
      res.sendStatus(503)
    } else if(response.statusCode !== 200){
      res.sendStatus(503)
      return logger.error(`bad status code: ${response.statusCode}`, body)
    }

    res.json(body)
    logger.info(util.inspect(process.memoryUsage()))
  })
})

server.on('request', app)
server.listen(3000)

