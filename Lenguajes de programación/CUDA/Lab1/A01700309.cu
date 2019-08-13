//Rodolfo Martínez Guevara A01700309

#include <stdio.h>
#include <cuda.h>


//Define constant variables for threads per block, total rectangles, total
//blocks
#define THREADS_PER_BLOCK 512
#define RECTANGLES 1000000
#define BLOCKS 1000


//Cuda function to calculate sum in device
__global__ void calculatePi(double *sum, double width){
  //Get current total index value
  int tid = threadIdx.x + (blockIdx.x * blockDim.x);
	double mid, height;
  //Interal iteration value
  int i = tid;
  while(i < RECTANGLES){
    mid = (i + 0.5) * width;
    height = 4.0 / (1.0 + mid * mid);
    sum[tid] += height;
    //Skips total thread ammount so each block carries out the required
    //operations
    i = i + BLOCKS*THREADS_PER_BLOCK;
  }
}


int main(void) {
  //Define variables
	double *sum;
	double *sumAux;
  double width, area;
  width = 1.0/ (double) RECTANGLES;
  double aux = 0;

  //Create arrays for sum operations
  sum = (double *)malloc(BLOCKS*THREADS_PER_BLOCK*sizeof(double));
  //Device array for operation
  cudaMalloc((void **) &sumAux, BLOCKS*THREADS_PER_BLOCK*sizeof(double));

  //Copy array to device array variable with given length of total threads
	cudaMemcpy(sumAux, sum, BLOCKS*THREADS_PER_BLOCK*sizeof(double), cudaMemcpyHostToDevice);

  //Call cuda function with given blocks and threads
	calculatePi<<<BLOCKS, THREADS_PER_BLOCK>>> (sumAux, width);

  //Copy values obtained from cuda function
	cudaMemcpy(sum, sumAux, BLOCKS*THREADS_PER_BLOCK*sizeof(double), cudaMemcpyDeviceToHost);

  //Returns total sum in a single variable
  for(int i=0; i < BLOCKS*THREADS_PER_BLOCK; i++){
		aux += sum[i];
  }
  // printf("sum = %lf\n",aux);
  //Calculates Pi
	area = width * aux;

	printf("Pi: %lf\n",area);

  free(sum);
	cudaFree(sumAux);

	return 0;
}
