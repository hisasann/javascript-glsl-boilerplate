bs = require('browser-sync').create()
gulp        = require('gulp')
config      = require('../config').browserSync

gulp.task('browserSync', () ->
  bs.watch('build/**/*.html').on('change', bs.reload);
  bs.watch('build/**/*.js').on('change', bs.reload);
  bs.watch('build/**/*.css').on('change', bs.reload);
  bs.init(config)
)
