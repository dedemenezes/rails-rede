import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="publish-checkbox"
export default class extends Controller {
  static targets = ['label', 'input']
  static values = {
    text: String
    ,featured: Boolean
  }

  connect() {
    this.updateHint()
  }

  updateHint(event = null) {
    if (event && this.featuredValue){
      // Swal.fire()
    }

    if (this.inputTarget.checked) {
      this.labelTarget.innerText = `${this.textValue} ✅`
    } else {
      this.labelTarget.innerText = `${this.textValue} ❌`
    }
  }
}
