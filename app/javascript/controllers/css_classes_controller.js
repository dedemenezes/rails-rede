import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="css-classes"
export default class extends Controller {
  static classes = ['scrolling']
  connect() {
  }

  onScroll(event) {
    console.log(event);
    console.log(window.scrollY);

    if (window.scrollY > 60) {
      this.element.classList.add(this.scrollingClass)
    } else {
      this.element.classList.remove(this.scrollingClass)
    }

    // if window height is greater than 60
    // if window.scrollY >
    // if its zero
    // no class
    //
    console.log("SCROLLED CSS_CLASSES!");
  }
}
