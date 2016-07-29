var path = require("path");
var gulp = require('gulp');
var gutil = require('gulp-util');
var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var merge = require( 'webpack-merge' );
var nodemon = require('gulp-nodemon');
var spawn = require('child_process').spawn;
var jsonTransform = require('gulp-json-transform');
var del = require('del');
var replace = require('gulp-replace');
var minimist = require('minimist');
var zip = require('gulp-zip');
var runSequence = require('run-sequence');
var webpackCommonConfig = require('./webpack.common.config.js');
var webpackClientConfig = require('./webpack.client.config.js');
var getServerConfig = require('./webpack.server.config.js').getServerConfig;


var knownOptions = {
	string: 'packageName',
	string: 'outputPath',
	default: {packageName: 'package.zip', outputPath: path.join(__dirname, '_dist')}
}

var options = minimist(process.argv.slice(2), knownOptions);

var devOutputPath = path.join(__dirname, '_build');
var webpackStatsConfig = {
  // Config for minimal console.log mess.
  assets: false,
  colors: true,
  version: false,
  hash: false,
  timings: false,
  chunks: false,
  chunkModules: false
};

var cleanDistFolderTaskName = 'clean:prod';
gulp.task(cleanDistFolderTaskName, function() {
  return del([ path.join(options.outputPath, '/**/*') ]);
});


// Client tasks
var webpackClientdevServerTaskName = 'webpack-dev-server:client';
gulp.task(webpackClientdevServerTaskName, function(callback) {
  var port = 3010;
	// load webpack config options for client dev build
  var commonConfig = webpackClientConfig.commonClientConfig;
  var indexFileConfig = webpackClientConfig.getIndexFileConfig(devOutputPath);
  var elmHotLoaderConfig = webpackClientConfig.elmHotLoaderConfig;
  var indexDevEntryConfig = webpackClientConfig.indexDevEntryConfig;

	var config = merge(indexDevEntryConfig, indexFileConfig, commonConfig, elmHotLoaderConfig);
  config.plugins.push(new webpack.HotModuleReplacementPlugin())
	config.entry.main.unshift('webpack-dev-server/client?http://localhost:'+ port +'/');

	// Start a webpack-dev-server
	new WebpackDevServer(webpack(config), {
    hot: true,
		publicPath: '/assets/',
    quiet: false,
    noInfo: false,
		stats: webpackStatsConfig
	}).listen(port, 'localhost', function(err) {
		if(err) throw new gutil.PluginError(webpackClientdevServerTaskName, err);
		gutil.log('['+ webpackClientdevServerTaskName +']', 'http://localhost:'+ port +'/webpack-dev-server/');
	});
});

var webpackProdClientTaskName = 'webpack:client:build-prod';
gulp.task(webpackProdClientTaskName, function(callback) {
  // load webpack config options for client prod build
  var commonConfig = webpackClientConfig.commonClientConfig;
  var indexFileConfig = webpackClientConfig.getIndexFileConfig(options.outputPath);
  var elmConfig = webpackCommonConfig.elmConfig;
  var indexEntryConfig = webpackClientConfig.indexEntryConfig;

	var config = merge(indexEntryConfig, indexFileConfig, commonConfig, elmConfig);

  config.plugins = config.plugins.concat(
		new webpack.DefinePlugin({
			'process.env': {
				// This has effect on the react lib size
				'NODE_ENV': JSON.stringify('production')
			}
		}),
		new webpack.optimize.DedupePlugin(),
		new webpack.optimize.UglifyJsPlugin()
	);

  webpack(config, function(err, stats) {
		if(err) throw new gutil.PluginError(webpackProdClientTaskName, err);
    var jsonStats = stats.toJson(webpackStatsConfig);
    if(stats.hasErrors()) {
      gutil.log('['+webpackProdClientTaskName+']', stats.toString(webpackStatsConfig));
      throw new gutil.PluginError(webpackProdClientTaskName, 'webpack compilation errors');
    }
		gutil.log('['+webpackProdClientTaskName+']', stats.toString(webpackStatsConfig));
		callback();
	});
});


// Server tasks
// create a single instance of the compiler to allow caching
var devServerCompiler = webpack(getServerConfig(devOutputPath));

var webpackServerTaskName = 'webpack:server:build-dev';
gulp.task(webpackServerTaskName, function(callback) {
	// run webpack
	devServerCompiler.run(function(err, stats) {
		if(err) throw new gutil.PluginError(webpackServerTaskName, err);
		gutil.log('['+webpackServerTaskName+']', stats.toString(webpackStatsConfig));
		callback();
	});
});

var webpackServerWatchTaskName = 'build-dev:server';
gulp.task(webpackServerWatchTaskName, [webpackServerTaskName], function() {
	gulp.watch(['src/**/*'], [webpackServerTaskName]);
});

var startServerTaskName = "start-dev:server"
gulp.task(startServerTaskName, function() {
  var folderToExecuteFrom = devOutputPath;
  var packageFile = require('./package.json');
  gutil.log('['+startServerTaskName+']', 'Starting server from:', folderToExecuteFrom);
  process.chdir(folderToExecuteFrom);

  nodemon({
    script: packageFile.main,
    env: {
      port:3000
    }
  });
});

