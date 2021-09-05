/**
 * @jest-environment jsdom
 */

import InputSuggestions from "../input_suggestions";
import { prepareStringForComparison, limit } from "../input_suggestions";

const suggestions = [
  "meu Coração",
  "não sei por que",
  "bate feliz",
  "quando te",
  "que banana",
  "banana",
  "batata",
];

let object = null;

describe("InputSuggestions", () => {
  beforeEach(() => {
    const input = document.createElement("input");
    object = new InputSuggestions({ suggestions, input });
  });

  describe(".findMatches", () => {
    it("return matches", () => {
      const result = object.findMatches("ba");

      expect(result).toEqual(["bate feliz", "que banana", "banana", "batata"]);
    });
  });

  describe(".isMatch", () => {
    it("returns true or false", () => {
      expect(object.isMatch("coraçÃo", "Meu CoraçÃo")).toBe(true);
      expect(object.isMatch("x coraçÃo", "Meu CoraçÃo")).toBe(false);
    });
  });
});

describe("prepareStringForComparison", () => {
  it("lowercase and replace accents", () => {
    const result = prepareStringForComparison("É Campeão de CoraçÃo");

    expect(result).toEqual("e campeao de coracao");
  });
});

describe("limit", () => {
  it("limits the results of an array", () => {
    const result = limit([1, 2, 4, 5, 5], 3);

    expect(result).toEqual([1, 2, 4]);
  });
});
