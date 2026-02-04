import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text", "button", "buttonText"]
  static values = { limit: Number }

  connect() {
    console.log(this.textTarget);

    this.fullText = this.textTarget.textContent.trim()

    if (this.fullText.length <= this.limitValue) {
      this.buttonTarget.classList.add("d-none")
      return
    }

    this.truncatedText = this.truncateAtWord(
      this.fullText,
      this.limitValue
    )
    this.textTarget.textContent = this.truncatedText
  }


  truncateAtWord(text, limit) {
    const truncated = text.slice(0, limit)
    const lastSpaceIndex = truncated.lastIndexOf(" ")

    if (lastSpaceIndex === -1) {
      return truncated + "…"
    }

    return truncated.slice(0, lastSpaceIndex) + "…"
  }

  toggle(event) {
    event.preventDefault()
    if (this.textTarget.classList.contains("expanded")) {
      this.textTarget.textContent = this.truncatedText
      this.textTarget.classList.remove("expanded")
      this.buttonTextTarget.textContent = "Ver mais"
    } else {
      this.textTarget.textContent = this.fullText
      this.textTarget.classList.add("expanded")
      this.buttonTextTarget.textContent = "Ver menos"
    }
  }
}
