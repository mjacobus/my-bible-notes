import { on } from "delegated-events";
import { observe } from "selector-observer";
import { TemplateInstance } from "@github/template-parts";

function bem(element) {
  return `.InputElements_TagsInputComponent__${element}`;
}

const submitKeys = [
  // 9, // tab
  13, // enter
  188, // comma
];

observe(".InputElements_TagsInputComponent", {
  add(element) {
    const tagInput = element.querySelector(bem("tag_input"));
    tagInput.addEventListener("keydown", (e) => {
      if (submitKeys.includes(e.keyCode)) {
        e.preventDefault();
        addTagFromInput(tagInput, element);
      }
    });
  },
});

on("click", bem("close_button"), (e) => {
  e.preventDefault();
  const container = e.target.closest(".InputElements_TagsInputComponent");
  const tag = e.target.closest(bem("tag"));
  tag.parentElement.removeChild(tag);
  container.querySelector(bem("tag_input")).focus();
  updateInput(container);
});

function updateInput(container) {
  const hiddenInput = container.querySelector(bem("hidden_input"));
  hiddenInput.value = getTags(container).join(",");
}

function getTags(container) {
  const elements = container.querySelectorAll("[data-tag]");
  return Array.prototype.slice
    .call(elements)
    .map((el) => el.getAttribute("data-tag"));
}

function addTagFromInput(input, container) {
  const tag = input.value;

  // Empty tag. Move on.
  if (!tag) {
    return;
  }

  input.value = "";
  input.focus();
  const list = container.querySelector(bem("tag_list"));
  const newItem = new TemplateInstance(container.querySelector("template"), {
    tag,
  });
  list.appendChild(newItem);
  updateInput(container);
}
