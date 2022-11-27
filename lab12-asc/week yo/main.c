#include<stdio.h>



int sum_num(int a,int b);

int dif_num(int a,int b);

int main()
{
    int a=0,b=0,c=0,sum=0,dif=0;
    
    printf("this program calculates and displays a+b-c, where a,b,c are signed bytes\n");
    
    printf("a = ");
    scanf("%d", &a);

    printf("b = ");
    scanf("%d", &b);
    
    printf("c = ");
    scanf("%d", &c);
    
    sum = sum_num(a,b);
    dif = dif_num(sum,c);
    
    printf("a+b-c = %d", dif);
    
    return 0;
}