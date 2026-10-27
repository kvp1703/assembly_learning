#include <stdio.h>
#include <stdlib.h>

int no1 = 1;
int no2;

void fun1();

int main() {
	int no3;

	printf("Enter two numbers:\t");
	scanf("%d%d", &no2, &no3);

	printf("In main, %d, %d, %d\n", no1, no2, no3);
	fun1();

	exit(0);
}