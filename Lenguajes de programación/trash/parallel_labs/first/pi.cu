// Pi Calculation
// By Victor Hugo Torres
// A01701017
#include <stdio.h>
#include <cuda.h>


__global__ void pi_calc(double *sum, long nrects, double width, int  nblocks){
  int tid = blockIdx.x;
	double mid;
  int i;
	for (i=tid; i< nrects; i+=nblocks) {
		mid = (i+0.5)*width;
		sum[tid] += 4.0/(1.0+mid*mid);
	}
}


int main(void) {
  long rects  = 1000000000;
  int blocks = 200;
	double *sum, *d_sum;
	double width = 1.0/rects;
  double pi = 0;
  int index, auxindex;

  sum = (double *)malloc(blocks*sizeof(double));
  cudaMalloc((void **) &d_sum, blocks*sizeof(double));


  for (auxindex = 0; auxindex < blocks; auxindex++){
    sum[auxindex] = 0;
  }

	cudaMemcpy(d_sum, sum, blocks*sizeof(double), cudaMemcpyHostToDevice);

	pi_calc <<<blocks,1>>> (d_sum, rects, width, blocks);

	cudaMemcpy(sum, d_sum, blocks*sizeof(double), cudaMemcpyDeviceToHost);

	for(index=0; index<blocks; index++){
		pi += sum[index];
  }

	pi *= width;


	printf("PI = %f\n",pi);


	free(sum);
	cudaFree(d_sum);

	return 0;
}
