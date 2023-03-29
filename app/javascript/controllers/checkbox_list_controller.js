import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox-list"
export default class extends Controller {
  static targets = ['checkbox', 'count']
  static values = {
    countText: String
  }

  connect() {
    this.#setCount()
  }
  checkNone(e) {
    e.preventDefault()
    this.checkboxTargets.forEach(target => target.checked = false)
    this.#setCount()
  }

  checkAll(e) {
    e.preventDefault()
    this.checkboxTargets.forEach(target => target.checked = true)
    this.#setCount()
  }

  onCheck() {
    this.#setCount()
  }

  #setCount() {
    if (this.hasCountTarget) {
      this.countTarget.innerText = `${this.selectedCheckboxes.length} ${this.#pluralizedCountText()}`
    }
  }

  #pluralizedCountText() {
    if (this.selectedCheckboxes.length > 1) {
      return `${this.countTextValue}s`
    } else {
      return `${this.countTextValue}`
    }
  }

  get selectedCheckboxes() {
   return this.checkboxes.filter(checkbox => checkbox.checked)
  }

  get checkboxes() {
    return Array.from(this.checkboxTargets)
  }
}
