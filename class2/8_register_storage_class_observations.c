#include <stdio.h>

int main()
{
	register int a = 9;
	register int b = 99;
	register int c = 999;
	register int d = 111;
	register int e = 112;
	register int f = 113;
	register int g = 114;
	register int h = 115;
	register int i = 116;
	register int j = 117;


	register int sum = a + b + c + d + e + f;
	printf("Sum is %d", sum);

	return 0;
}