var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.sendFile('index.html');
});

router.get('/about', function(req, res, next) {
  res.sendFile('about.html');
});

router.get('/resources', function(req, res, next) {
  res.sendFile('resources.html');
});

router.get('/senior_design', function(req, res, next) {
  res.sendFile('senior_design.html');
});

router.get('/hours', function(req, res, next) {
  res.sendFile('lab_hours.html');
});

router.get('/officers', function(req, res, next) {
  res.sendFile('officers.html');
});

router.get('/live', function(req, res, next) {
  res.sendFile('live_camera.html');
});

router.get('/calendar', function(req, res, next) {
  res.sendFile('calendar.html');
});

router.get('/signup', function(req, res, next) {
  res.sendFile('signup.html');
});



module.exports = router;
