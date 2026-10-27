#include <stdio.h>
#include <stdlib.h>

struct demo
{
	char c;
	int no1;
	short int no2;
} obj1 = {"A", 10, 20};

int main() {

	struct demo obj2 = {"B", 30, 40};
	struct demo obj3 = {"B", 30, 40};

	printf("obj1 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj1.c, obj1.no1, obj1.no2);

	printf("obj2 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj2.c, obj2.no1, obj2.no2);

	printf("obj3 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj2.c, obj2.no1, obj2.no2);

	printf("obj1 & obj2 comparison is ");
	if(obj1.c == obj2.c && obj1.no1 == obj2.no1 && obj1.no2 == obj2.no2) {
		printf("Equal\n");
	} else {
		printf("Not equal\n");
	}

	printf("obj2 & obj3 comparison is ");
	if(obj2.c == obj3.c && obj2.no1 == obj3.no1 && obj2.no2 == obj3.no2) {
		printf("Equal\n");
	} else {
		printf("Not equal\n");
	}

	exit(0);
}