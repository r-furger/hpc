#include <stdio.h>
#include <stdlib.h>
#define DATASIZE 64 
__global__ void get_average(double *in, double *out, int width)
{
        int id=threadIdx.x;
        if(id==0||id==width-1)
        {
                out[id]=in[id];
        }
        else
        {
                out[id]=(in[id-1]+in[id]+in[id+1])/3;
        }
}
void init( double * input, int width )
{
        int i;
        for(i=0;i<width;i++)
        {
                input[i]= rand() % 5;
        }
}
int check(double * original, double * averaged, int width)
{
        int i;
        for(i=1;i<width-1;i++)
        {
                if(averaged[i]!=(original[i-1]+original[i]+original[i+1])/3)
                {
                        printf("Something goes wrong :(\n");
                        return -1;
                }
        }
        if(averaged[0]!=original[0]||averaged[width-1]!=original[width-1])
        {
                printf("Boundary condition are not fine :( \n");
                        return -1;
        }
        printf("Correct solution\n");
        return 0;
}
int main()
{
        double * d_in;
        double * d_out;
        // Memory allocation at host sid
        double * h_in = (double *)malloc(sizeof(double)*DATASIZE);
        double * h_out= (double *)malloc(sizeof(double)*DATASIZE);
        // CHANGE: Memory allocation at device side
        cudaMalloc(&d_in,sizeof(double)* DATASIZE);
        cudaMalloc(&d_out,sizeof(double)* DATASIZE);
        
        // create random 1d array
        init(h_in,DATASIZE);
        // copy from host to device (GPU) init data
        cudaMemcpy(d_in,h_in,DATASIZE,cudaMemcpyHostToDevice);
        // kernel
        get_average<<<1,DATASIZE>>>(d_in,d_out,DATASIZE*sizeof(double));
        // CHANGE: copy resulting data from device to host
        //cudaMemcpy(h_out,d_out,sizeof(double)*DATASIZE,cudaMemcpyHostToDevice);
        cudaMemcpy(h_out,d_out,sizeof(double)*DATASIZE,cudaMemcpyDeviceToHost);
        
        check(h_in,h_out,DATASIZE);
        
        // Free device, host memory
        cudaFree(d_in);
        // CHANGE:
        cudaFree(d_out);
        free(h_in);
        free(h_out);
}