:lipstick: javascript-glsl-boilerplate :lipstick:
===============

## Overview

javascript-glsl-boilerplate

## Tools

* ES6
* gulp
* browserify
* glslify

## Important Point

まずはbrowserifyのtransform **glslify** を使って、glslを文字列として変数に入れる。

```javasctipt
var vert = glslify(__dirname + '/glsl/vertexShader.vert');
var frag = glslify(__dirname + '/glsl/fragmentShader.frag');
```

今回は **three.js** を使っているので、THREE.RawShaderMaterialにセットする。

```javascript
var mat = new THREE.RawShaderMaterial({
  vertexShader: vert,
  fragmentShader: frag
});
```

glslifyの優秀なところは、glsl内でbrowserify的なとこができる点。

```glsl
#pragma glslify: noise = require(./common/noise)

void main() {
    vec2 t = gl_FragCoord.xy + vec2(t * 10.0);
    float n = noise(t);
}
```

的なとあえて書いたのは、javascriptでは、shaderは文字列として扱われるため、

pragmaを使ってインポートすると、関数名にサフィックスを付けて、文字列としてコピーされる。

よって、インポートをするたびに関数のサフィックスは上がってくため、呼び方をうまくしないと存在しない関数を読んでしまう。

たとえば、以下のようにnoise関数をインポートしてmainの中で呼び出しているが、snoiseの中でもnoiseをインポートしていると、

```glsl
#pragma glslify: noise = require(./common/noise)
#pragma glslify: snoise = require(./common/snoise)

void main() {
    vec2 t = gl_FragCoord.xy + vec2(t * 10.0);
    float n = noise(t);
}
```

ビルド後の結果として、

```glsl
float noise_2_6() {
}

float snoise_1_7() {
return noise_2_6_1_8(vec2(p.x,       p.y      )) *        q.x  *        q.y  +
       noise_2_6_1_8(vec2(p.x,       p.y + r.y)) *        q.x  * (1.0 - q.y) +
       noise_2_6_1_8(vec2(p.x + r.x, p.y      )) * (1.0 - q.x) *        q.y  +
       noise_2_6_1_8(vec2(p.x + r.x, p.y + r.y)) * (1.0 - q.x) * (1.0 - q.y);
}

void main() {
    vec2 t = gl_FragCoord.xy + vec2(t * 10.0);
    float n = noise_2_6(t);
}
```

このように、存在していない **noise_2_6** という関数をsnoise側で呼び出すことになってしまう。

共通化して、使いまわすということをglslではあんまりしないかもですが、browserifyのtransformとして動かすためハマりやすいかもしれない。

## Getting Started

set up the necessary files.

    npm i
    bower i
    bundle install --path vendor/bundle 
    
and

run a gulp

    npm run local
    
if you want to release build.

    npm run product

## Port 4567 is unavailable error.

Port 4567 is unavailable.

    lsof -i -P | grep 4567

    kill -9 <pid>

## Directory Structure

    ├── build
    │   └── build files
    ├── gulp
    │   └── tasks
    ├── node_modules
    └── source
        ├── images
        ├── javascripts
        └── stylesheets

## Author

[hisasann](https://github.com/hisasann)

:arrow_up: enjoy! :arrow_up:
