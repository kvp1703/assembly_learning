#include <stdio.h>

int *ptr = NULL;

int main() {
	int MAX;
	int i;

	printf("Enter the value of lenght of array: ");
	scanf("%d", &MAX);

	ptr = (int *) malloc (MAX * sizeof(int));

	if(ptr == NULL) {
		puts("Memory allocation failed\n");
		exit(-1);
	}

	for (i = 0 ; i < MAX; i++) {
		printf("Enter value for index %d: ", i);
		scanf("%d", &ptr[i]);
	}

	printf("\nEntered elements are:\n");
	for(int i = 0; i < MAX; i++) {
		printf("Elemets at index %d: %d\n", i, ptr[i]);
	}

	free(ptr);
	ptr = NULL;

	exit(0);
}

