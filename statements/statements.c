#include <stdio.h>
#include <stdlib.h>

int Division(int no1, int no2);
int Addition(int no1, int no2);
int Subtraction(int no1, int no2);
int Multiplication(int no1, int no2);

int main() {
	int no1;
	int no2;
	int ans;
	int ch;

	do{
		printf("\n1.Addition\n2.Subtraction\n3:Multiplication\n4.Division\n5.Exit\n");
		printf("Enter your choice: ");
		scanf("%d", &ch);

		if (ch > 0 && ch < 5) {
			printf("Enter two numbers: ");
			scanf("%d%d", &no1, &no2);
		}

		switch (Ch) {
			case 1:
				ans = Addition(no1, no2);
				break;
			case 2:
				ans = Addition(no1, no2);
				break;
			case 3:
				ans = Subtraction(no1, no2);
				break;
			case 4:
				ans = Division(no1, no2);
				break;
			case 5:
				exit(0);
			default:
				printf("Enter valid choice\n");
				ch = 1;
				continue;
		}

		printf("Answer is %d\n\n", ans);

		printf("Do you want to exit (0/1)? ");
		scanf("%d", &ch);
	} while (ch == 1);

	exit(0);
}

int Addition(int no1, int no2) {
	return no1 + no2;
}

int Subtraction(int no1, int no2) {
	return no1 - no2;
}

int Division(int no1, int no2) {
	return no1 / no2;
}

int Multiplication(int no1, int no2) {
	return no1 * no2;
}