var webpackProdServerTaskName = 'webpack:server:build-prod';
gulp.task(webpackProdServerTaskName, function(callback) {
  var config = getServerConfig(options.outputPath);

  config.plugins = config.plugins.concat(
		new webpack.optimize.DedupePlugin(),
		new webpack.optimize.UglifyJsPlugin()
	);

  webpack(config, function(err, stats) {
		if(err) throw new gutil.PluginError(webpackProdServerTaskName, err);
    var jsonStats = stats.toJson(webpackStatsConfig);
    if(stats.hasErrors()) {
      gutil.log('['+webpackProdServerTaskName+']', stats.toString(webpackStatsConfig));
      throw new gutil.PluginError(webpackProdServerTaskName, 'webpack compilation errors');
    }
		gutil.log('['+webpackProdServerTaskName+']', stats.toString(webpackStatsConfig));
		callback();
	});
});


// Test tasks
var webpackTestdevServerTaskName = 'webpack-dev-server:tests';
gulp.task(webpackTestdevServerTaskName, function(callback) {
  var port = 8000;
	// load webpack config options
  var commonConfig = webpackClientConfig.commonClientConfig;
  var testFileConfig = webpackClientConfig.getTestFileConfig(devOutputPath);
  var elmConfig = webpackCommonConfig.elmConfig;

	var config = merge(testFileConfig, commonConfig, elmConfig);
	config.entry.tests.unshift('webpack-dev-server/client?http://localhost:'+ port +'/');

	// Start a webpack-dev-server
	new WebpackDevServer(webpack(config), {
    // It suppress error shown in console, so it has to be set to false.
    quiet: false,
    // It suppress everything except error, so it has to be set to false as well
    // to see success build.
    noInfo: false,
    stats: webpackStatsConfig
	}).listen(port, 'localhost', function(err) {
		if(err) throw new gutil.PluginError(webpackTestdevServerTaskName, err);
		gutil.log('['+ webpackTestdevServerTaskName +']', 'http://localhost:'+ port);
	});
});


// Dev tasks
var serverProcess = null;
var startServerOnSeperateProcessTaskName = "start-dev:server:new-process";
gulp.task(startServerOnSeperateProcessTaskName, function(cb) {
  var nodeExePath = process.argv[0];
  var gulpjsPath = process.argv[1];

  // Need to wait to make sure dependent files have been webpacked 
  setTimeout(function(){
    gutil.log('['+startServerOnSeperateProcessTaskName+']', 'Starting ' + startServerTaskName +' on new proccess.');
    serverProcess = spawn(nodeExePath, [gulpjsPath, startServerTaskName], {
      stdio: 'inherit' 
    }).on('error', function (err) {
      throw new gutil.PluginError(startServerOnSeperateProcessTaskName, err);
    }).on('exit', function() {
      cb();
    });
  }, 8000 /* timeout in ms */);
});

process.on('exit', function () {
    // In case the gulp process is closed (e.g. by pressing [CTRL + C]) stop server process if running
    if (serverProcess !=  null) {
      serverProcess.kill();
    }
});

var devTaskName = 'dev';
gulp.task(devTaskName, 
  [webpackClientdevServerTaskName, 
  webpackServerWatchTaskName,
  webpackTestdevServerTaskName,
  startServerOnSeperateProcessTaskName]);


// Prod Tasks
var copyPackageJsonTaskName = 'copy:packageJsonFile:prod';
gulp.task(copyPackageJsonTaskName, function() {
  gulp.src('./package.json')
  .pipe(jsonTransform(function(data, file) {
		return {
  	  name: data.name,
      version: data.version,
      private: data.private,
      dependencies: data.dependencies
		};
	}))
	.pipe(gulp.dest(options.outputPath));
});

var copyWebConfigFileTaskName = 'copy:webConfig:prod';
gulp.task(copyWebConfigFileTaskName, function() {
  var packageFile = require('./package.json');
  gulp.src('./web.config')
  .pipe(replace('<server.js>', packageFile.main))
  .pipe(gulp.dest(options.outputPath));
});

var prodTaskName = 'prepare:prod';
gulp.task(prodTaskName, 
  function(callback){
    runSequence(
      cleanDistFolderTaskName,
      webpackProdServerTaskName,
      webpackProdClientTaskName,
      [copyPackageJsonTaskName, copyWebConfigFileTaskName],
      callback);
  });

var startProdTaskname = 'run:prod';
gulp.task(startProdTaskname, function() {
  var folderToExecuteFrom = options.outputPath;
  var packageFile = require('./package.json');
  gutil.log('['+startProdTaskname+']', 'Starting server from:', folderToExecuteFrom);
  process.chdir(folderToExecuteFrom);

  nodemon({
    script: packageFile.main,
    env: {
      port:3000
    }
  });
});

gulp.task('package:prod', function () {
	var packagePaths = [
        path.join(options.outputPath, '**'),
        '!' + path.join(options.outputPath, 'package.json')];
	
  return gulp.src(packagePaths)
  .pipe(zip(options.packageName))
  .pipe(gulp.dest(options.outputPath));
});
