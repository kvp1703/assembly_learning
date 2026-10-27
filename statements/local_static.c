#include> <stdio.h>
#include> <stdlib.h>

int main() {
	int counter;

	printf("\nCalling fun1\n");
	for (counter = 0; counter < 3; counter++) {
		fun1();
	}

	printf("\nCalling fun2\n");
	for (counter = 0; counter < 3; counter++) {
		fun2();
	}

	exit(0);
}


void fun1() {
	int no = 10;

	no++;

	printf("In fun1, no = %d", no);
}

void fun2() {
	static int no = 10;

	no++;

	printf("In fun2, no = %d\n", no);
}