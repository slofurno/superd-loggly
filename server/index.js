const http = require('http')
const util = require('util')
const request = require('request')

const log4js = require('log4js')
const logger = log4js.getLogger()

http.createServer((req, res) => {
  request('http://unix:/tmp/asdf.sock:/pokemon', (err, res, body) => {
    if (err) {
      return logger.error(err)
    } else if(res.statusCode !== 200){
      return logger.error(`bad status code: ${res.statusCode}`)
    }

    res.json(body)
    logger.info(util.inspect(process.memoryUsage()))
  })
}).listen(3000)

