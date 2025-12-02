import { TextLineStream } from "@std/streams";
import {parseCommand} from "./utils/parseCommand.ts";
import {getNewPosition} from "./utils/getNewPosition.ts";

/* GLOBAL VARIABLES */
let currentPosition = 50;
let countOfZeros = 0;

const file = await Deno.open("input.txt", { read: true });

const lines = file.readable
    .pipeThrough(new TextDecoderStream())
    .pipeThrough(new TextLineStream());

for await (const line of lines) {
  const command = parseCommand(line);
  const newPosition = getNewPosition(currentPosition, command);
  if (newPosition === 0) {
    countOfZeros++;
  }
  currentPosition = newPosition;
}

console.log(countOfZeros);
