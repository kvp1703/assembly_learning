#include <stdio.h>

int main() {
	int no1 = 10;
	int no2 = 20;
	int no3 = 30;

	int ans = no1 && ++no2 && ++no3;

	printf("no1: %d\nno2: %d\nno3: %d\n ans: %d", no1, no2, no3, ans);

	exit(0);
}