import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-input"
export default class extends Controller {
  static targets = ['input', 'button', 'wrapper']
  connect() {
  }

  new() {
    this.nextInputIndex = this.inputTargets.length
    const labelClone = this.inputTarget.previousElementSibling.cloneNode(true)
    const labelCloneForValue = `album_videos_attributes_${this.nextInputIndex}_url`
    labelClone.setAttribute('for', labelCloneForValue)

    const inputElement = document.createElement('input')
    inputElement.type = 'url'
    const name = `album[videos_attributes][${this.nextInputIndex}][url]`
    inputElement.name = name
    inputElement.setAttribute('id', name)
    inputElement.dataset.addInputTarget = 'input'
    inputElement.classList.add('form-control')
    inputElement.classList.add('string')
    inputElement.classList.add('url')
    inputElement.classList.add('required')

    const wraper = this.inputTarget.parentElement.cloneNode()
    wraper.insertAdjacentElement('afterbegin', labelClone)
    wraper.insertAdjacentElement('beforeend', inputElement)

    this.inputTargets[this.nextInputIndex - 1].parentElement.insertAdjacentElement('afterend', wraper)
  }
}
