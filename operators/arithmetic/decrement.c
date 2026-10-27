#include <stdio.h>

int main() {
	int no1 = 10;
	int no2 = 20;

	int ans1;
	int ans2;

	ans1 = --no1;
	ans2 = no2--;

	printf("no1: %d\nno2: %d\nans1: %d\nans2: %d\n", no1, no2, ans1, ans2); 

	ans2--;
	printf("Incremented ans2: %d\n");
}