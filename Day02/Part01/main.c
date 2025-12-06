#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Range {
    char start[64];
    char end[64];
};

struct Range parseRange(char stringRange[64]);
long long getTotalOfInvalidIdsInRange(struct Range range);
bool isOddNumberOfDigits(char number[64]);
bool isInRange(struct Range range, char number[64]);
bool isAboveRange(struct Range range, char number[64]);
void skipToNextMagnitude(char *number);
void halveNumberString(char *number);
void duplicateNumberString(char *number);
void incrementNumberString(char *number);

int main(void) {
    char inputBuffer[64];
    FILE *fptr;
    long long invalidIdTotal = 0;

    if ((fptr = fopen("input.txt", "r")) == NULL) {
        printf("Failed to open input.txt\n");
        return 1;
    }

    while (fscanf(fptr, "%[^,]", inputBuffer) == 1) {
        struct Range range = parseRange(inputBuffer);
        printf("Start is %s, End is %s\n", range.start, range.end);

        invalidIdTotal += getTotalOfInvalidIdsInRange(range);
        printf("Total of invalid IDs so far: %lld\n---\n\n", invalidIdTotal);

        const long long c = fgetc(fptr);
        if (c == EOF) {
            break;
        }
    }

    fclose(fptr);

    printf("Total of invalid IDs: %lld\n", invalidIdTotal);

    return 0;
}

// 1775168550 - too low // int overflow... Will I ever learn?
// 31839939622

long long getTotalOfInvalidIdsInRange(const struct Range range) {
    char currentNumber[64];
    strcpy(currentNumber, range.start);
    long long invalidIdTotal = 0;

    while (!isAboveRange(range, currentNumber)) {
        printf("Checking %s\n", currentNumber);

        // First up, odd number of digits, not possible. Skip to the next magnitude.
        if (isOddNumberOfDigits(currentNumber)) {
            skipToNextMagnitude(currentNumber);
            printf("Skipped to next magnitude: %s\n\n", currentNumber);
            continue;
        }

        halveNumberString(currentNumber);
        printf("Halved to %s\n", currentNumber);

        duplicateNumberString(currentNumber);
        printf("Duplicated to %s\n", currentNumber);

        if (isInRange(range, currentNumber)) {
            printf("Invalid ID: IN RANGE\n");
            invalidIdTotal += atoll(currentNumber);
        } else {
            printf("Invalid ID: NOT IN RANGE\n");
        }

        halveNumberString(currentNumber);
        incrementNumberString(currentNumber);
        duplicateNumberString(currentNumber);
        printf("Incremented to %s\n\n", currentNumber);
    }

    return invalidIdTotal;
}

void halveNumberString(char *number) {
    number[strlen(number) / 2] = '\0';
}

void duplicateNumberString(char *number) {
    const size_t length = strlen(number);
    for (size_t i = 0; i < length; i++) {
        number[length + i] = number[i];
    }
    number[length * 2] = '\0';
}

void incrementNumberString(char *number) {
    long long newNumber = atoll(number) + 1;
    sprintf(number, "%lld", newNumber);
}

void skipToNextMagnitude(char *number) {
    const size_t length = strlen(number);
    number[0] = '1';

    for (size_t i = 1; i < length; i++) {
        number[i] = '0';
    }

    // We've reset to 10, or 100, or 1000, etc. Now x10.
    number[length] = '0';
    number[length + 1] = '\0';
}

bool isOddNumberOfDigits(char number[64]) {
    return strlen(number) % 2 != 0;
}

bool isInRange(const struct Range range, char number[64]) {
    const long long start = atoll(range.start);
    const long long end = atoll(range.end);
    const long long numberToCheck = atoll(number);
    return numberToCheck >= start && numberToCheck <= end;
}

bool isAboveRange(const struct Range range, char number[64]) {
    const long long end = atoll(range.end);
    const long long numberToCheck = atoll(number);
    return numberToCheck > end;
}

struct Range parseRange(char stringRange[64]) {
    struct Range r;
    strcpy(r.start, strtok(stringRange, "-"));
    // Using nullptr here tells strtok to keep going with the string it was previously given.
    strcpy(r.end, strtok(nullptr, "-"));
    return r;
}

// Asked AI about the safety of leaving a string in strtok and it suggested this nice alternative:
// struct range parseRange(char stringRange[64]) {
//     struct range r;
//     // %63[^-] : Read up to 63 chars that are NOT a hyphen
//     // -       : Read the hyphen
//     // %63s    : Read the remaining string
//     if (sscanf(stringRange, "%63[^-]-%63s", r.start, r.end) != 2) {
//         // Handle error: parsing failed
//         r.start[0] = '\0';
//         r.end[0] = '\0';
//     }
//     return r;
// }
