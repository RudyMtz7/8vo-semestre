var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock;
var keyBoard = new KeyboardState;

function fillScene() {
    scene = new THREE.Scene;
    scene.fog = new THREE.Fog(8421504, 2e3, 4e3);
    scene.add(new THREE.AmbientLight(2236962));
    light = new THREE.DirectionalLight(16777215, .7);
    light.position.set(200, 500, 500);
    scene.add(light);
    light = new THREE.DirectionalLight(16777215, .9);
    light.position.set(-200, -100, -400);
    scene.add(light);
    gridXZ = new THREE.GridHelper(2e3, 100, new THREE.Color(13421772), new THREE.Color(8947848));
    scene.add(gridXZ);
    axes = new THREE.AxisHelper(150);
    axes.position.y = 1;
    scene.add(axes);
    drawRobot()
}

function drawRobot() {
    var basicMaterial = new THREE.MeshPhongMaterial({
        side: THREE.DoubleSide,
        color: 16711680,
        emissive: 16711680,
        emissiveIntensity: 5,
        emissiveMap: scene.background,
        envMap: scene.background,
        wireframe: false
    });
    var materialBrilla = new THREE.MeshPhongMaterial({
        side: THREE.DoubleSide,
        color: 4914687
    });
    var materialOscuro = new THREE.MeshLambertMaterial({
        side: THREE.DoubleSide,
        color: 287693
    });
    var glassMaterial = new THREE.MeshPhongMaterial({
        color: 16777215,
        shininess: 100,
        transparent: true,
        opacity: .4,
        envMap: scene.background,
        combine: THREE.MixOperation,
        reflectivity: .8
    });
    var greyMaterial = new THREE.MeshPhongMaterial({
        color: 6916246,
        shininess: 100,
        transparent: false,
        envMap: scene.background,
        combine: THREE.MixOperation,
        reflectivity: .8
    });
    var options = {
        amount: 10,
        bevelThickness: 2,
        bevelSize: 1,
        bevelSegments: 3,
        bevelEnabled: true,
        curveSegments: 12,
        steps: 1,
        material: ojoMaterial
    };
    var cuerpo, pierna;
    cuerpo = new THREE.Mesh(new THREE.BoxGeometry(45, 70, 80), materialBrilla);
    cuerpo.position.x = 0;
    cuerpo.position.y = 265;
    cuerpo.position.z = 0;
    scene.add(cuerpo);
    var cadera;
    cadera = new THREE.Mesh(new THREE.SphereGeometry(20, 20, 20), materialOscuro);
    cadera.position.x = 0;
    cadera.position.y = 215;
    cadera.position.z = 0;
    scene.add(cadera);
    var cintura;
    cintura = new THREE.Mesh(new THREE.BoxGeometry(50, 30, 80), materialBrilla);
    cintura.position.x = 0;
    cintura.position.y = 190;
    cintura.position.z = 0;
    scene.add(cintura);
    var pierna1, pierna2, pierna1Geometry, pierna2Geometry, piernaMaterial;
    pierna1Geometry = new THREE.BoxGeometry(25, 50, 10);
    pierna2Geometry = new THREE.BoxGeometry(25, 50, 10);
    piernaMaterial = materialOscuro;
    pierna1 = new THREE.Mesh(pierna1Geometry, piernaMaterial);
    pierna2 = new THREE.Mesh(pierna2Geometry, piernaMaterial);
    var piernaIzquierda, piernaDerecha;
    piernaIzquierda = pierna1.clone();
    piernaDerecha = pierna1.clone();
    piernaIzquierdaBaja = pierna2.clone();
    piernaDerechaBaja = pierna2.clone();
    piernaIzquierda.position.x = 0;
    piernaIzquierda.position.y = -50;
    piernaIzquierda.position.z = 0;
    scene.add(piernaIzquierda);
    piernaDerecha.position.x = 0;
    piernaDerecha.position.y = -50;
    piernaDerecha.position.z = 0;
    scene.add(piernaDerecha);
    piernaIzquierdaBaja.position.x = 0;
    piernaIzquierdaBaja.position.y = 0;
    piernaIzquierdaBaja.position.z = 0;
    scene.add(piernaIzquierdaBaja);
    piernaDerechaBaja.position.x = 0;
    piernaDerechaBaja.position.y = 0;
    piernaDerechaBaja.position.z = 0;
    scene.add(piernaDerechaBaja);
    var rodillaDerecha, rodillaIzquierda;
    rodillaDerecha = new THREE.Mesh(new THREE.SphereGeometry(19, 19, 19), materialBrilla);
    rodillaDerecha.position.x = 0;
    rodillaDerecha.position.y = -20;
    rodillaDerecha.position.z = 0;
    scene.add(rodillaDerecha);
    rodillaIzquierda = new THREE.Mesh(new THREE.SphereGeometry(19, 19, 19), materialBrilla);
    rodillaIzquierda.position.x = 0;
    rodillaIzquierda.position.y = -20;
    rodillaIzquierda.position.z = -0;
    scene.add(rodillaIzquierda);
    var pieLength = 30;
    var pieWidth = 30;
    var forma_pie = new THREE.Shape;
    forma_pie.moveTo(0, 0);
    forma_pie.lineTo(0, pieWidth);
    forma_pie.lineTo(pieLength, pieWidth);
    forma_pie.lineTo(pieLength, 0);
    forma_pie.lineTo(0, 0);
    var extrudeSettings = {
        steps: 2,
        amount: 10,
        bevelEnabled: true,
        bevelThickness: 3,
        bevelSize: 5,
        bevelSegments: 1
    };
    var geometry = new THREE.ExtrudeGeometry(forma_pie, extrudeSettings);
    var material = materialBrilla;
    var pie = new THREE.Mesh(geometry, material);
    pie.rotateX(Math.PI / 2);
    var pieIzquierdo = pie.clone();
    pieIzquierdo.position.x = -10;
    pieIzquierdo.position.y = -80;
    pieIzquierdo.position.z = -15;
    var pieDerecho = pie.clone();
    pieDerecho.position.x = -10;
    pieDerecho.position.y = -80;
    pieDerecho.position.z = -15;
    scene.add(pieIzquierdo);
    scene.add(pieDerecho);
    var cuello, cuelloGeometry, cuelloMaterial;
    cuelloGeometry = new THREE.BoxGeometry(15, 30, 30);
    cuelloMaterial = materialOscuro;
    cuello = new THREE.Mesh(cuelloGeometry, cuelloMaterial);
    cuello.position.x = 0;
    cuello.position.y = 315;
    cuello.position.z = 0;
    scene.add(cuello);
    var cabeza, cabezaGeometry, cabezaMaterial;
    cabezaGeometry = new THREE.SphereGeometry(40, 40, 40);
    cabezaMaterial = materialBrilla;
    cabeza = new THREE.Mesh(cabezaGeometry, cabezaMaterial);
    cabeza.position.x = 0;
    cabeza.position.y = 0;
    cabeza.position.z = 0;
    scene.add(cabeza);
    var ojo, ojoGeometry, ojoMaterial;
    ojoGeometry = new THREE.SphereGeometry(14, 14, 14);
    ojoMaterial = glassMaterial;
    ojo = new THREE.Mesh(ojoGeometry, ojoMaterial);
    var ojoIzquierdo, ojoDerecho;
    ojoIzquierdo = ojo.clone();
    ojoDerecho = ojo.clone();
    ojoIzquierdo.position.x = 32;
    ojoIzquierdo.position.y = 5;
    ojoIzquierdo.position.z = -17;
    ojoDerecho.position.x = 32;
    ojoDerecho.position.y = 5;
    ojoDerecho.position.z = 17;
    scene.add(ojoIzquierdo);
    scene.add(ojoDerecho);
    hombroDerecho = new THREE.Mesh(new THREE.BoxGeometry(35, 35, 40), materialOscuro);
    hombroDerecho.position.x = 0;
    hombroDerecho.position.y = -30;
    hombroDerecho.position.z = -10;
    scene.add(hombroDerecho);
    hombroIzquierdo = new THREE.Mesh(new THREE.BoxGeometry(35, 35, 40), materialOscuro);
    hombroIzquierdo.position.x = 0;
    hombroIzquierdo.position.y = -30;
    hombroIzquierdo.position.z = 10;
    scene.add(hombroIzquierdo);
    anteBrazoDerecho = new THREE.Mesh(new THREE.BoxGeometry(10, 40, 10), materialBrilla);
    anteBrazoDerecho.position.x = 0;
    anteBrazoDerecho.position.y = -50;
    anteBrazoDerecho.position.z = 0;
    scene.add(anteBrazoDerecho);
    anteBrazoIzquierdo = new THREE.Mesh(new THREE.BoxGeometry(10, 40, 10), materialBrilla);
    anteBrazoIzquierdo.position.x = 0;
    anteBrazoIzquierdo.position.y = -50;
    anteBrazoIzquierdo.position.z = 0;
    scene.add(anteBrazoIzquierdo);
    codoIzquierdo = new THREE.Mesh(new THREE.SphereGeometry(12, 12, 12), materialOscuro);
    codoIzquierdo.position.x = 1;
    codoIzquierdo.position.y = -75;
    codoIzquierdo.position.z = 0;
    scene.add(codoIzquierdo);
    codoDerecho = new THREE.Mesh(new THREE.SphereGeometry(12, 12, 12), materialOscuro);
    codoDerecho.position.x = 1;
    codoDerecho.position.y = -75;
    codoDerecho.position.z = 0;
    scene.add(codoDerecho);
    brazoDerecho = new THREE.Mesh(new THREE.BoxGeometry(10, 40, 10), materialBrilla);
    brazoDerecho.position.x = 1;
    brazoDerecho.position.y = -100;
    brazoDerecho.position.z = 1;
    scene.add(brazoDerecho);
    brazoIzquierdo = new THREE.Mesh(new THREE.BoxGeometry(10, 40, 10), materialBrilla);
    brazoIzquierdo.position.x = 1;
    brazoIzquierdo.position.y = -100;
    brazoIzquierdo.position.z = 1;
    scene.add(brazoIzquierdo);
    figuraDeAccionDerecha = new THREE.Mesh(new THREE.SphereGeometry(12, 12, 12), materialOscuro);
    figuraDeAccionDerecha.position.x = 0;
    figuraDeAccionDerecha.position.y = -120;
    figuraDeAccionDerecha.position.z = 0;
    scene.add(figuraDeAccionDerecha);
    figuraDeAccionIzquierda = new THREE.Mesh(new THREE.SphereGeometry(12, 12, 12), materialOscuro);
    figuraDeAccionIzquierda.position.x = 0;
    figuraDeAccionIzquierda.position.y = -120;
    figuraDeAccionIzquierda.position.z = 0;
    scene.add(figuraDeAccionIzquierda);
    anteBrazoIzquierdoAnidado = (new THREE.Group).add(brazoIzquierdo).add(codoIzquierdo).add(figuraDeAccionIzquierda);
    anteBrazoDerechoAnidado = (new THREE.Group).add(brazoDerecho).add(codoDerecho).add(figuraDeAccionDerecha);
    brazoIzquierdoAnidado = (new THREE.Group).add(anteBrazoIzquierdoAnidado).add(anteBrazoIzquierdo).add(hombroIzquierdo);
    brazoDerechoAnidado = (new THREE.Group).add(anteBrazoDerechoAnidado).add(anteBrazoDerecho).add(hombroDerecho);
    robotOjos = (new THREE.Group).add(ojoIzquierdo).add(ojoDerecho);
    robotCabeza = (new THREE.Group).add(cabeza).add(robotOjos);
    robotCuerpo = (new THREE.Group).add(cuello).add(cuerpo).add(cintura).add(cadera);
    robotpieIzquierdo = (new THREE.Group).add(piernaIzquierda).add(piernaIzquierdaBaja).add(pieIzquierdo).add(rodillaIzquierda);
    robotpieDerecho = (new THREE.Group).add(piernaDerecha).add(piernaDerechaBaja).add(pieDerecho).add(rodillaDerecha);
    robot = (new THREE.Group).add(robotCabeza).add(robotCuerpo).add(robotpieIzquierdo).add(robotpieDerecho).add(brazoIzquierdoAnidado).add(brazoDerechoAnidado);
    innerGroup = (new THREE.Group).add(robot);
    outerGroup = (new THREE.Group).add(innerGroup);
    robotpieIzquierdo.position.set(0, 150, -25);
    robotpieDerecho.position.set(0, 150, 25);
    anteBrazoIzquierdoAnidado.position.set(0, 0, 0);
    brazoIzquierdoAnidado.position.set(0, 300, -60);
    brazoDerechoAnidado.position.set(0, 300, 60);
    anteBrazoDerechoAnidado.position.set(0, 0, 0);
    robotCabeza.position.set(0, 355, 0);
    robot.position.set(0, 0, 0);
    scene.add(outerGroup)
}

