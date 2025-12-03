import { assertEquals } from "@std/assert";
import {getNewPosition} from "./utils/getNewPosition.ts";

Deno.test(function getNewPositionUnderflowTest() {
  assertEquals(getNewPosition(5, {direction: 'L', magnitude: 310}), 95);
});

Deno.test(function getNewPositionOverflowTest() {
  assertEquals(getNewPosition(95, {direction: 'R', magnitude: 10}), 5);
});

Deno.test(function getNewPositionZeroTest() {
  assertEquals(getNewPosition(95, {direction: 'R', magnitude: 5}), 0);
});
