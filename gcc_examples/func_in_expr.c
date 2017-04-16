int foo(int a) {
	return a + 1;
}

int main() {

	int a = 2 * foo(6) + 42 / foo(foo(6));
}
