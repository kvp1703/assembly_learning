#include <stdio.h>

int main() {
	int no1;
	int no2;
	long long ans;

	long long no1;
	printf("Enter numerator: ");
	scanf("%qd", no1);

	int no2 = 500000;

	int ans = no1 / no2;
	int rem = no1 % no2;

	printf("Denominator: %d\nQuotient: %d\nRemainder: %d", no2, ans , rem);

	exit(0);
}