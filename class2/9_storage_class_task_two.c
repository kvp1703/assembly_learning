#include<stdio.h>

static void fun2();

static int no1;
static int no2 = 40;

void fun1() {
	printf("Enter a number:\t");
	scanf("%d", &no1);

	printf("In fun1, no1 is %d and no2 is %d\n", no1, no2);

	fun2();
}

static void fun2() {
	printf("In static fun2");
}