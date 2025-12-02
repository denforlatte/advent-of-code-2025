export function parseCommand(command: string): Command {
    return {
        direction: command.charAt(0),
        magnitude: parseInt(command.slice(1), 10),
    }
}
