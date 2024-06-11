import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="publish-checkbox"
export default class extends Controller {
  static targets = ['label', 'input']
  static values = {
    text: String
  }

  connect() {
    this.updateHint()
  }

  updateHint(event = null) {
    if (this.inputTarget.checked) {
      this.labelTarget.innerText = `${this.textValue} ✅`
    } else {
      this.labelTarget.innerText = `${this.textValue} ❌`
    }
  }
}
