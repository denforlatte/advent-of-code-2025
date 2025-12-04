#include <stdio.h>

int main(void) {
    char c[256];
    FILE *fptr;

    if ((fptr = fopen("input.txt", "r")) == NULL) {
        printf("Failed to open input.txt\n");
        return 1;
    }

    while (fscanf(fptr, "%[^,]", c) == 1) {
        printf("Range: %s\n", c);

        const int ch = fgetc(fptr);
        if (ch == EOF) {
            break;
        }
    }

    fclose(fptr);

    return 0;
}
