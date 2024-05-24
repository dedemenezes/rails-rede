import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-input"
export default class extends Controller {
  static targets = ['input', 'button', 'wrapper']
  connect() {
  }

  new(event) {
    const newInputBlock = this.buildUrlFormInputBlock()
    this.element.lastElementChild.insertAdjacentElement('beforebegin', newInputBlock)
  }

  labelHTML() {
    // `<label class="form-label url required" for="album_videos_attributes_1_url">
    //   Url
    //   <abbr title="required">*</abbr>
    // </label>`
    const label = document.createElement('label')
    label.classList.add('form-label')
    label.classList.add('url')
    label.classList.add('required')
    label.setAttribute('for', `album_videos_attributes_${this.inputTargets.length}_url`)
    label.innerHTML = `Url<abbr title="required">*</abbr>`
    return label
  }

  inputHTML() {
    const inputElement = document.createElement('input')
    inputElement.type = 'url'
    const name = `album[videos_attributes][${this.inputTargets.length}][url]`
    inputElement.name = name
    inputElement.setAttribute('id', name)
    inputElement.dataset.addInputTarget = 'input'
    inputElement.classList.add('form-control')
    inputElement.classList.add('string')
    inputElement.classList.add('url')
    inputElement.classList.add('required')
    return inputElement
  }

  wrapperHTML() {
    // <div data-add-input-target="wrapper" class="mb-3 url required album_videos_url">
    // </div>
    const wrapper = document.createElement('div')
    wrapper.classList.add('mb-3')
    wrapper.classList.add('url')
    wrapper.classList.add('required')
    wrapper.classList.add('album_videos_url')
    wrapper.dataset.addInputTarget = 'wrapper'
    return wrapper
  }

  buildUrlFormInputBlock() {
    const formInputBlock = this.wrapperHTML()
    formInputBlock.insertAdjacentElement('afterbegin', this.labelHTML(this.inputTargets.length))
    formInputBlock.insertAdjacentElement('beforeend', this.inputHTML(this.inputTargets.length))
    return formInputBlock
  }
}
