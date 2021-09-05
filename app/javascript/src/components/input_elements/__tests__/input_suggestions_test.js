/**
 * @jest-environment jsdom
 */

import InputSuggestions from "../input_suggestions";
import { prepareStringForComparison } from "../input_suggestions";

const suggestions = [
  "meu Coração",
  "não sei por que",
  "bate feliz",
  "quando te",
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

      expect(result).toEqual(["bate feliz", "banana", "batata"]);
    });

    it("returns matches ignoring accents", () => {
      const result = object.findMatches("ba");

      expect(result).toEqual(["bate feliz", "banana", "batata"]);
    });
  });
});

describe("prepareStringForComparison", () => {
  it("lowercase and replace accents", () => {
    const result = prepareStringForComparison("É Campeão de CoraçÃo");

    expect(result).toEqual("e campeao de coracao");
  });
});
