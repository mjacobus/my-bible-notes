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
  let only = [];

  for (let i = 0; i < collection.length; i++) {
    if (i === to) {
      break;
    }

    only.push(collection[i]);
  }

  return only;
}

const keyCodes = {
  up: 38,
  down: 40,
  tab: 9,
  enter: 13,
};

function keyCodeIs(keyCode, key) {
  return keyCodes[key] === keyCode;
}

class InputSuggestions {
  constructor({ input, suggestions, list, limit = 5 }) {
    this.options = [];
    this.limit = limit;
    this.input = input;
    this.suggestions = suggestions;
    this.list = list;
    this.selected = 0;
    this.input.addEventListener("keyup", (e) => {
      if (
        keyCodeIs(e.keyCode, "up") ||
        keyCodeIs(e.keyCode, "down") ||
        keyCodeIs(e.keyCode, "tab") ||
        keyCodeIs(e.keyCode, "enter")
      ) {
        return;
      }

      const matches = this.findMatches(this.input.value);
      this.populateSuggestions(matches);
    });

    this.input.addEventListener("blur", () => this.hide());

    this.input.addEventListener("keydown", (e) => {
      if (keyCodeIs(e.keyCode, "enter")) return;

      if (keyCodeIs(e.keyCode, "esc")) {
        return this.hide();
      }

      if (keyCodeIs(e.keyCode, "down")) {
        return this.selectNext();
      }

      if (keyCodeIs(e.keyCode, "up")) {
        return this.selectPrevious();
      }

      if (keyCodeIs(e.keyCode, "tab")) {
        e.preventDefault();
        return this.selectCurrent();
      }

      const matches = this.findMatches(this.input.value);
      this.populateSuggestions(matches);
    });
  }

  selectNext() {
    this.select(this.selected + 1);
  }

  selectPrevious() {
    this.select(this.selected - 1);
  }

  selectCurrent() {
    const current = this.getOption(this.selected);
    if (!current) {
      return;
    }

    this.expand(current);
  }

  expand(option) {
    this.input.value = option.innerText;
    this.hide();
  }

  select(number) {
    this.selected = number;
    if (this.options.length === 0) {
      return;
    }

    this.options.forEach((e) => e.classList.remove("selected"));
    this.getOption(this.selected).classList.add("selected");
  }

  getOption(index) {
    index = Math.abs(index % this.options.length);
    return this.options[index];
  }

  hide() {
    this.list.hidden = true;
  }

  show() {
    this.list.hidden = false;
  }

  findMatches(string) {
    return this.suggestions.filter((item) => this.isMatch(string, item));
  }

  populateSuggestions(matches) {
    matches = limit(matches, this.limit);
    this.list.innerHTML = "";
    this.options = [];
    matches.forEach((match) => this.addSuggestion(match));
    if (this.list.children.length === 0) {
      return this.hide();
    }

    this.show();
    this.select(0);
  }

  addSuggestion(match) {
    let element = document.createElement("a");
    element.href = "#";
    element.classList.add("suggestion-item");
    element.innerText = match;
    this.list.appendChild(element);
    this.options.push(element);
    // element = this.list.lastChild;
    element.addEventListener("click", (e) => {
      // This is not picking up
      e.preventDefault();
      this.expand(element);
    });
  }

  isMatch(matchString, candidate) {
    return !!candidate.toLowerCase().match(matchString.toLowerCase());
  }
}

export default InputSuggestions;

export { prepareStringForComparison, limit };
