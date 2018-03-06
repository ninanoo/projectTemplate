var gulp = require('gulp')
  , gulpChanged = require('gulp-changed')
  , gulpShell = require('gulp-shell')
;


var paths = {
	
	npm: {
		src: 'deploy/package.json',
		dest: 'build',
	},
	
	sh: {
		src: 'deploy/*.sh',
		dest: 'build',
	},
	
	clean: {
		src: undefined,
		dest: undefined,
	},
	
	all: {
		base: 'deploy',
		src: [
			'deploy/**/*',
			'deploy/**/.*',
//			'deploy/*',
//			'deploy/subpath/*',
			
			'!deploy/package.json',
			'!deploy/*.sh',
			
			'!deploy/.gitignore',
			'!deploy/.project.build.exclude',
		],
		dest: 'build',
	},
};


gulp.task('npm', function() {

	return gulp.src(paths.npm.src)
		.pipe(gulpChanged(paths.npm.dest))
		.pipe(gulp.dest(paths.npm.dest))
		.pipe(gulpShell('cd build && rm -rf node_modules && npm install --no-color')) // TODO: npm uninstall ( between gulpChanged() and gulp.dest() )
});


gulp.task('sh', function() {

	return gulp.src(paths.sh.src)
		.pipe(gulpChanged(paths.sh.dest))
		.pipe(gulp.dest(paths.sh.dest))
		.pipe(gulpShell('cd build && chmod a+x *.sh'))
});


gulp.task('clean', function() {

	console.log('TODO: clean');
	
//	return del(paths.clean.dest)
});


gulp.task('all', ['clean'], function() {

	return gulp.src(paths.all.src, {base: paths.all.base})
		.pipe(gulpChanged(paths.all.dest))
		.pipe(gulp.dest(paths.all.dest))

//	console.log();
//	console.log();
//	console.log(gulp);
//	console.log();
//	var z0 = gulp.src(paths.all.src, {base: paths.all.base});
//	console.log();
//	console.log(z0);
//	console.log();
//	var z1 = z0.pipe(gulpChanged(paths.all.dest));
//	console.log();
//	console.log(z1);
//	console.log();
//	var z2 = z1.pipe(gulp.dest(paths.all.dest));
//	console.log();
//	console.log(z2);
//	console.log();
//	console.log();
//	
//	return z2
});


gulp.task('default', ['npm', 'sh', 'all']);



