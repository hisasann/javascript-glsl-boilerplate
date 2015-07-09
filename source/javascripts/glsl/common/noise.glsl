#pragma glslify: irnd = require(./irnd)

const int   oct  = 8;
const float per  = 0.5;

// ノイズ生成
float noise(vec2 p){
    float t = 0.0;
    for(int i = 0; i < oct; i++){
        float freq = pow(2.0, float(i));
        float amp  = pow(per, float(oct - i));
        t += irnd(vec2(p.x / freq, p.y / freq)) * amp;
    }
    return t;
}

#pragma glslify: export(noise)

