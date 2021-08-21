import { on } from "delegated-events";

on("click", "[data-toggle-sidebar]", () => {
  const content = document.getElementById("content");
  const sidebar = document.getElementById("sidebar");

  content.classList.toggle("sidebar-hidden");
  sidebar.classList.toggle("hidden");
});
