import { Command } from '../types.ts';

export function getNewPosition(currentPosition: number, command: Command): number {
    const vector = command.direction === 'L' ? command.magnitude * -1 : command.magnitude;

    let newPositionRaw = currentPosition + vector;

    while (newPositionRaw < 0) {
        newPositionRaw += 100;
    }

    return newPositionRaw % 100;
}
