(function() {
  var EventEmitter, Helper, Q, StreamFuncs, cached, changeHandler, checkWatchHealthy, chokidar, coffee, coffeelint, coffeelintOptions, compileCoffeeOnlyRegex, compileDev, compileIgnorePath, confCompile, es, fs, gulp, gulpif, gutil, jshint, langsrc, lintReporter, notifier, path, tinylr, watch;

  gulp = require("gulp");

  gutil = require("gulp-util");

  path = require("path");

  es = require("event-stream");

  Q = require("q");

  fs = require("fs");

  EventEmitter = require("events").EventEmitter;

  tinylr = require("tiny-lr");

  chokidar = require("chokidar");

  notifier = require("node-notifier");

  coffee = require("gulp-coffee");

  coffeelint = require("gulp-coffeelint");

  gulpif = require("gulp-if");

  confCompile = require("./plugins/conditional");

  cached = require("./plugins/cached");

  jshint = require("./plugins/jshint");

  lintReporter = require('./plugins/reporter');

  langsrc = require("./plugins/langsrc");

  coffeelintOptions = {
    indentation: {
      level: "ignore"
    },
    no_tabs: {
      level: "ignore"
    },
    max_line_length: {
      level: "ignore"
    }
  };

  compileIgnorePath = /.src.(test|vender|ui)/;

  compileCoffeeOnlyRegex = /.src.(service|model)/;

  Helper = {
    shouldLintCoffee: function(f) {
      return !f.path.match(compileCoffeeOnlyRegex);
    },
    endsWith: function(string, pattern) {
      var idx, startIdx;
      if (string.length < pattern.length) {
        return false;
      }
      idx = 0;
      startIdx = string.length - pattern.length;
      while (idx < pattern.length) {
        if (string[startIdx + idx] !== pattern[idx]) {
          return false;
        }
        ++idx;
      }
      return true;
    },
    notify: function(msg) {
      if (GLOBAL.gulpConfig.enbaleNotifier) {
        notifier.notify({
          title: "IDE Gulp",
          message: msg
        }, function() {});
      }
      return null;
    },
    lrServer: void 0,
    createLrServer: function() {
      if (Helper.lrServer !== void 0) {
        return;
      }
      gutil.log(gutil.colors.bgBlue.white(" Starting livereload server... "));
      Helper.lrServer = tinylr();
      Helper.lrServer.server.removeAllListeners('error');
      Helper.lrServer.server.on("error", function(e) {
        if (e.code !== "EADDRINUSE") {
          return;
        }
        console.error('[LR Error] Cannot start livereload server. You already have a server listening on %s', Helper.lrServer.port);
        return Helper.lrServer = null;
      });
      Helper.lrServer.listen(GLOBAL.gulpConfig.livereloadServerPort, function(err) {
        if (err) {
          gutil.log("[LR Error]", "Cannot start livereload server");
          Helper.lrServer = null;
        }
        return null;
      });
      return null;
    },
    compileTitle: function(extra) {
      var title;
      title = "[" + gutil.colors.green("Compile @" + ((new Date()).toLocaleTimeString())) + "]";
      if (extra) {
        title += " " + gutil.colors.inverse(extra);
      }
      return title;
    },
    cwd: process.cwd(),
    watchRetry: 0,
    watchIsWorking: false,
    createWatcher: function() {
      var compileAfterGitAction, gitDebounceTimer, gulpWatch, watcher;
      if (GLOBAL.gulpConfig.pollingWatch) {
        gutil.log(gutil.colors.bgBlue.white(" Watching file changes... ") + " [Polling]");
        watcher = new EventEmitter();
        gulp.watch(["./src/**/*.coffee", "./src/assets/**/*"], function(event) {
          var type;
          if (event.type === "added") {
            type = "add";
          } else if (event.type === "changed") {
            type = "change";
          } else {
            return;
          }
          watcher.emit(type, event.path);
          return null;
        });
      } else {
        gutil.log(gutil.colors.bgBlue.white(" Watching file changes... ") + " [Native FSevent, vim might not trigger changes]");
        watcher = chokidar.watch(["./src", "./util/gulp_tasks"], {
          usePolling: false,
          useFsEvents: true,
          ignoreInitial: true,
          ignored: /([\/\\]\.)|src.(test|vender)/
        });
        gitDebounceTimer = null;
        compileAfterGitAction = function() {
          console.log("[" + gutil.colors.green("Git Action Detected @" + ((new Date()).toLocaleTimeString())) + "] Ready to re-compile the whole project");
          gitDebounceTimer = null;
          return compileDev();
        };
        gulpWatch = gulp.watch(["./.git/HEAD", "./.git/refs/heads/develop", "./.git/refs/heads/**/*"], function(event) {
          if (gitDebounceTimer === null) {
            gitDebounceTimer = setTimeout(compileAfterGitAction, GLOBAL.gulpConfig.gitPollingDebounce || 1000);
          }
          return null;
        });
        gulpWatch.on("error", function(error) {
          return console.log("[Gulp Watch Git Error]", error);
        });
      }
      return watcher;
    }
  };

  StreamFuncs = {
    coffeeErrorPrinter: function(error) {
      console.log(gutil.colors.red.bold("\n[CoffeeError]"), error.message.replace(process.cwd(), "."));
      Helper.notify("Error occur when compiling " + error.message.replace(process.cwd(), ".").split(":")[0]);
      return null;
    },
    throughLiveReload: function() {
      return es.through(function(file) {
        if (Helper.lrServer) {
          Helper.lrServer.changed({
            body: {
              files: [file.path]
            }
          });
        }
        return null;
      });
    },
    throughCoffee: function() {
      var coffeeBranch, coffeeCompile, conditonalLint, pipeline;
      conditonalLint = gulpif(Helper.shouldLintCoffee, coffeelint(void 0, coffeelintOptions));
      coffeeBranch = cached(conditonalLint);
      coffeeCompile = conditonalLint.pipe(confCompile(false)).pipe(coffee({
        sourceMap: GLOBAL.gulpConfig.coffeeSourceMap
      }));
      pipeline = coffeeCompile.pipe(es.through(function(f) {
        console.log(Helper.compileTitle(f.extra), "" + f.relative);
        return this.emit("data", f);
      })).pipe(gulpif(Helper.shouldLintCoffee, jshint())).pipe(gulpif(Helper.shouldLintCoffee, lintReporter())).pipe(gulp.dest("."));
      if (GLOBAL.gulpConfig.reloadJsHtml) {
        pipeline.pipe(StreamFuncs.throughLiveReload());
      }
      coffeeCompile.removeAllListeners("error");
      coffeeCompile.on("error", StreamFuncs.coffeeErrorPrinter);
      return coffeeBranch;
    },
    workStream: null,
    workEndStream: null,
    createStreamObject: function() {
      if (StreamFuncs.workStream) {
        return;
      }
      StreamFuncs.workStream = es.through();
      StreamFuncs.workEndStream = StreamFuncs.setupCompileStream(StreamFuncs.workStream);
      return null;
    },
    setupCompileStream: function(stream) {
      var assetBranch, coffeeBranch, coffeeBranchRegex, langSrcBranch, langeSrcBranchRegex, liveReloadBranchRegex;
      assetBranch = StreamFuncs.throughLiveReload();
      langSrcBranch = langsrc();
      coffeeBranch = StreamFuncs.throughCoffee();
      langeSrcBranchRegex = /lang-source\.coffee/;
      coffeeBranchRegex = /\.coffee$/;
      if (GLOBAL.gulpConfig.reloadJsHtml) {
        liveReloadBranchRegex = /(src.assets)|(\.js$)|(\.html$)/;
      } else {
        liveReloadBranchRegex = /src.assets/;
      }
      return stream.pipe(gulpif(langeSrcBranchRegex, langSrcBranch, true)).pipe(gulpif(coffeeBranchRegex, coffeeBranch, true)).pipe(gulpif(liveReloadBranchRegex, assetBranch, true));
    }
  };

  changeHandler = function(path) {
    var stats;
    Helper.watchIsWorking = true;
    if (!fs.existsSync(path)) {
      return;
    }
    stats = fs.statSync(path);
    if (stats.isDirectory()) {
      return;
    }
    if (GLOBAL.gulpConfig.verbose) {
      console.log("[Change]", path);
    }
    if (path.match(/src.assets/)) {
      StreamFuncs.workStream.emit("data", {
        path: path
      });
    } else {
      fs.readFile(path, function(err, data) {
        if (!data) {
          return;
        }
        StreamFuncs.workStream.emit("data", new gutil.File({
          cwd: Helper.cwd,
          base: Helper.cwd,
          path: path,
          contents: data
        }));
        return null;
      });
    }
    return null;
  };

  checkWatchHealthy = function(watcher) {
    if (GLOBAL.gulpConfig.pollingWatch) {
      return;
    }
    fs.writeFileSync("./src/robots.txt", fs.readFileSync("./src/robots.txt"));
    return setTimeout(function() {
      if (!Helper.watchIsWorking) {
        console.log("[Info]", "Watch is not working. Will retry in 2 seconds.");
        Helper.notify("Watch is not working. Will retry in 2 seconds.");
        watcher.removeAllListeners();
        return setTimeout((function() {
          return watch();
        }), 2000);
      }
    }, 500);
  };

  watch = function() {
    var watcher;
    ++Helper.watchRetry;
    if (Helper.watchRetry > 3) {
      console.log(gutil.colors.red.bold("[Fatal]", "Watch is still not working. Please manually retry."));
      Helper.notify("Watch is still not working. Please manually retry.");
      return;
    }
    Helper.createLrServer();
    StreamFuncs.createStreamObject();
    watcher = Helper.createWatcher();
    watcher.on("add", changeHandler);
    watcher.on("change", changeHandler);
    watcher.on("error", function(e) {
      return console.log("[error]", e);
    });
    checkWatchHealthy(watcher);
    return null;
  };

  compileDev = function(allCoffee) {
    var compileStream, deferred;
    if (allCoffee) {
      path = ["src/**/*.coffee", "!src/test/**/*"];
    } else {
      path = ["src/**/*.coffee", "!src/test/**/*", "!src/service/**/*", "!src/model/**/*"];
    }
    deferred = Q.defer();
    StreamFuncs.createStreamObject();
    compileStream = gulp.src(path, {
      cwdbase: true
    }).pipe(es.through(function(f) {
      StreamFuncs.workStream.emit("data", f);
      return null;
    }));
    compileStream.once("end", function() {
      return deferred.resolve();
    });
    return deferred.promise;
  };

  module.exports = {
    watch: watch,
    compileDev: compileDev
  };

}).call(this);
