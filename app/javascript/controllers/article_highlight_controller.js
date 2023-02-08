import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="article-highlight"
export default class extends Controller {
  static targets = [ 'text', 'news' ]
  connect() {
    const h1 = this.newsTarget.firstElementChild.firstElementChild
    console.log(h1);
    const third_paragraph = h1.nextElementSibling.nextElementSibling.nextElementSibling
    third_paragraph.appendChild(this.textTarget)
    if (this.newsTarget.hasChildNodes('h1')) {
    }
  }
}
