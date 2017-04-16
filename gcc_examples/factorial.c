#include <stdio.h>

int fact(int n) {
	int res = 1;
	while(n>0) {
		res = n * res;
		n--;
	}

	return res;
}

int main() {
	int a;
	printf("Enter a number for factorial: ");
	scanf("%d", &a);
	int res = fact(a);
	printf("The factorial of %d is %d\n", a, res);
	return 0;
}
