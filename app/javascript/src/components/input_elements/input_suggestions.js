import { observe } from "selector-observer";

observe(".input-suggestions", {
  add(element) {
    const list = element.querySelector(".suggestions");
    const input = element.querySelector("input");
    const suggestions = JSON.parse(input.getAttribute("data-suggestions"));
    new InputSuggestions({ suggestions, input, list });
  },
});

// https://stackoverflow.com/questions/5700636/using-javascript-to-perform-text-matches-with-without-accented-characters
function prepareStringForComparison(string) {
  return string
    .toLowerCase()
    .replace(
      /([àáâãäå])|([çčć])|([èéêë])|([ìíîï])|([ñ])|([òóôõöø])|([ß])|([ùúûü])|([ÿ])|([æ])/g,
      function (str, a, c, e, i, n, o, s, u, y, ae) {
        if (a) return "a";
        if (c) return "c";
        if (e) return "e";
        if (i) return "i";
        if (n) return "n";
        if (o) return "o";
        if (s) return "s";
        if (u) return "u";
        if (y) return "y";
        if (ae) return "ae";
      }
    );
}

function limit(collection, to) {
  let only = []

  for (let i = 0; i < collection.length; i++) {
    if (i === to) {
      break;
    }

    only.push(collection[i]);
  }

  return only;
}

class InputSuggestions {
  constructor({ input, suggestions, list }) {
    this.input = input;
    this.suggestions = suggestions;
    this.list = list;
    this.input.addEventListener("keydown", () => {
      const matches = this.findMatches(this.input.value);
      this.populateSuggestions(matches);
    });
  }

  findMatches(string) {
    return this.suggestions.filter((item) => this.isMatch(string, item));
  }

  populateSuggestions(matches) {
    this.list.innerHTML = "";
    matches.forEach((match) => this.addSuggestion(match));
    if (this.list.children.length === 0) {
      return (this.list.hidden = true);
    }

    this.list.hidden = false;
  }

  addSuggestion(match) {
    const element = document.createElement("span");
    element.classList.add("suggestion-item");
    element.innerText = match;
    this.list.appendChild(element);
  }

  isMatch(matchString, candidate) {
    return !!candidate.toLowerCase().match(matchString.toLowerCase());
  }
}

export default InputSuggestions;

export { prepareStringForComparison, limit };
