import { Controller } from "@hotwired/stimulus"
import TomSelect from 'tom-select'

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = {
    options: Object,
    maxItem: Number
  }

  connect() {
    new TomSelect(this.element, {
      plugins: ['remove_button'],
      hideSelected: true,
      loadingClass: 'tag__select',
      maxItems: this.maxItemValue,
      valueField: 'value',
      allowEmptyOption: true
    })
  }
}
