import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'



// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    tilesets: Array,
    style: String,
  }

  static targets = ['mapContainer', 'menuOption', 'listingGroup', "cover"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: this.styleValue
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }
    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()

    this.map.on('load', (e) => {
      console.log(e)
      this.tilesetsValue.forEach((tileset) => {
        // Log the features to the console
        const features = this.map.querySourceFeatures(tileset.sourceValue);
        console.log(features);

        // Add Araruama tileset as source
        this.addSource(tileset)

        // Add new layer to dislay the tileset
        this.addSourceLayer(tileset)

        // Add new layer to dislay the tileset as points
        this.addPointLayer(tileset)

        this.addSourcePopupsOnHovering(tileset)
      })
    })

    // this.map.on('load', () => {
    //   // Load an image from an external URL.
    //   this.map.loadImage(
    //     'https://docs.mapbox.com/mapbox-gl-js/assets/cat.png',
    //     (error, image) => {
    //       if (error) throw error;

    //       // Add the image to the map style.
    //       this.map.addImage('cat', image);

    //       // Add a data source containing one point feature.
    //       this.map.addSource('point', {
    //         'type': 'geojson',
    //         'data': {
    //           'type': 'FeatureCollection',
    //           'features': [
    //             {
    //               'type': 'Feature',
    //               'geometry': {
    //                 'type': 'Point',
    //                 'coordinates': [-77.4144, 25.0759]
    //               }
    //             }
    //           ]
    //         }
    //       });

    //       // Add a layer to use the image to represent the data.
    //       this.map.addLayer({
    //         'id': 'points',
    //         'type': 'symbol',
    //         'source': 'point', // reference the data source
    //         'layout': {
    //           'icon-image': 'cat', // reference the image
    //           'icon-size': 0.25
    //         }
    //       });
    //     }
    //   );
    // });

  }

  addSource(tileset) {
    // console.log(tileset);
    this.map.addSource(tileset.sourceValue, {
      type: 'vector',
      url: tileset.urlValue,
      id: tileset.sourceValue // This ensures that all features have unique IDs
    })
  }

  addSourceLayer(tileset) {
    this.map.addLayer({
      'id': tileset.sourceValue + '-fill',
      'type': 'fill',
      'source': tileset.sourceValue,
      'layout': {
        // Make the layer visible by default.
        'visibility': 'visible'
      },
      'paint': {
        'fill-color': 'rgba(55,148,179,0.5)'
      },
      'source-layer': tileset.sourceValue,
      'filter': ['==', ['geometry-type'], 'Polygon']
    })
    // Add a symbol layer for displaying names on fill polygons
    this.map.addLayer({
      'id': tileset.sourceValue + '-fill-label',
      'type': 'symbol',
      'source': tileset.sourceValue,
      'layout': {
        'text-field': ['get', 'name'], // Display the 'name' property as text
        'text-size': 12,
        'text-anchor': 'bottom'
      },
      'paint': {
        'text-color': 'rgba(0,0,0,1)'
      },
      'source-layer': tileset.sourceValue,
      'filter': ['==', ['geometry-type'], 'Polygon'] // Filter for polygon features
    });
  }

  addPointLayer(tileset) {
    this.map.addLayer({
      'id': tileset.sourceValue + '-point',
      'type': 'circle', // Use 'circle' for point data
      'source': tileset.sourceValue,
      'layout': {
        // Make the layer visible by default.
        'visibility': 'visible',
        // 'text-field': ['get', 'name'], // Display the 'name' property as text
        // 'text-size': 12
      },
      'paint': {
        'circle-radius': 2,
        'circle-color': 'rgba(255,0,0,1)'
      },
      'source-layer': tileset.sourceValue,
      'filter': ['==', ['geometry-type'], 'Point']
    });
    this.map.addLayer({
      'id': tileset.sourceValue + '-point-label',
      'type': 'symbol',
      'source': tileset.sourceValue,
      'layout': {
        'text-field': ['get', 'name'], // Display the 'name' property as text
        'text-size': 12,
        'text-anchor': 'bottom'
      },
      'paint': {
        'text-color': 'rgba(0,0,0,1)'
      },
      'source-layer': tileset.sourceValue,
      'filter': ['==', ['geometry-type'], 'Point'] // Filter for point features
    });
  }

  addSourcePopupsOnHovering(tileset) {
    this.hoveredPolygonId = null
    this.popup = null
    // this.map.on('mousemove', this.sourceValue, (e) => {
    // if (e.features.length > 0) {
    //   if (this.hoveredPolygonId !== null) {
    //     this.map.setFeatureState(
    //       { source: this.sourceValue, sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
    //       { hover: false }
    //     )
    //   }
    //   this.hoveredPolygonId = e.features[0].id
    //   this.map.setFeatureState(
    //     { source: this.sourceValue, sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
    //     { hover: true }
    //   )
    //   this.addSourcePopup(e)
    // }
    // })

    this.map.on('mouseenter', tileset.sourceValue + '-fill', (e) => {
      this.addSourcePopup(e)
      console.log(`ENTROU!`);
      // Single out the first found feature.
      const feature = e.features[0];
      console.log(e);
    })

    this.map.on('mouseleave', tileset.sourceValue + '-fill', (e) => {
      console.log(`SAIU!`);
      console.log(e);
      this.removeSourcePopup()
    });
  }

  removeSourcePopup() {
    if (this.popup.isOpen()) {
      this.popup.remove()
      this.popup = null
    }
    this.hoveredPolygonId = null;
  }

  addSourcePopup(event) {

    // if (this.popup) {
    //   this.popup.remove()
    // }
    // create popup
    if (this.popup) {
      return undefined
    }

    let popHTML = `<p>`
    const properties = event.features[0].properties
    // console.log(properties);
    Object.entries(properties).forEach((k) => popHTML += `<strong>${k[0]}:</strong> ${k[1]}<br>`)
    popHTML += '</p>'

    this.popup = new mapboxgl.Popup().setHTML(popHTML)
    // Display a popup with the name of the county
    this.popup.setLngLat([event.lngLat.lng, event.lngLat.lat])
              .addTo(this.map);
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
