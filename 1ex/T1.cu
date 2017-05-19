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
        double * h_in = (double *)malloc(sizeof(double)*DATASIZE);
        double * h_out= (double *)malloc(sizeof(double)*DATASIZE);
        init(h_in,DATASIZE);
        cudaMemcpy(d_in,h_in,DATASIZE,cudaMemcpyHostToDevice);
        get_average<<<1,DATASIZE>>>(d_in,d_out,DATASIZE*sizeof(double));
        cudaMemcpy(h_out,d_out,sizeof(double)*DATASIZE,cudaMemcpyHostToDevice);
        check(h_in,h_out,DATASIZE);
        cudaFree(d_in);
        free(h_in);
        free(h_out);
}