#include <stdio.h>

static int g;

static void fun() {
	g = 7;
	printf("Hello from fun()\n");
}