#include <stdio.h>
void printnum(int i, int ia) {
	printf("%d\n", i);
	printf("%d\n", ia);
}

int main() {
	int a = 54;
	printnum(a, a*2);
}
