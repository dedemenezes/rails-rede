import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'



// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    source: String,
    url: String,
  }

  static targets = ['mapContainer', 'menuOption', 'listingGroup', "cover"]

  connect() {
    console.log(this.sourceValue)
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }
    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()


    this.map.on('load', () => {
      // Add Araruama tileset as source
      this.addSource()

      // Add new layer to dislay the tileset
      this.addSourceLayer()
    })

    this.hoveredPolygonId = null
    this.popup = null
    this.map.on('mousemove', this.sourceValue, (e) => {
      if (e.features.length > 0) {


        if (this.hoveredPolygonId !== null) {
          this.map.setFeatureState(
            { source: 'pea-data', sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
            { hover: false }
          )
        }

        this.hoveredPolygonId = e.features[0].id
        this.map.setFeatureState(
          { source: 'pea-data', sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
          { hover: true }
        )

        console.log(e.features[0])
        this.addSourcePopup(e)
      }
    })

    this.map.on('mouseenter', this.sourceValue, (e) => {
      this.addSourcePopup(e)
      console.log(`ENTROU!`);
    })
    this.map.on('mouseleave', this.sourceValue, () => {
      if (this.hoveredPolygonId  !== null) {
        this.map.setFeatureState(
          { source: 'pea-data', sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
          { hover: false }
        );
        if (this.popup.isOpen()) {
          this.popup.remove()
        }
      }
      this.hoveredPolygonId = null;
    });
  }

  addSource() {
    this.map.addSource('pea-data', {
      type: 'vector',
      url: this.urlValue,
      generateId: true // This ensures that all features have unique IDs
    })
  }

  addSourceLayer() {
    this.map.addLayer({
      'id': this.sourceValue,
      'type': 'fill',
      'source': 'pea-data',
      'layout': {
        // Make the layer visible by default.
        'visibility': 'visible'
      },
      'paint': {
        'fill-color': 'rgba(55,148,179,1)'
      },
      'source-layer': this.sourceValue
    })
  }

  addSourcePopup(event) {
    // Single out the first found feature.
    const feature = event.features[0];
    if (this.popup) {
      this.popup.remove()
    }
    // create popup
    let popHTML = `<p>`
    const properties = event.features[0].properties
    console.log(properties);
    Object.entries(properties).forEach((k) => popHTML += `<strong>${k[0]}:</strong> ${k[1]}`)
    popHTML += '</p>'

    this.popup = new mapboxgl.Popup().setHTML(popHTML)
    // Display a popup with the name of the county
    this.popup.setLngLat([event.lngLat.lng, event.lngLat.lat])
              .addTo(this. map);
      // .setText(feature.properties.Description)
  }

  coverWarning() {
    if (this.map.dragPan.isEnabled() || this.map.scrollZoom.isEnabled()) {
      console.log('DO NOTHING!')
    } else {
      this.#displayCoverElement()
      this.#fadeOutCoverElement()
    }
  }

  #fadeOutCoverElement() {
    setTimeout(() => {
      this.coverTarget.style.opacity = 0
    }, 3000)
    setTimeout(() => {
      this.coverTarget.style.zIndex = -5
    }, 3200)
  }

  #displayCoverElement() {
    this.coverTarget.style.opacity = 1
    this.coverTarget.style.zIndex = 5
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const element = document.createElement('div')
      element.className = 'marker'
      element.style.backgroundImage = `url('${marker.image_url}')`
      element.style.backgroundSize = 'contain'
      element.style.width = '19px'
      element.style.height = '25px'
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
    this.map.addControl(nav, 'bottom-right')
  }

  #addListenersToMeniuOptions() {
    this.listingGroupTarget.addEventListener('change', (event) => {
      const option = event.target.id
      if (event.target.checked) {
        this.map[option].enable()
        this.coverTarget.style.opacity = 0
        this.coverTarget.style.zIndex = -5
      } else {
        this.map[option].disable()
      }
    })
  }
}
