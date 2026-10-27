#include <stdio.h>
#include <stdlib.h>

#define MAX 10

int main(void)
{
    int rows;
    int columns;
    int counter1;
    int counter2;
    int arr[MAX][MAX];

    printf("Enter value of rows & columns(< %d):\t", MAX);
    scanf("%d%d", &rows, &columns);

    for(counter1 = 0; counter1 < rows; counter1++)
    {
        for(counter2 = 0; counter2 < columns; counter2++)
        {
            printf("Enter [%d][%d] value:\t", counter1, counter2);
            scanf("%d", &arr[counter1][counter2]);
        }
    }

    printf("Entered elements are:\n");

    for(counter1 = 0; counter1 < rows; counter1++)
        for(counter2 = 0; counter2 < columns; counter2++)
            printf("[%d][%d] value is:\t%d\n",
                   counter1, counter2, arr[counter1][counter2]);

    exit(0);
}