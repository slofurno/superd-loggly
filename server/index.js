const http = require('http')

const asdf = {
  one: 1,
  two: 2,
  three: false,
  four: 'asdasddsfgsfdgfsdgsdfsdf',
  five: [].slice.call('qwertyuijhgf'),
}

http.createServer((req, res) => {
  setTimeout(() => {
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(asdf));
  }, 2000)
}).listen(3000)
