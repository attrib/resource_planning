fs         = require 'fs';
browserify = require 'browserify'

task 'build', 'Compile js into bundle', ->
  b = browserify()
  b.require './src/client/client', root:__dirname
  fs.writeFileSync 'www/js/bundle.js', b.bundle()