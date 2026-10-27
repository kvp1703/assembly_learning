#include <stdio.h>
#include <stdlib.h>

void SumDiff(int no1, int no2, int *sum, int *diff)
{
    *sum = no1 + no2;
    *diff = no1 - no2;
}

int main(void)
{
    int no1, no2;
    int sum, diff;

    printf("Enter two numbers: ");

    scanf("%d%d", &no1, &no2);

    SumDiff(no1, no2, &sum, &diff);

    printf("Sum is: %d\n", sum);
    printf("Diff is: %d\n", diff);

    exit(0);
}