var scene;
var camera;
initializeScene();
renderScene();


function initializeScene(){
  if(Detector.webgl){
    renderer = new THREE.WebGLRenderer( { antialias: true} );
  }else{
    renderer = new THREE.CanvasRenderer();
  }

  renderer.setClearColor(0x000000, 1);

  canvasWidth = 600;
  canvasHeight = 400;

  renderer.setSize(canvasWidth, canvasHeight);

  document.getElementById("canvas").appendChild(renderer.domElement);

  scene = new THREE.Scene();

  camera = new THREE.PerspectiveCamera(45, canvasWidth/canvasHeight, 1, 100);

  camera.position.set(0, 0, 10);

  camera.lookAt(scene.position);

  scene.add(camera);

  rainbowCircleGeometry = new THREE.Geometry();

  var black = new THREE.Color('#000000');
  var red = new THREE.Color('#f40202');
  var orange = new THREE.Color('#f49702');
  var yellow = new THREE.Color('#f4db02');
  var green = new THREE.Color('#52f402');
  var blue = new THREE.Color('#0222f4');
  var indigo = new THREE.Color('#4b0082')
  var pink = new THREE.Color('#FF12FF')

  //We rotate around the circle incrementally, adding vertices outward to one "spoke" at a time.
  for( var d=0; d<361; d++ ) {
    var angle =  Math.PI*(d/180);

    //We use the sine and cosine of the angle to arrive at the innermost vertex.
    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle), Math.cos(angle), 0));
    //We don't start building faces until we've completed at least one spoke of the wheel.
    if(rainbowCircleGeometry.vertices.length > 3) {
      //Think about which vertices to add to the face.
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
        rainbowCircleGeometry.vertices.length - 9,
        rainbowCircleGeometry.vertices.length));

      //Here we create vertex colors for each face, one vertex at a time.
      //Think about which colors should go with each vertex to obtain the results you want.
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = black;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = red;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = red;
    }

    //This is the next vertex out. Because it's the middle vertex on the spoke, it's
    //part of two different faces.
    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*0.5, Math.cos(angle)*0.5, 0));
    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
        rainbowCircleGeometry.vertices.length - 9,
        rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = red;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = orange;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = orange;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
        rainbowCircleGeometry.vertices.length,
        rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = red;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = orange;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = red;
    }

    //This is the third vertex of the spoke, i.e. the outermost. Like the inner vertex, it is only associated
    //with a single face.
    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*1, Math.cos(angle)*1, 0));
    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
	    rainbowCircleGeometry.vertices.length - 10,
	    rainbowCircleGeometry.vertices.length - 9,
  	    rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = orange;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = yellow;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = yellow;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
		rainbowCircleGeometry.vertices.length,
		rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = orange;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = yellow;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = orange;
	}

    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*1.5, Math.cos(angle)*1.5, 0));

    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
		rainbowCircleGeometry.vertices.length - 9,
		rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = yellow;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = green;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = green;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
		rainbowCircleGeometry.vertices.length,
		rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = yellow;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = green;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = yellow;
    }

    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*2, Math.cos(angle)*2, 0));

    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
  	    rainbowCircleGeometry.vertices.length - 9,
  	    rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = green;
  	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = blue;
  	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = blue;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
  	    rainbowCircleGeometry.vertices.length,
  	    rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = green;
  	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = blue;
  	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = green;
    }

  	rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*2.7, Math.cos(angle)*2.7, 0));

    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
  	    rainbowCircleGeometry.vertices.length - 9,
  	    rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = blue;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = blue;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = blue;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
  	    rainbowCircleGeometry.vertices.length,
  	    rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = blue;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = blue;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = blue;
    }

     rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*3, Math.cos(angle)*3, 0));

     if(rainbowCircleGeometry.vertices.length > 3) {
       rainbowCircleGeometry.faces.push(new THREE.Face3(
         rainbowCircleGeometry.vertices.length - 10,
         rainbowCircleGeometry.vertices.length - 9,
         rainbowCircleGeometry.vertices.length));

       rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = blue;
       rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = indigo;
       rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = indigo;

       rainbowCircleGeometry.faces.push(new THREE.Face3(
         rainbowCircleGeometry.vertices.length - 10,
		 rainbowCircleGeometry.vertices.length,
		 rainbowCircleGeometry.vertices.length - 1));

       rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = blue;
	   rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = indigo;
	   rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = blue;
    }

    rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*3.3, Math.cos(angle)*3.3, 0));

    if(rainbowCircleGeometry.vertices.length > 3) {
      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
		rainbowCircleGeometry.vertices.length - 9,
		rainbowCircleGeometry.vertices.length));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = indigo;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = black;
	  rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = black;

      rainbowCircleGeometry.faces.push(new THREE.Face3(
        rainbowCircleGeometry.vertices.length - 10,
		rainbowCircleGeometry.vertices.length,
		rainbowCircleGeometry.vertices.length - 1));

      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[0] = indigo;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[1] = black;
      rainbowCircleGeometry.faces[rainbowCircleGeometry.faces.length - 1].vertexColors[2] = indigo;
    }

   rainbowCircleGeometry.vertices.push(new THREE.Vector3(Math.sin(angle)*4.2, Math.cos(angle)*4.2, 0));
  }

  var rainbowCircleMat = new THREE.MeshBasicMaterial({
    vertexColors:THREE.VertexColors,
    //wireframe: true,
    side:THREE.DoubleSide});

  var rainbowCircleMesh = new THREE.Mesh(rainbowCircleGeometry, rainbowCircleMat);

  scene.add(rainbowCircleMesh);
}


function renderScene(){
  renderer.render(scene, camera);
}
