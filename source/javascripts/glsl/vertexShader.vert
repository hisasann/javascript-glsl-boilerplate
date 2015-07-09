precision mediump float;        // shader内で使うfloat型のデータの精度を設定
precision mediump int;          // shader内で使うint型のデータの精度を設定

// three.jsが自動的に渡してくれるuniform変数
uniform mat4 modelMatrix;       // モデルの位置や回転、拡大などの情報を保持した行列
uniform mat4 viewMatrix;        // カメラの位置と「どこを向いているか」という情報を保持した行列
uniform mat4 projectionMatrix;  // カメラの画角と描画範囲の情報を保持した行列

uniform float t;                // 経過時間を表す変数

// three.jsが自動的に渡してくれるattribute変数
attribute vec3 position;        // Geometryオブジェクトが保持しているverticesの値
attribute vec3 normal;          // Geometryオブジェクトが保持している各頂点の法線ベクトルの値

attribute float displacement;   // 法線方向にどれだけずらすかを表す変数

varying vec4 vColor;

#pragma glslify: rnd = require(./common/rnd)

void main() {
//    vec3 pos = position + (normal * displacement * sin(t) * 10.0) + vec3(0.0, sin(t) * 1.0, 0.0);
    vec3 pos = position + (normal * displacement * cos(t) * rnd(vec2(100.0)) * 40.0);
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(pos, 1.0);

    vColor = vec4(abs(normal), 1.0);
}