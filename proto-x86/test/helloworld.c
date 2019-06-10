#include <qtum.h>

int onCreate()
{
	qtumEventStringString("Hello World", "Contract creation");
	return 0;
}

int main()
{
	qtumEventStringString("Hello World", "Execution Success!");
	return 0;
}