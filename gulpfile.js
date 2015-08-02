var gulp = require('gulp');

require('./tasks/gulpfile-sass.js')(gulp);
require('./tasks/gulpfile-coffee.js')(gulp);
require('./tasks/gulpfile-preview.js')(gulp);
require('./tasks/gulpfile-develop.js')(gulp);
require('./tasks/gulpfile-default.js')(gulp);
