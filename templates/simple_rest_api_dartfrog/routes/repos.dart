import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// these two objects will serve as our faux database
var repos = [
  {"name": 'express', "url": 'https://github.com/expressjs/express'},
  {"name": 'stylus', "url": 'https://github.com/learnboost/stylus'},
  {"name": 'cluster', "url": 'https://github.com/learnboost/cluster'}
];

var userRepos = {
  "tobi": [repos[0], repos[1]],
  "loki": [repos[1]],
  "jane": [repos[2]]
};

Response onRequest(RequestContext context) {
  return Response.json(body: repos);
}
