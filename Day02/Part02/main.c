#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Range {
    char start[64];
    char end[64];
};

struct Range parseRange(char stringRange[64]);
long long getTotalOfInvalidIdsInRange(struct Range range);
void FindInvalidIdsInRangeWithRepetitionX(long long *invalidIds, int invalidIdsLength, struct Range range, int repetitions);
bool isMultipleOfRepetitions(char number[64], int repetitions);
bool isInRange(struct Range range, char number[64]);
bool isAboveRange(struct Range range, char number[64]);
void skipToNextMagnitude(char *number);
void divideNumberString(char *number, int divisions);
void duplicateNumberString(char *number, int divisions);
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
        // printf("Start is %s, End is %s\n", range.start, range.end);

        invalidIdTotal += getTotalOfInvalidIdsInRange(range);
        // printf("Total of invalid IDs so far: %lld\n---\n\n", invalidIdTotal);

        const long long c = fgetc(fptr);
        if (c == EOF) {
            break;
        }
    }

    fclose(fptr);

    printf("Total of invalid IDs: %lld\n", invalidIdTotal);

    return 0;
}

long long getTotalOfInvalidIdsInRange(const struct Range range) {
    long long invalidIds[256] = {0};
    FindInvalidIdsInRangeWithRepetitionX(invalidIds, 256, range, strlen(range.end));

    long long totalOfInvalidIds = 0;
    for (int i = 0; i < 256; i++) {
        totalOfInvalidIds += invalidIds[i];
    }
    return totalOfInvalidIds;
}

void FindInvalidIdsInRangeWithRepetitionX(long long *invalidIds, int invalidIdsLength, struct Range range, int repetitions) {
    char currentNumber[64];
    strcpy(currentNumber, range.start);

    while (!isAboveRange(range, currentNumber)) {
        // printf("Checking %s for repetitions %d\n", currentNumber, repetitions);

        // First up, odd number of digits, not possible. Skip to the next magnitude.
        if (!isMultipleOfRepetitions(currentNumber, repetitions)) {
            skipToNextMagnitude(currentNumber);
            // printf("Skipped to next magnitude: %s\n\n", currentNumber);
            continue;
        }

        divideNumberString(currentNumber, repetitions);
        // printf("Divided to %s\n", currentNumber);

        duplicateNumberString(currentNumber, repetitions);
        // printf("Duplicated to %s\n", currentNumber);

        if (isInRange(range, currentNumber)) {
            // printf("Invalid ID: IN RANGE - %lld\n", atoll(currentNumber));
            const long long id = atoll(currentNumber);
            bool found = false;
            int filledLength = 0;
            for (int i = 0; i < invalidIdsLength; i++) {
                if (invalidIds[i] == id) {
                    found = true;
                }
                if (invalidIds[i] != 0) {
                    filledLength = i + 1;
                }
            }
            if (!found) {
                if (filledLength >= invalidIdsLength) {
                    printf("InvalidIds array is full! Increase size!\n");
                    // TODO: I should throw here or something. Or implement a dynamic array.
                }
                invalidIds[filledLength] = id;
            }
        } else {
            // printf("Invalid ID: NOT IN RANGE\n");
        }

        divideNumberString(currentNumber, repetitions);
        incrementNumberString(currentNumber);
        duplicateNumberString(currentNumber, repetitions);
        // printf("Incremented to %s\n\n", currentNumber);
    }

    if (repetitions > 2) {
        FindInvalidIdsInRangeWithRepetitionX(invalidIds, invalidIdsLength, range, repetitions - 1);
    }
}

void divideNumberString(char *number, const int divisions) {
    number[strlen(number) / divisions] = '\0';
}

void duplicateNumberString(char *number, const int divisions) {
    const size_t length = strlen(number);
    char numberCopy[64];
    strcpy(numberCopy, number);

    for (int i = 1; i < divisions; i++) {
        for (size_t j = 0; j < length; j++) {
            number[(length * i) + j] = numberCopy[j];
        }
    }
    number[length * divisions] = '\0';
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

bool isMultipleOfRepetitions(char number[64], int repetitions) {
    return strlen(number) % repetitions == 0;
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