import { on } from "delegated-events";

on("click", "[data-clipboard-selector]", async (event) => {
  event.preventDefault();
  let button = event.target;
  if (button.tagName !== "BUTTON") {
    button = button.parentElement;
  }
  const confirmation = button.querySelector(
    "[data-clipboard-copy-confirmation]"
  );
  const icon = button.querySelector("[data-clipboard-icon]");
  const selector = button.getAttribute("data-clipboard-selector");
  const element = document.querySelector(selector);
  console.log(button, icon, confirmation);

  confirmation.hidden = false;
  icon.hidden = true;
  setTimeout(() => {
    confirmation.hidden = true;
    icon.hidden = false;
  }, 1000);
  await navigator.clipboard.writeText(element.innerText);
});
