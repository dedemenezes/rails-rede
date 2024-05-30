import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="publish-checkbox"
export default class extends Controller {
  static targets = ['label', 'input']
  connect() {
    this.updateHint()
  }

  updateHint(event = null) {
    if (this.inputTarget.checked) {
      this.labelTarget.innerText = "Publicar ✅"
    } else {
      this.labelTarget.innerText = "Publicar ❌"
    }
  }
}
