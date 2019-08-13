// start processing user input
process.stdin.resume();
process.stdin.setEncoding('ascii');
// declare global variables
var input_stdin = "";
var input_stdin_array = "";
// standard input is stored into input_stdin
process.stdin.on('data', function (data) {
    input_stdin += data;
});
// standard input is done and stored into an array
// then main is called so that you can start processing your data
process.stdin.on('end', function () {
    input_stdin_array = input_stdin.split("\n");
    main();
});
// reads a line from the standard input array
// returns string
function readLine(_line_number) {
    return input_stdin_array[_line_number];
}

function parseLine(_textArray){

    var stringArray = _textArray.split(" ");
    var intArray = [];
    for(var i=0;i<stringArray.length;i++){
        intArray.push(parseInt(stringArray[i]));
    }

    return intArray;
}

function matrix_invert(M){
    // I use Guassian Elimination to calculate the inverse:
    // (1) 'augment' the matrix (left) by the identity (on the right)
    // (2) Turn the matrix on the left into the identity by elemetry row ops
    // (3) The matrix on the right is the inverse (was the identity matrix)
    // There are 3 elemtary row ops: (I combine b and c in my code)
    // (a) Swap 2 rows
    // (b) Multiply a row by a scalar
    // (c) Add 2 rows

    //if the matrix isn't square: exit (error)
    if(M.length !== M[0].length){return;}

    //create the identity matrix (I), and a copy (C) of the original
    var i=0, ii=0, j=0, dim=M.length, e=0, t=0;
    var I = [], C = [];
    for(i=0; i<dim; i+=1){
        // Create the row
        I[I.length]=[];
        C[C.length]=[];
        for(j=0; j<dim; j+=1){

            //if we're on the diagonal, put a 1 (for identity)
            if(i==j){ I[i][j] = 1; }
            else{ I[i][j] = 0; }

            // Also, make the copy of the original
            C[i][j] = M[i][j];
        }
    }

    // Perform elementary row operations
    for(i=0; i<dim; i+=1){
        // get the element e on the diagonal
        e = C[i][i];

        // if we have a 0 on the diagonal (we'll need to swap with a lower row)
        if(e==0){
            //look through every row below the i'th row
            for(ii=i+1; ii<dim; ii+=1){
                //if the ii'th row has a non-0 in the i'th col
                if(C[ii][i] != 0){
                    //it would make the diagonal have a non-0 so swap it
                    for(j=0; j<dim; j++){
                        e = C[i][j];       //temp store i'th row
                        C[i][j] = C[ii][j];//replace i'th row by ii'th
                        C[ii][j] = e;      //repace ii'th by temp
                        e = I[i][j];       //temp store i'th row
                        I[i][j] = I[ii][j];//replace i'th row by ii'th
                        I[ii][j] = e;      //repace ii'th by temp
                    }
                    //don't bother checking other rows since we've swapped
                    break;
                }
            }
            //get the new diagonal
            e = C[i][i];
            //if it's still 0, not invertable (error)
            if(e==0){return}
        }

        // Scale this row down by e (so we have a 1 on the diagonal)
        for(j=0; j<dim; j++){
            C[i][j] = C[i][j]/e; //apply to original matrix
            I[i][j] = I[i][j]/e; //apply to identity
        }

        // Subtract this row (scaled appropriately for each row) from ALL of
        // the other rows so that there will be 0's in this column in the
        // rows above and below this one
        for(ii=0; ii<dim; ii++){
            // Only apply to other rows (we want a 1 on the diagonal)
            if(ii==i){continue;}

            // We want to change this element to 0
            e = C[ii][i];

            // Subtract (the row above(or below) scaled by e) from (the
            // current row) but start at the i'th column and assume all the
            // stuff left of diagonal is 0 (which it should be if we made this
            // algorithm correctly)
            for(j=0; j<dim; j++){
                C[ii][j] -= e*C[i][j]; //apply to original matrix
                I[ii][j] -= e*I[i][j]; //apply to identity
            }
        }
    }

    //we've done all operations, C should be the identity
    //matrix I should be the inverse:
    return I;
}

function normalize(vector) {
  var magnitude = 0;
  for(var i = 0; i < vector.length; i++) {
    magnitude += Math.pow(vector[i], 2);
  }
  var univector = [];
  magnitude = Math.sqrt(magnitude);
  for(var i = 0; i < vector.length; i++) {
    univector[i] = vector[i] / magnitude;
  }
  return univector;
}

function initialize(matrix) {
  for(var i = 0; i < 4; i++) {
    matrix[i] = [];
    for(var j = 0; j < 4; j++) {
      matrix[i][j] = 0;
    }
  }
}

function crossProduct(vector_A, vector_B) {
  var cross_P = [];
  cross_P[0] = vector_A[1] * vector_B[2] - vector_A[2] * vector_B[1];
  cross_P[1] = vector_A[2] * vector_B[0] - vector_A[0] * vector_B[2];
  cross_P[2] = vector_A[0] * vector_B[1] - vector_A[1] * vector_B[0];
  return cross_P;
}

function multiply(a, b) {
  var aNumRows = a.length, aNumCols = a[0].length,
      bNumRows = b.length, bNumCols = b[0].length,
      m = new Array(aNumRows);  // initialize array of rows
  for (var r = 0; r < aNumRows; ++r) {
    m[r] = new Array(bNumCols); // initialize the current row
    for (var c = 0; c < bNumCols; ++c) {
      m[r][c] = 0;             // initialize the current cell
      for (var i = 0; i < aNumCols; ++i) {
        m[r][c] += a[r][i] * b[i][c];
      }
    }
  }
  return m;
}

function toMatrix(vector) {
  matrix = [];
  for(var i = 0; i < vector.length; i++) {
    matrix[i] = [];
    matrix[i][0] = vector[i];
  }
  return matrix;
}

function round(matrix) {
  for(var i = 0; i < matrix.length; i++) {
    for(var j = 0; j < matrix[0].length; j++) {
      matrix[i][j] = Math.round(matrix[i][j]);
    }
  }
}

function toString(matrix) {
  var s = "";
  for(var i = 0; i < matrix.length; i++) {
    for(var j = 0; j < matrix[0].length; j++) {
      s += matrix[i][j];
    }
    if(i != matrix.length - 1) {
      s += " ";
    }
  }
  return s;
}

function main() {
  var camera = parseLine(readLine(0));
  var vA = parseLine(readLine(1));
  var vB = parseLine(readLine(2));
  var vC = parseLine(readLine(3));

  var back = normalize(camera);
  var aux_vector = [camera[0], camera[1] + 1, camera[2]];
  var right = normalize(crossProduct(aux_vector, back));
  var up = normalize(crossProduct(back, right));

  var matrix = [];
  initialize(matrix);

  for(var i = 0; i < 3; i++) {
    matrix[i][0] = right[i];
    matrix[i][1] = up[i];
    matrix[i][2] = back[i];
    matrix[i][3] = camera[i];
  }
  matrix[3][3] = 1;
  var inverse = matrix_invert(matrix);

  vA = toMatrix(vA);
  vB = toMatrix(vB);
  vC = toMatrix(vC);

  vA = multiply(inverse, vA);
  vB = multiply(inverse, vB);
  vC = multiply(inverse, vC);

  round(vA);
  round(vB);
  round(vC);

  var s = toString(vA) + "\n" + toString(vB) + "\n" + toString(vC);
  console.log(s);
}
