import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr'
import { Portuguese } from "flatpickr/dist/l10n/pt.js"

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ['eventDate']
  connect() {
    flatpickr(this.element, {
      altInput: true,
      altFormat: "j \\de F \\de Y",
      dateFormat: "Y-m-d",
      "locale": Portuguese
    })
  }
}
