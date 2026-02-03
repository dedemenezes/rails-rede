import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal-on-click"
export default class extends Controller {
  static targets = ['button', 'icon', 'dropdown', "hiddenAtStart", "visibleAtStart"]

  connect() {
  }

  display() {
    this.visibleAtStartTargets.forEach(target => target.classList.add("d-none"))

    this.hiddenAtStartTargets.forEach(target => target.classList.remove("d-none"))
  }

  hide() {
    this.visibleAtStartTargets.forEach(target => target.classList.remove("d-none"))

    this.hiddenAtStartTargets.forEach(target => target.classList.add("d-none"))
  }

  toggle(e) {
    e.preventDefault()
    this.buttonTarget.classList.toggle('active')
    this.dropdownTarget.classList.toggle('active')
    if (this.hasIconTarget) {
      const transformDegrees = this.dropdownTarget.classList.contains('active') ? 'rotate(0deg)' : 'rotate(-90deg)'
      this.iconTarget.style.transform = transformDegrees
    }
  }

  close(event) {
    // Ignore event if clicked within element
    if(this.element === event.target || this.element.contains(event.target)) {
      return
    }

    // Execute the actual action we're interested in
    this.buttonTarget.classList.remove('active')
    this.dropdownTarget.classList.remove('active')
    if (this.hasIconTarget) {
      const transformDegrees = this.dropdownTarget.classList.contains('active') ? 'rotate(0deg)' : 'rotate(-90deg)'
      this.iconTarget.style.transform = transformDegrees
    }
  }
}
