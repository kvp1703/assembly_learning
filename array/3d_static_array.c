#include <stdio.h>
#include <stdlib.h>

#define MAX 10

int main(void)
{
    int x;
    int y;
    int z;
    int counter1;
    int counter2;
    int counter3;
    int arr[MAX][MAX][MAX];

    printf("Enter value of rows & columns(< %d):\t", MAX);
    scanf("%d%d%d", &x, &y, &z);

    for(counter1 = 0; counter1 < x; counter1++)
    {
        for(counter2 = 0; counter2 < y; counter2++)
        {

            for(counter3 = 0; counter3 < z; counter3++) {

                printf("Enter [%d][%d][%d] value:\t", counter1, counter2, counter3);
                scanf("%d", &arr[counter1][counter2][counter3]);
            }
        }
    }

    printf("Entered elements are:\n");

    for(counter1 = 0; counter1 < x; counter1++)
    {
        for(counter2 = 0; counter2 < y; counter2++)
        {

            for(counter3 = 0; counter3 < z; counter3++) {

                printf("[%d][%d][%d] value is:\t%d\n", counter1, counter2,counter3, arr[counter1][counter2][counter3]);
            }
        }
    }

    exit(0);
}