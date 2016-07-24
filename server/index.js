const http = require('http')
const util = require('util')

const log4js = require('log4js')
const logger = log4js.getLogger()

const asdf = {
  one: 1,
  two: 2,
  three: false,
  four: 'asdasddsfgsfdgfsdgsdfsdf',
  five: [].slice.call('qwertyuijhgf'),
}

http.createServer((req, res) => {
  setTimeout(() => {
    logger.info(util.inspect(process.memoryUsage()))
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(asdf));
  }, 2000)
}).listen(3000)

