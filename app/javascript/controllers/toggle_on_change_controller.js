import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-on-change"
export default class extends Controller {
  static targets = ['category', 'photo', 'document', 'video']
  connect() {
    if (this.categoryTarget.value !== '') {
      this.dynamicTarget(this.categoryTarget.value).classList.remove('d-none')
    }
  }

  update(event) {
    ['photo', 'document', 'video'].forEach((name) => {
      this.dynamicTarget(name).classList.add('d-none')
    })
    const selected = event.currentTarget.value
    if (selected !== '') {
      this.dynamicTarget(selected).classList.remove('d-none')
    }
  }

  dynamicTarget(name) {
    return this[`${name}Target`]
  }
}
