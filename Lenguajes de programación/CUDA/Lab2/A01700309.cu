//Señor Doctor Profesor Rodolfo Martínez Guevara
//A01700309

#include <stdio.h>
#include <cuda.h>
#include <time.h>
#define N_THREADS 200
#define N_BLOCKS 200


__global__ void multiplication(int *matrix_a, int *matrix_b, int *result_matrix, int cols_a, int rows_a, int cols_b, int rows_b){
  //Generate the index for each dimension of the matrix
  int tidx = threadIdx.x + blockIdx.x* blockDim.x;
  //Clean :^)
  int tidy = threadIdx.y + blockIdx.y* blockDim.y;
  //Get the global index
  int index = tidx + tidy * rows_a;
  int current_row = 0;
  int current_col = 0;
  int aux = 0;
  //While the index fits the resultant matrix
  if(index < cols_b * rows_a){
    //Generate the index of the result matrix
    current_col = index/cols_b;
    current_row = index%cols_b;
    //Calculate value for this position
    for (int i = 0; i < cols_a; i++){
      aux += matrix_a[current_col * cols_a + i] * matrix_b [current_row + cols_b * i];
    }
    result_matrix[index] = aux;
  }
}



int main(void){
  //Matrixes in device
  int *d_matrix_a, *d_matrix_b, *d_result_matrix;
  //Matrixes in CPU
  int *matrix_a, *matrix_b, *result_matrix;
  //Number of cols and rows for each matrix
  int cols_a, cols_b, rows_a, rows_b;
  //Auxiliar variables
  int aux_a, aux_b;

  //Get matrix dimensions
  printf("Cols in A: \n");
  scanf("%i", &cols_a);
  printf("Rows in A: \n");
  scanf("%i", &rows_a);

  printf("Cols in B: \n");
  scanf("%i", &cols_b);
  printf("Rows in B: \n");
  scanf("%i", &rows_b);

  //Validate if it's a posible operation
  if(rows_a != cols_b){
    printf("Number of rows in A must match cols in B\n");
    //Terminate program if operation is impossible
    return 0;
  }

  //Allocate memory in CPU
  matrix_a = (int *)malloc(sizeof(int) * cols_a * rows_a);
  matrix_b = (int *)malloc(sizeof(int) * cols_b * rows_b);
  result_matrix = (int *)malloc(sizeof(int) * cols_b * rows_a);

  //Allocate memory in device
  cudaMalloc((void **)&d_matrix_a, sizeof(int) * cols_a * rows_a);
  cudaMalloc((void **)&d_matrix_b, sizeof(int) * cols_b * rows_b);
  cudaMalloc((void **)&d_result_matrix, sizeof(int) * cols_b * rows_a);

  //Get values of Matrix A
  printf("A = ");
  for (int i = 0; i < cols_a * rows_a; i ++ ){
    if (i%cols_a == 0){
      printf("\n");
    }
    printf("Enter value %i for matrix A: \n", i+1);
    scanf("%i", &aux_a);
    matrix_a[i] = aux_a;
  }

  //Get values of Matrix B
  printf("\nB = ");
  for (int i = 0; i < cols_b * rows_b; i ++ ){
    if (i%cols_a == 0){
      printf("\n");
    }
    printf("Enter value %i for matrix B: \n", i+1);
    scanf("%i", &aux_b);
    matrix_b[i] = aux_b;
  }

  //Copy values to device variables
  cudaMemcpy(d_matrix_a, matrix_a, sizeof(int) * cols_a * rows_a, cudaMemcpyHostToDevice);
  cudaMemcpy(d_matrix_b, matrix_b, sizeof(int) * cols_b * rows_b, cudaMemcpyHostToDevice);

  dim3 dimThreads(N_THREADS, 1, 1);
  dim3 dimBlocks(N_BLOCKS, 1, 1);

  //Execute global function in device
  multiplication<<<dimBlocks, dimThreads>>>(d_matrix_a, d_matrix_b, d_result_matrix, cols_a, rows_a, cols_b, rows_b);

  //Retrieve Result Matrix from device
  cudaMemcpy(result_matrix, d_result_matrix, sizeof(int) * rows_a * cols_b, cudaMemcpyDeviceToHost);

  //Print Result Matrix
  printf("\nR = ");
  for (int i = 0; i < cols_b * rows_a; i++){
    if (i%cols_b == 0){
      printf("\n");
    }
    printf("%i\t", result_matrix[i]);
  }
  printf("\n");

  //Free Memory
  free(matrix_a);
  free(matrix_b);
  free(result_matrix);
  cudaFree(d_matrix_a);
  cudaFree(d_matrix_b);
  cudaFree(d_result_matrix);
}
