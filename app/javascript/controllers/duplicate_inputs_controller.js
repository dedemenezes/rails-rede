import { Controller } from "@hotwired/stimulus"
import { controllers } from "trix";
import { ContextExclusionPlugin } from "webpack";

// Connects to data-controller="duplicate-inputs"
export default class extends Controller {
  static targets = ['formFields', 'title']
  connect() {
    console.log("connected!");
  }

  add() {
    const clone = this.formFieldsTarget.cloneNode(true)
    const inputNumber = this.element.childElementCount - 1

    clone.querySelectorAll('input')
    .forEach((label) => {
      label.setAttribute('id', label.id.replace(/\d/, inputNumber))
      label.setAttribute('name', label.name.replace(/\d/, inputNumber))
    })

    clone.querySelectorAll('label')
    .forEach((label) => {
      label.setAttribute('for', label.getAttribute('for').replace(/\d/, inputNumber))
    })

    const cloneTitle = clone.querySelector('p')
    console.log(cloneTitle)
    cloneTitle.innerText = cloneTitle.innerText.replace(/\d/, inputNumber + 1)

    this.element.insertBefore(clone, this.element.lastElementChild)
  }
}



// clone.querySelectorAll('input')
//         .forEach((label) => {
//           label.setAttribute('name', label.name.replace(/\d/, controller.childElementCount - 1))
//         })
