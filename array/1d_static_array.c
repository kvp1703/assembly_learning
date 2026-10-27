#include <stdio.h>

#define MAX 10

int main() {
	int iMAX;
	int i;
	int arr[MAX];

	printf("Enter value of n(< %d): ", MAX);
	scanf("%d", &iMAX);
	
	for (i = 0; i < iMAX; i++) {
		printf("Enter value for index %d: ", i);
		scanf("%d", &ptr[i]);
	}

	printf("\nEntered elements are:\n");
	for(int i = 0; i < MAX; i++) {
		printf("Elemets at index %d: %d\n", i, ptr[i]);
	}

	exit(0);
}