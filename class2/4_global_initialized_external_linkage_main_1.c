#include <stdio.h>
#include <stdlib.h>

int main() {
	extern int g;
	printf("Global variable b from another file: %d\n", g);
}