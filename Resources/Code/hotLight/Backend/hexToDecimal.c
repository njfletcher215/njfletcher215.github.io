#include <stdio.h>

// converts a hexidecimal temp in Celcius to a decimal temp in Fahrenheit
int main(int argc, char** argv) {

	int num = (int)strtol(argv[1], NULL, 16);	// converts argv[1], a string, to an int (16 is argv[1]'s base)
	float number = (float)num;	// change num to a float so we can apply the C to F formula more accurately
	number = ((number * 9.0) / 5.0) + 32.0;	// convert Celcius to Fahrenheit
	fprintf(stdout, "%.2f\n", number);	// print to stdout

	// in this specific case, printing to stdout will save number as a shell script variable in hotLight.sh

	return 0;
}
