#include <stdio.h>
#include <stdlib.h>

struct demo
{
	char c;
	int no1;
	short int no2;
} obj1;

int main() {

	struct demo obj2;
	struct demo obj3;

	printf("Enter obj2 values:\n");
	printf("Enter c: ");
	scanf("%c%c", &t, &obj2.c);
	printf("Enter no1: ");
	scanf("%d", &t, &obj2.no1);
	printf("Enter no2: ");
	scanf("%hd",&t, &obj2.no2);


	printf("obj2 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj2.c, obj2.no1, obj2.no2);

	obj1.c = obj2.c;
	obj1.no1 = obj2.no1;
	obj1.no2 = obj2.no2;

	obj2.c = obj2.c;
	obj2.no1 = obj2.no1;
	obj2.no2 = obj2.no2;

	printf("obj1 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj1.c, obj1.no1, obj1.no2);
	printf("obj3 is:\n");
	printf("{c: %c, no1: %d, no2: %hd}\n\n", obj2.c, obj2.no1, obj2.no2);

	exit(0);
}