#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 10

__global__(int *a, int *b, int *c, N){
  index = thread.idx.x + block
}

void fill_matrix(int *arr){
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      arr[(i * N) + j] = rand() % 10 + 1;;
    }
  }
}

void print_matrix(int *arr){
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      printf("%i\t", arr[(i * N) + j]);
    }
    printf("\n");
  }
}



int main() {
  /* code */
  int matrix[5][5];

  int *arr;
  arr = (int *) malloc(sizeof(int) * N * N);

  srand(time(NULL));   // Initialization, should only be called once.
  fill_matrix(arr);
  print_matrix(arr);

  free(arr);

  return 0;
}
