import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-button-on-hover"
export default class extends Controller {
  static targets = ['observatoryBtn', 'observatory', 'observatoryInput', 'methodologyBtn', 'methodology', 'methodologyInput']
  connect() {
    console.log(this.observatoryTarget)
  }

  display(e) {
    e.preventDefault()
    if (this.methodologyTarget.classList.contains('box--show')) {
      this.methodologyInputTarget.value = ''
      this.methodologyBtnTarget.classList.remove('btn-rede-news')
      this.methodologyBtnTarget.innerText = 'Metodologia'
      this.methodologyTarget.classList.remove('box--show')
    }

    this.observatoryTarget.classList.toggle('box--show')
    this.observatoryBtnTarget.classList.toggle('btn-rede-news')
    this.updateButtonText(this.observatoryBtnTarget, 'Observatório')
    if (!this.observatoryTarget.classList.contains('box--show')) {
      this.observatoryInputTarget.value = ''
    }
  }

  updateButtonText(button, text) {
    if (button.innerText === text) {
      button.innerText = 'Cancel'
    } else {
      button.innerText = text
    }
  }

  methodology(e) {
    // 0. previnir envio do botao
    e.preventDefault()
    // 1.0 se o observatorio estiver aberto
    if (this.observatoryTarget.classList.contains('box--show')) {
      this.observatoryInputTarget.value = ''
      this.observatoryBtnTarget.classList.remove('btn-rede-news')
      this.observatoryBtnTarget.innerText = 'Observatório'
      this.observatoryTarget.classList.remove('box--show')
    }

    this.methodologyTarget.classList.toggle('box--show')
    this.methodologyBtnTarget.classList.toggle('btn-rede-news')
    this.updateButtonText(this.methodologyBtnTarget, 'Metodologia')

    if (!this.methodologyTarget.classList.contains('box--show')) {
      this.methodologyInputTarget.value = ''
    }
  }
}
