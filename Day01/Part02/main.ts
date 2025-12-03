import { TextLineStream } from "@std/streams";
import {parseCommand} from "./utils/parseCommand.ts";
import {getNewPosition} from "./utils/getNewPosition.ts";
import {countZeroes} from "./utils/countZeroes.ts";

/* GLOBAL VARIABLES */
let currentPosition = 50;
let countOfZeros = 0;

const file = await Deno.open("input.txt", { read: true });

const lines = file.readable
    .pipeThrough(new TextDecoderStream())
    .pipeThrough(new TextLineStream());

for await (const line of lines) {
  const command = parseCommand(line);
  console.log("Processing command:", command);
  countOfZeros += countZeroes(currentPosition, command);
  currentPosition = getNewPosition(currentPosition, command);
}


console.log(countOfZeros);

// 5779 - Not right
// 5861 - too low
// 5872 - CORRECT!
// 5884 - also wrong
// 6244 - too high?
// 6860?
