import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-button-on-hover"
export default class extends Controller {
  static targets = [
    'observatoryBtn',
    'observatory',
    'observatoryInput',
    'methodologyBtn',
    'methodology',
    'methodologyInput',
    'projectBtn',
    'project',
    'projectInput'
  ]
  static values = {
    writerType: String
  }
  connect() {

    switch (this.writerTypeValue) {
      case '':
        this.#cleanInputs()
      case 'observatory':
        this.projectInputTarget.value = ''
        this.methodologyInputTarget.value = ''
        const observatoryActive = Array.from(this.observatoryInputTarget.options).find(option => option.selected)
        if (observatoryActive !== undefined && observatoryActive.value !== '') {
          this.#activateObservatory()
        }
        break;

      case 'methodology':
        this.observatoryInputTarget.value = ''
        this.projectInputTarget.value = ''
        const methodologyActive = Array.from(this.methodologyInputTarget.options).find(option => option.selected)
        if (methodologyActive !== undefined && methodologyActive.value !== '') {
          this.#activateMethodology()
        }
        break;

      case 'project':
        this.observatoryInputTarget.value = ''
        this.methodologyInputTarget.value = ''
        const projectActive = Array.from(this.projectInputTarget.options).find(option => option.selected)
        if (projectActive !== undefined && projectActive.value !== '') {
          this.#activateProject()
        }
        break;

      default:
        break;
    }
  }

  updateButtonText(button, text) {
    if (button.innerText === text) {
      button.innerText = 'Cancel'
    } else {
      button.innerText = text
    }
  }

  observatory(e) {
    e.preventDefault()
    // limpar project input
    this.projectInputTarget.value = ''
    this.methodologyInputTarget.value = ''
    this.#unsetProject()
    this.#unsetMethodology()
    this.#activateObservatory()
    if (!this.observatoryTarget.classList.contains('box--show')) {
      this.observatoryInputTarget.value = ''
    }
  }

  methodology(e) {
    // 0. previnir envio do botao
    e.preventDefault()
    this.observatoryInputTarget.value = ''
    this.projectInputTarget.value = ''
    // 1.0 se o observatorio estiver aberto
    this.#unsetObservatory()
    this.#unsetProject()
    this.#activateMethodology()

    if (!this.methodologyTarget.classList.contains('box--show')) {
      this.methodologyInputTarget.value = ''
    }
  }

  project(e) {
    // 0. previnir envio do botao
    e.preventDefault()
    this.observatoryInputTarget.value = ''
    this.methodologyInputTarget.value = ''
    // 1.0 se o observatorio estiver aberto
    this.#unsetObservatory()
    this.#unsetMethodology()
    this.#activateProject()

    if (!this.projectTarget.classList.contains('box--show')) {
      this.projectInputTarget.value = ''
    }
  }

  #cleanInputs() {
    this.observatoryInputTarget.value = ''
    this.methodologyInputTarget.value = ''
    this.projectInputTarget.value = ''
  }

  #activateMethodology() {
    this.methodologyTarget.classList.toggle('box--show')
    this.methodologyBtnTarget.classList.toggle('btn-rede-news')
    this.updateButtonText(this.methodologyBtnTarget, 'Metodologia')
  }
  #activateObservatory() {
    this.observatoryTarget.classList.toggle('box--show')
    this.observatoryBtnTarget.classList.toggle('btn-rede-news')
    this.updateButtonText(this.observatoryBtnTarget, 'Observatório')
  }
  #activateProject() {
    this.projectTarget.classList.toggle('box--show')
    this.projectBtnTarget.classList.toggle('btn-rede-news')
    this.updateButtonText(this.projectBtnTarget, 'Projeto')
  }

  #unsetProject() {
    if (this.projectTarget.classList.contains('box--show')) {
      this.projectBtnTarget.classList.remove('btn-rede-news')
      this.projectBtnTarget.innerText = 'Projeto'
      this.projectTarget.classList.remove('box--show')
    }
  }

  #unsetMethodology() {
    if (this.methodologyTarget.classList.contains('box--show')) {
      this.methodologyInputTarget.value = ''
      this.methodologyBtnTarget.classList.remove('btn-rede-news')
      this.methodologyBtnTarget.innerText = 'Metodologia'
      this.methodologyTarget.classList.remove('box--show')
    }
  }

  #unsetObservatory() {
    if (this.observatoryTarget.classList.contains('box--show')) {
      this.observatoryBtnTarget.classList.remove('btn-rede-news')
      this.observatoryBtnTarget.innerText = 'Observatório'
      this.observatoryTarget.classList.remove('box--show')
    }
  }
}
