//Rodolfo Martinez Guevara
// template provided for cuda quizz 3.
// remember to write your own comments in the code below.

#include <stdio.h>
#define N 9		//size of original matrix
#define K N/3		//size of compressed matrrix
#define ThreadsPerBlock 1 		 // choose wisely
#define NumBlocks N  		// choose wisely

__global__ void compress(float *mat, int n, float *comp, int k){
  int tidx = threadIdx.x + blockIdx.x * blockDim.x;
  int tidy = threadIdx.y + blockIdx.y * blockDim.y;
  int index = tidx + tidy * n;
  int aux = 0;

  int current_col = 0;
  int current_row = 0;

  if(index < n){
    current_col = index/k;
    current_row = index%n;

    for (int i = 0; i < k; i++){
      for (int j = 0; j < k; j++){
        aux += mat[i*(current_row*current_col)+j];
      }
    }
    comp[index] = aux;
  }
}

void print_mat(float *mat, int n){
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			printf("%.1f\t", mat[i*n+j]);
		}
		printf("\n");
	}
	printf("\n");
}


void fill_mat(float *mat, int n){
	int c = 0;
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			mat[i*n+j] = c++;
		}
	}
}

int main(){
	float *h_compress, *h_matrix;
	float *d_compress, *d_matrix;

	h_compress = (float *)malloc(sizeof(float)*K*K);
	h_matrix = (float *)malloc(sizeof(float)*N*N);

  cudaMalloc((void **)&d_matrix, sizeof(float)*N*N);
  cudaMalloc((void **)&d_compress, sizeof(float)*K*K);

	fill_mat(h_matrix, N);
	// fill_mat(h_compress, K);

	printf("\n input mat \n");
	print_mat(h_matrix, N);

  cudaMemcpy(d_matrix, h_matrix, sizeof(float)*N*N, cudaMemcpyHostToDevice);

  dim3 dimThreads(ThreadsPerBlock, 1,1);
  dim3 dimBlocks(NumBlocks, 1,1);

  compress<<<dimBlocks, dimThreads>>>(d_matrix, N, d_compress, K);

  cudaMemcpy(h_compress, d_compress, sizeof(float)*K*K, cudaMemcpyDeviceToHost);

  printf("\n input compress \n");
  print_mat(h_compress, K);

  free(h_matrix);
  free(h_compress);
  cudaFree(d_matrix);
  cudaFree(d_compress);


}
