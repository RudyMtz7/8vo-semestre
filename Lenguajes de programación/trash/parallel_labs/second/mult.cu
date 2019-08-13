// Dot Priduct
// By
// Victor Hugo Torres Rivera
// A01701017
#include <stdio.h>
#include <cuda.h>
#include <time.h>
#define NTHREADS 200
#define NBLOCKS 200


__global__ void mat_mult(int *a_mat, int *b_mat, int *r_mat, int a_cols, int a_rows, int b_cols, int b_rows){
  // Get x and y
  int tidx = threadIdx.x + blockIdx.x* blockDim.x;
  int tidy = threadIdx.y + blockIdx.y* blockDim.y;
  // Calculate linear index
  int index = tidx + tidy * a_rows;
  int actual_row = 0;
  int actual_col = 0;
  int aux = 0;
  // If it fits the result matrix calculate
  if(index < b_cols * a_rows){
    // Calculate the actual indexes for a col and b row
    actual_col = index%b_cols;
    actual_row = index/b_cols;
    // Calculate the actual
    for (int i = 0; i < a_cols; i++){
      aux += a_mat[actual_col * a_cols + i] * b_mat [actual_row + b_cols * i];
    }
    r_mat[index] = aux;
  }
}



int main(void){
  // Device Matirxes
  int *d_a_mat, *d_b_mat, *d_r_mat;
  // Host Matrixes
  int *a_mat, *b_mat, *r_mat;
  // Matrixes Size
  int a_cols, b_cols, a_rows, b_rows;


  // Define Matrixes Sizes
  a_cols = 3;
  a_rows = 2;

  b_cols = 2;
  b_rows = a_cols;

  // Matrix Allocations
  // HOST
  a_mat = (int *)malloc(sizeof(int) * a_cols * a_rows);
  b_mat = (int *)malloc(sizeof(int) * b_cols * b_rows);
  r_mat = (int *)malloc(sizeof(int) * b_cols * a_rows);

  // Device
  cudaMalloc((void **)&d_a_mat, sizeof(int) * a_cols * a_rows);
  cudaMalloc((void **)&d_b_mat, sizeof(int) * b_cols * b_rows);
  cudaMalloc((void **)&d_r_mat, sizeof(int) * b_cols * a_rows);

  srand(time(NULL));
  // Fill and Print Matrix A
  printf("A = ");
  for (int i = 0; i < a_cols * a_rows; i ++ ){
    if (i%a_cols == 0){
      printf("\n");
    }
    a_mat[i] = rand() % 20 - 10;
    printf("%i\t", a_mat[i]);
  }

  // Fill And Print Matrix B
  printf("\nB = ");
  for (int i = 0; i < b_cols * b_rows; i++){
    if (i%b_cols == 0){
      printf("\n");
    }
    b_mat[i] = rand() % 20 - 10;
    printf("%i\t", b_mat[i]);
  }


  // Pass values to device
  cudaMemcpy(d_a_mat, a_mat, sizeof(int) * a_cols * a_rows, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b_mat, b_mat, sizeof(int) * b_cols * b_rows, cudaMemcpyHostToDevice);

  dim3 dimThreads(NTHREADS, 1, 1);
  dim3 dimBlocks(NBLOCKS, 1, 1);

  // Call Kernel function
  mat_mult<<<dimBlocks, dimThreads>>>(d_a_mat, d_b_mat, d_r_mat, a_cols, a_rows, b_cols, b_rows);

  cudaMemcpy(r_mat, d_r_mat, sizeof(int) * a_rows * b_cols, cudaMemcpyDeviceToHost);

  // Print Result Matrix
  printf("\nR = ");
  for (int i = 0; i < b_cols * a_rows; i++){
    if (i%b_cols == 0){
      printf("\n");
    }
    printf("%i\t", r_mat[i]);
  }
  printf("\n");

  // Free Memory
  free(a_mat);
  free(b_mat);
  free(r_mat);
  cudaFree(d_a_mat);
  cudaFree(d_b_mat);
  cudaFree(d_r_mat);
}
