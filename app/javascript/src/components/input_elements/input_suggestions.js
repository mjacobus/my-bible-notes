import { observe } from "selector-observer";

observe(".input-suggestions", {
  add(element) {
    const container = element.querySelector(".suggestions");
    const input = element.querySelector("input");
    const suggestions = JSON.parse(input.getAttribute("data-suggestions"));
    new InputSuggestions({ suggestions, input, container });
  },
});

class InputSuggestions {
  constructor({ input, suggestions, list }) {
    this.input = input
    this.suggestions = suggestions
    this.list = list
    this.input.addEventListener("keydown", () => {
      matched = this.findMatches();
    });
  }
}
