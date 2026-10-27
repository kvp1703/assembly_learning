#include <stdio.h>

int g;

int main() {
	printf("global variable g before initialization: %d\n", g);
	g = 9;
	printf("global variable g after initialization: %d\n", g);
	return 0;
}