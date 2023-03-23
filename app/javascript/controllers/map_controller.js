import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'


// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.map.dragPan.disable()
    this.map.scrollZoom.disable()


    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.#addNavigationtoMap()
    // this.map.on('touchstart', (e) => {
    //   console.log(`A touchstart event occurred at ${e.lngLat}.`);
    //   this.map.dragPan.enable()

    // })
    // this.map.on('touchend', () => {
    //   this.map.dragPan.disable()
    //   console.log(`A touchend event occurred at ${e.lngLat}.`);
    // });
    // this.map.on('click', (e) => {
    //   alert('double click to activate scroll zoom')
    // })
    // this.map.on('dclick', (e) => {
    //   alert('double click to activate scroll zoom')
    //   console.log(this.map.scrollZoom);
    // })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '19px';
      element.style.height = '25px';
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #addNavigationtoMap() {
    const nav = new mapboxgl.NavigationControl({
      showCompass: true,
      showZoom: true
    })
    this.map.addControl(nav, 'bottom-right');
  }
}
