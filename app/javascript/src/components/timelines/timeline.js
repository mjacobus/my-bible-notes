import { Popover } from "../../../../../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"

window.addEventListener("load", function(){
  const elements = document.querySelectorAll('.Timelines_TimelineComponent__link')
  const popoverTriggerList = [].slice.call(elements)
  const popoverList = popoverTriggerList.map((element) => {
    element.addEventListener('click', (e) => e.preventDefault())
    return new Popover(element)
  })
});
