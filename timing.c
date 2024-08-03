#define _POSIX_C_SOURCE 199309L
#include <time.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
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

void time_rdtsc_matrices(double *arr1, double *arr2, double *output) {
    unsigned start = __rdtsc();
    matrices(arr1, arr2, output);
    unsigned end = __rdtsc();
    unsigned elapsed = end - start;
    printf("matrices function calculated in %u cycles.\n", elapsed);
}

void time_rdtsc_matrices_Optimized(double *arr1, double *arr2, double *output) {
    unsigned start = __rdtsc();
    matrices_Optimized(arr1, arr2, output);
    unsigned end = __rdtsc();
    unsigned elapsed = end - start;
    printf("matrices_Optimized function calculated in %u cycles.\n", elapsed);
}

void time_rdtsc_matrices_double(double *arr1, double *arr2, double *output) {
    unsigned start = __rdtsc();
    matrices_double(arr1, arr2, output);
    unsigned end = __rdtsc();
    unsigned elapsed = end - start;
    printf("matrices_double function calculated in %u cycles.\n", elapsed);
}

void time_rdtsc_matrices_double_stack(double *arr1, double *arr2, double *output) {
    unsigned start = __rdtsc();
    matrices_double_stack(arr1, arr2, output);
    unsigned end = __rdtsc();
    unsigned elapsed = end - start;
    printf("matrices_double_stack function calculated in %u cycles.\n", elapsed);
}

void time_gettime_matrices(double *arr1, double *arr2, double *output) {
    struct timespec start, end;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    matrices(arr1, arr2, output);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("matrices function calculated in %g s.\n", elapsed);
}

void time_gettime_matrices_Optimized(double *arr1, double *arr2, double *output) {
    struct timespec start, end;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    matrices_Optimized(arr1, arr2, output);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("matrices_Optimized function calculated in %g s.\n", elapsed);
}

void time_gettime_matrices_double(double *arr1, double *arr2, double *output) {
    struct timespec start, end;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    matrices_double(arr1, arr2, output);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("matrices_double function calculated in %g s.\n", elapsed);
}

void time_gettime_matrices_double_stack(double *arr1, double *arr2, double *output) {
    struct timespec start, end;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    matrices_double_stack(arr1, arr2, output);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("matrices_double_stack function calculated in %g s.\n", elapsed);
}

int main(void) {
    // double matrix1[4] = {2234.543431, 13123.23456, 3123.443412, 93.33333};
    // double matrix2[4] = {4234.14030, 212321.3, 432.44394, 423.21113};
    double matrix1[4] = {2.543431,1.23456,0.443412,3.33333};
    double matrix2[4] = {4.14030,2.3,1.44394,5.21113};

    double normalMatrix[4];
    double normalOptimizedMatrix[4];
    double doubleMatrix[4];
    double doubleMatrixStack[4];

    // Timing with RDTSC
    srand(0);
    time_rdtsc_matrices(matrix1, matrix2, normalMatrix);
    srand(0);
    time_rdtsc_matrices_Optimized(matrix1, matrix2, normalOptimizedMatrix);
    srand(0);
    time_rdtsc_matrices_double(matrix1, matrix2, doubleMatrix);
    srand(0);
    time_rdtsc_matrices_double_stack(matrix1, matrix2, doubleMatrixStack);

    // Timing with clock_gettime
    srand(0);
    time_gettime_matrices(matrix1, matrix2, normalMatrix);
    srand(0);
    time_gettime_matrices_Optimized(matrix1, matrix2, normalOptimizedMatrix);
    srand(0);
    time_gettime_matrices_double(matrix1, matrix2, doubleMatrix);
    srand(0);
    time_gettime_matrices_double_stack(matrix1, matrix2, doubleMatrixStack);

    return 0;
}
