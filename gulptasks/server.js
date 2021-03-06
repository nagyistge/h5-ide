var gutil, http, nstatic, open;

gutil = require("gulp-util");

nstatic = require("node-static");

http = require("http");

open = require("open");

module.exports = function(path, port, autoOpen, logTask) {
  var defaultHeader, file, redirectRegex, server;
  if (path == null) {
    path = "./src";
  }
  if (port == null) {
    port = GLOBAL.gulpConfig.staticFileServerPort;
  }
  if (autoOpen == null) {
    autoOpen = GLOBAL.gulpConfig.openUrlAfterCreateServer;
  }
  if (logTask == null) {
    logTask = true;
  }
  defaultHeader = {
    "Cache-Control": "no-cache"
  };
  if (logTask) {
    gutil.log(gutil.colors.bgBlue.white(" Creating File Server... "));
  }
  file = new nstatic.Server(path, {
    cache: false,
    headers: defaultHeader
  });
  redirectRegex = /(login|ide|register|reset|invite)\.html$/;
  server = http.createServer(function(request, response) {
    var INVITE, REG_500, REG_IDE, REG_LOGIN, REG_REGISTER, REG_RESET;
    INVITE = /^\/invite(\?\S*)?/;
    REG_RESET = /^\/reset(\?\S*)?/;
    REG_LOGIN = /^\/login(\?\S*)?/;
    REG_REGISTER = /^\/register(\?\S*)?/;
    REG_IDE = /^\/(project|store|settings|debug|cheatsheet|workspace)\/?/;
    REG_500 = /^\/500(\?\S)?/;
    request.addListener('end', function() {
      var errorHandler, filePath, url;
      url = request.url;
      if (url === "/") {
        filePath = "/ide.html";
      } else if (url[url.length - 1] === "/") {
        response.writeHead(301, {
          "Location": url.substring(0, url.length - 1)
        });
        response.end();
        return;
      } else if (redirectRegex.test(url)) {
        response.writeHead(301, {
          "Location": url.replace(".html", "")
        });
        response.end();
        return;
      } else if (INVITE.test(url)) {
        filePath = "/invite.html";
      } else if (REG_RESET.test(url)) {
        filePath = "/reset.html";
      } else if (REG_REGISTER.test(url)) {
        filePath = "/register.html";
      } else if (REG_LOGIN.test(url)) {
        filePath = "/login.html";
      } else if (REG_IDE.test(url)) {
        filePath = "/ide.html";
      } else if (REG_500.test(url)) {
        filePath = '/500.html';
      }
      errorHandler = function(e) {
        console.log("[ServerError]", e.message, request.url);
        response.writeHead(404);
        response.end();
        return null;
      };
      if (filePath) {
        file.serveFile(filePath, 200, defaultHeader, request, response).addListener("error", errorHandler);
      } else {
        file.serve(request, response).addListener("error", errorHandler);
      }
      return null;
    });
    request.resume();
    return null;
  });
  server.listen(port);
  if (autoOpen) {
    open("http://" + GLOBAL.gulpConfig.staticFileServer + ":" + port);
  }
  return server;
};
