#include <stdio.h>

int diagonalSum(int** mat, int matSize, int matColSize);

int main() {
  int input_matrix[3][3] = {
    {1, 5, 9},
    {7, 9, 7},
    {6, 10, 4}
  };
  size_t n = sizeof(*input_matrix) / sizeof(int);
  int *mat[n];
  int i;
  for (i = 0; i < n; ++i) {
    mat[i] = input_matrix[i];
  }
  int sum = diagonalSum(mat, n, n);
  printf("The diagonal sum of this matrix is %d\n", sum);
  return 0;
}

int diagonalSum(int** mat, int matSize, int matColSize) {
  int i, sum = 0;
  for (i = 0; i < matSize; ++i) {
    sum += mat[i][i] + mat[i][matSize - i - 1];
  }
  if (matSize % 2) {
    sum -= mat[matSize / 2][matSize / 2];
  }
  return sum;
}
  
