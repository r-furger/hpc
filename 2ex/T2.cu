#define N 1024 // number of rows = number of columns
#include <stdio.h>
__global__ void matrix_mult_kernel (int *a, int *b, int *c, int width);
void init(int * input,int length);
void print_matrix(int * matrix, int size);
int main()
{
 	int * h_a,*d_a;
 	int * h_b,*d_b;
 	int * h_c,*d_c;
 	int data_length = N * N * sizeof(int);
 	h_a=(int*)malloc(data_length);
 	h_b=(int*)malloc(data_length);
 	h_c=(int*)malloc(data_length);
 
 	init(h_a,N*N);
 	init(h_b,N*N);

 	// TODO: Allocate the matrix d_a, d_b, and d_c at the device memory
 	cudaError err = cudaGetLastError();
    if ( cudaSuccess != err )
    {
    printf("cudaCheckError() failed : %s\n", cudaGetErrorString( err ) );
            exit( -1 );
    }
 	
    // TODO: Copy input matrix h_a and h_b to the device memory
    err = cudaGetLastError();
 	if ( cudaSuccess != err )
    {
    printf("cudaCheckError() failed : %s\n", cudaGetErrorString( err ) );
            exit( -1 );
    }
 	
    // TODO: Launch your matrix multiplication kernel
 	err = cudaGetLastError();
    if ( cudaSuccess != err )
    {
    printf("cudaCheckError() failed : %s\n", cudaGetErrorString( err ) );
            exit( -1 );
    }

 	// TODO: Copy output matrix h_c to the host memory 
 	err = cudaGetLastError();
    if ( cudaSuccess != err )
    {
    printf("cudaCheckError() failed : %s\n", cudaGetErrorString( err ) );
            exit( -1 );
    }
 	
    // TODO: Free all alocated memory
 	err = cudaGetLastError();
    if ( cudaSuccess != err )
    {
    printf("cudaCheckError() failed : %s\n", cudaGetErrorString( err ) );
            exit( -1 );
    }
 	
    free(h_a);
 	free(h_b);
 	free(h_c);
}
void init(int * input, int size)
{
	int i;
	for(i=0;i<size;i++)
	{
		input[i]=rand()%5;
	}
}
void print_matrix(int * matrix,int size)
{
	printf("Matrix items: \n");
	int i,j;
	for(i=0;i<size;i++)
	{
		for(j=0;j<size;j++)
			printf("%d,",matrix[i*size+j]);
		printf("\n");
	}
}
__global__ void matrix_mult_kernel (int *a, int *b, int *c, int width)
 {
    //TODO implement the naive matrix multiplication version
 }
}
