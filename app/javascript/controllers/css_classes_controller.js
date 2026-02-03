import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="css-classes"
export default class extends Controller {
  static classes = ['scrolling']
  connect() {
  }

  onScroll(event) {
    if (window.scrollY > 60) {
      this.element.classList.add(this.scrollingClass)
    } else {
      this.element.classList.remove(this.scrollingClass)
    }
  }
}
