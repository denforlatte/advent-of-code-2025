import { TextLineStream } from "@std/streams";

const file = await Deno.open("input.txt", { read: true });

const lines = file.readable
    .pipeThrough(new TextDecoderStream())
    .pipeThrough(new TextLineStream());

for await (const line of lines) {
  console.log(line);
}
