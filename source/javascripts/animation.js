var glslify = require('glslify');

var vert = glslify(__dirname + '/glsl/vertexShader.vert');
var frag = glslify(__dirname + '/glsl/fragmentShader.frag');

function animation() {
  var width = window.innerWidth;
  var height = window.innerHeight;

  var scene = new THREE.Scene();

  var fov = 60;
  var aspect = width / height;
  var near = 1;
  var far = 10000;
  var camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
  scene.add(camera);

  var mat = new THREE.RawShaderMaterial({
    vertexShader: vert,
    fragmentShader: frag,
    uniforms: {
      t : { type : 'f', value : 0.0 }
    },
    attributes : {
      displacement : { type : 'f', value : [] }
    }
  });

  var geometry = new THREE.SphereGeometry(1, 32, 32);

  mat.attributes.displacement.value = geometry.vertices.map(function(v) {
    return (Math.random() - 0.5) * 0.1;
  });

  var box = new THREE.Mesh(geometry, mat);
  scene.add(box);

  box.scale.set(45, 45, 45);
  box.position.set(0, 0, - 120);

  var renderer = new THREE.WebGLRenderer();
  renderer.setSize(width, height);
  document.body.appendChild(renderer.domElement);

  var clock = new THREE.Clock();

  (function loop() {
    var q = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(0, 1, 0), clock.elapsedTime);
    box.rotation.setFromQuaternion(q);

    clock.getDelta(); // update clock

    mat.uniforms.t.value = clock.elapsedTime * 2.0;
    //mat.uniforms.t.value = clock.elapsedTime * (Math.random() + 2.0);
    //mat.uniforms.t.value = clock.elapsedTime * 5.0;

    renderer.render(scene, camera);
    requestAnimationFrame(loop);
  })();
}

export default animation;