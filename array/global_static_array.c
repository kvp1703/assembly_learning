#include <stdio.h>

#define MAX 10

int arr1[] = {10, 20, 30};
int arr2[MAX];

int main() {
	int iMAX;
	int i;

	printf("Enter value of n(< %d): ", MAX);
	scanf("%d", &iMAX);
	
	for (i = 0; i < iMAX; i++) {
		printf("Enter arr2[%d]: ", i);
		scanf("%d", &arr2[i]);
	}

	printf("\narr1 is:\n");
	for(i = 0; i < 3; i++) {
		printf("arr1[%d] = %d\n", i, arr1[i]);
	}

	printf("\narr2 is:\n");
	for(i = 0; i < iMAX; i++) {
		printf("arr2[%d] = %d\n", i, arr2[i]);
	}

	exit(0);
}