#include <stdio.h>

int main() {
	int no1, no2, no3, ans;

	printf("Enter three numbers: ");
	scanf("%d%d%d", &no1, &no2, &no3);

	ans = no1 < no2 != no3;

	printf("Answer is %d\n", ans);
} 