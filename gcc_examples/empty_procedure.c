#include <stdio.h>

void foo() {
	int a = 4;
	while(a > 0) {
		printf("a: %d\n", a);
		a--;
	}
}

int main() {
	foo();
}
