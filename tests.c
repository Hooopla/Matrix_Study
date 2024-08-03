#include <stdio.h>
#include "lab13.h"

void matrices(double *arr1, double *arr2, double *output) {
  // Calculation for finalMatrix[0]
  double tempA = (arr1[0] * arr2[0]) + (arr1[1] * arr2[2]); 
  output[0] = tempA;

  // Calculation for finalMatrix[1]
  double tempB = (arr1[0] * arr2[1]) + (arr1[1] * arr2[3]);
  output[1] = tempB;
  
  // Calculation for finalMatrix[2]
  double tempC = (arr1[2] * arr2[0]) + (arr1[3] * arr2[2]);
  output[2] = tempC;

  // Calculation for finalMatrix[3]
  double tempD = (arr1[2] * arr2[1]) + (arr1[3] * arr2[3]);
  output[3] = tempD;
}

__attribute__((optimize("-funsafe-math-optimizations")))
void matrices_Optimized(double *arr1, double *arr2, double *output) {
  // Calculation for finalMatrix[0]
  double tempA = (arr1[0] * arr2[0]) + (arr1[1] * arr2[2]); 
  output[0] = tempA;

  // Calculation for finalMatrix[1]
  double tempB = (arr1[0] * arr2[1]) + (arr1[1] * arr2[3]);
  output[1] = tempB;
  
  // Calculation for finalMatrix[2]
  double tempC = (arr1[2] * arr2[0]) + (arr1[3] * arr2[2]);
  output[2] = tempC;

  // Calculation for finalMatrix[3]
  double tempD = (arr1[2] * arr2[1]) + (arr1[3] * arr2[3]);
  output[3] = tempD;
}
int main(void) {
  uint64_t size = 4;
  double matrix1[4] = {2.543431,1.23456,0.443412,3.33333};
  double matrix2[4] = {4.14030,2.3,1.44394,5.21113};

  double normalMatrix[4];
  double normalOptimizedMatrix[4];
  double doubleMatrix[4];
  double doubleMatrixStack[4];

  // Printing elements of matrix 1 
  printf("matrix1: ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ", matrix1[i]);
  }
  printf("\n");

  // Printing elements of matrix 2
  printf("matrix2: ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ", matrix2[i]);
  }
  printf("\n");
  printf("\n");
  printf("\n");


  // Normal Implementation
  matrices(matrix1, matrix2, normalMatrix);
  printf("C Implementation Results: ");
  printf("{ ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ",normalMatrix[i]);
  }
  printf("} \n");

  // Optimized Implementation
  matrices_Optimized(matrix1, matrix2, normalOptimizedMatrix);
  printf("C Optimized Implementation Results: ");
  printf("{ ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ",normalMatrix[i]);
  }
  printf("} \n");


  // Assembly Version
  matrices_double(matrix1, matrix2, doubleMatrix);
  printf("Assembly Double Results: ");
  printf("{ ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ",doubleMatrix[i]);
  }
  printf("} \n");

    // Assembly Version
  matrices_double_stack(matrix1, matrix2, doubleMatrixStack);
  printf("Assembly Stack Double Results: ");
  printf("{ ");
  for (uint64_t i = 0; i < size; i++) {
    printf("%f ",doubleMatrixStack[i]);
  }
  printf("} \n");

  return 0;
}