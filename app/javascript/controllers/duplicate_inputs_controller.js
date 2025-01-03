import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="duplicate-inputs"
export default class extends Controller {
  static targets = ['formFields', 'title', 'removeBtn']
  connect() {
  }

  remove() {
    if (this.formFieldsTargets.length === 1) {
      return
    }

    const lastVideoInputs = this.formFieldsTargets.pop()
    lastVideoInputs.remove()
    if (this.formFieldsTargets.length === 1) {
      this.removeBtnTarget.classList.add('d-none')
    }
  }

  add() {
    const clone = this.formFieldsTarget.cloneNode(true)
    const inputNumber = this.element.childElementCount - 1

    // rename inputs accordingly
    clone.querySelectorAll('input')
    .forEach((input) => {
      input.setAttribute('id', input.id.replace(/\d/, inputNumber))
      input.setAttribute('name', input.name.replace(/\d/, inputNumber))
      input.value = ''
    })

    // rename labels accordingly
    clone.querySelectorAll('label')
    .forEach((label) => {
      label.setAttribute('for', label.getAttribute('for').replace(/\d/, inputNumber))
    })

    // rename title accordingly
    const cloneTitle = clone.querySelector('p')
    cloneTitle.innerText = cloneTitle.innerText.replace(/\d/, inputNumber + 1)

    // insert before video input actions
    this.element.insertBefore(clone, this.element.lastElementChild)

    // 2 represent the .video-actions element + one formField in the _album_attachments
    // that's why we remove the removeBtn, there's only one input field
    if (this.formFieldsTargets.length === 2) {
      this.removeBtnTarget.classList.remove('d-none')
    }

  }
}
