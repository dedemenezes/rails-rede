import { Controller } from "@hotwired/stimulus"
import TomSelect from 'tom-select'

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = {
    options: Object,
    maxItem: Number
  }

  connect() {
    console.log('hi');
    new TomSelect(this.element, {
      hideSelected: true,
      loadingClass: 'tag__select',
      maxItems: this.maxItemValue,
      valueField: 'value'
    })
  }
}
