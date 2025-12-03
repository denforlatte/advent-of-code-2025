import {Command} from "../types.ts";

export function countZeroes(startingPosition: number, command: Command): number {
    const direction = command.direction === 'L' ? -1 : 1;

    let passesThroughZero = 0;
    let remainingTurns = command.magnitude;
    let newPosition = startingPosition;

    while (remainingTurns > 0) {
        newPosition += direction;
        if (newPosition % 100 === 0) {
            passesThroughZero += 1;
        }
        remainingTurns--;
    }

    return passesThroughZero;
}
