import { Popover } from "../../../../../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js";

window.addEventListener("load", function () {
  const elements = document.querySelectorAll(
    ".Timelines_Timeline_EventComponent__link,.Timelines_TimelineComponent__year"
  );
  const popoverTriggerList = [].slice.call(elements);
  const popoverList = popoverTriggerList.map((element) => {
    element.addEventListener("click", (e) => e.preventDefault());
    return new Popover(element);
  });
});
