import { Controller } from "@hotwired/stimulus"
import PhotoSwipeLightbox from 'photoswipe/lightbox';

// Connects to data-controller="photoswipe-album"
export default class extends Controller {
  connect() {
    this.lightbox = new PhotoSwipeLightbox({
      gallery: this.element,
      children: 'a',
      pswpModule: () => import('photoswipe')
    });
    this.lightbox.init()
  }
}
