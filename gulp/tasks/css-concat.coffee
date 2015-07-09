gulp = require 'gulp'
$ = require('gulp-load-plugins')()

config = require('../config').cssConcat

gulp.task 'css-concat', ->
  gulp.src config.srcs
  .pipe $.concat config.name
# $.cssoは圧縮時に勝手に最適化してしまい、CSSを書き換えられてしまうので今後使わない
#  .pipe $.if global.isRelease, $.csso(false)    # リリース時は圧縮する
  .pipe gulp.dest config.dest
  .pipe $.size() #cssのファイルサイズ