function animate() {
    keyBoard.update();
    var velocidad = 5;
    var rotateSpeed = 3;
    rotateSpeed *= Math.PI / 180;
    var forward = new THREE.Vector3(1, 0, 0);
    forward.applyQuaternion(innerGroup.quaternion).normalize();
    if (keyBoard.pressed("W")) {
        outerGroup.translateOnAxis(forward, velocidad)
    }
    if (keyBoard.pressed("S")) {
        outerGroup.translateOnAxis(forward.multiplyScalar(-1), velocidad)
    }
    if (keyBoard.pressed("A")) {
        outerGroup.rotateY(rotateSpeed)
    }
    if (keyBoard.pressed("D")) {
        outerGroup.rotateY(-rotateSpeed)
    }
    if (keyBoard.pressed("W") || keyBoard.pressed("A") || keyBoard.pressed("S") || keyBoard.pressed("D")) {
        baila()
    }
    window.requestAnimationFrame(animate);
    render()
}
var contador = 0;

function baila() {
    contador = contador == 360 ? 1 : ++contador;
    contador += 1;
    robotpieIzquierdo.rotation.z = Math.cos(contador * (Math.PI / 180));
    robotpieDerecho.rotation.z = Math.cos(contador * (Math.PI / 180) + Math.PI);
    brazoDerechoAnidado.rotation.z = Math.cos(contador * (Math.PI / 180));
    brazoIzquierdoAnidado.rotation.z = Math.cos(contador * (Math.PI / 180) + Math.PI)
}

function init() {
    var canvasWidth = 600;
    var canvasHeight = 400;
    var canvasRatio = canvasWidth / canvasHeight;
    renderer = new THREE.WebGLRenderer({
        antialias: true
    });
    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.setSize(canvasWidth, canvasHeight);
    renderer.setClearColor(11184810, 1);
    camera = new THREE.PerspectiveCamera(45, canvasRatio, 1, 4e3);
    cameraControls = new THREE.OrbitControls(camera, renderer.domElement);
    camera.position.set(-800, 600, -500);
    cameraControls.target.set(4, 301, 92)
}

function addToDOM() {
    var canvas = document.getElementById("canvas");
    canvas.appendChild(renderer.domElement)
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);
    renderer.render(scene, camera)
}
try {
    init();
    fillScene();
    addToDOM();
    animate()
} catch (error) {
    console.log("Your program encountered an unrecoverable error, can not draw on canvas. Error was:");
    console.log(error)
}
