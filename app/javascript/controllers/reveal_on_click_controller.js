import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal-on-click"
export default class extends Controller {
  static targets = ['button', 'icon', 'dropdown']

  connect() {
  }

  toggle(e) {
    console.log(this.buttonTarget)
    this.buttonTarget.classList.toggle('active')
    this.dropdownTarget.classList.toggle('active')
    if (this.hasIconTarget) {
      const transformDegrees = this.dropdownTarget.classList.contains('active') ? 'rotate(0deg)' : 'rotate(-90deg)'
      this.iconTarget.style.transform = transformDegrees
    }
  }

  close() {
    this.toggle()
  }
}