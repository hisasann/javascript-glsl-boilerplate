precision mediump float;
precision mediump int;

uniform float t;

varying vec4 vColor;

// noise via http://wgld.org/d/glsl/g007.html
#pragma glslify: snoise = require(./common/snoise)
#pragma glslify: noise = require(./common/noise)

void main() {
    // 色のほう
    //gl_FragColor = vColor;

    // noiseのほう
    vec2 t = gl_FragCoord.xy + vec2(t * 10.0);
    float n = noise(t);

    // seamless noise
//	const float map = 256.0;
//	vec2 t = mod(gl_FragCoord.xy + vec2(time * 10.0), map);
//	float n = snoise(t, t / map, vec2(map));

    gl_FragColor = vec4(vec3(n), 1.0);
}