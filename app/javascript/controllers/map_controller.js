import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'



// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    tilesets: Array,
    style: String,
    canClose: Boolean
  }

  static targets = ['mapContainer', 'menuOption', 'listingGroup', "cover"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: this.styleValue,
      center: [-41.69857001374035, -22.07093159509607],
      zoom: 7
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }

    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()




    // Initialize hover variable and timeout variable to be used on close popup
    this.hoveredPolygonId = null
    this.removalTimeout = null


    this.map.on('load', (e) => {
      // Load an image from an external URL.
      let iconUrls = []
      this.tilesetsValue.forEach(tileset => {
        tileset.icons.forEach(url => {
          if (!iconUrls.includes(url)) {
            iconUrls.push(url)
          }
        })
      })
      // console.log(iconUrls)
      iconUrls.forEach((iconUrl) => {
        // console.log(iconUrl)
        const iconExists = this.map.hasImage(iconUrl);
        // console.log(iconExists)
        if (!iconExists) {
          this.map.loadImage(iconUrl, (error, image) => {
            if (error) throw error;

            // Add the loaded image to the style's sprite with the ID 'kitten'.
            this.map.addImage(iconUrl, image);
          })
        }
        this.map.listImages()
      })

      this.tilesetsValue.forEach((tileset) => {
        // console.log(tileset)

        // ADD SOURCE
        this.map.addSource(tileset.sourceValue, {
          type: 'vector',
          url: tileset.urlValue
        });

        // ADD LAYERS

        // POLYGON LAYER
        // skip specific property
        this.map.addLayer({
          'id': tileset.sourceValue + '-polygons',
          'type': 'fill',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-areas',
          'paint': {
            'fill-color': ['get', 'fill'],
            'fill-opacity': [
              'case',
              ['boolean', ['feature-state', 'hover'], false],
              ['get', 'fill-opacity'],
              ['/', ['get', 'fill-opacity'], 2]
            ],
          },
          'filter': [
            'all',
            ['>', ['number', ['get', 'fill-opacity']], 0.2],
          ]
        }, "settlement-minor-label");

        this.map.addLayer({
          'id': tileset.sourceValue + '-polygons-stroke',
          'type': 'line',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-areas',
          'paint': {
            'line-color': ['get', 'stroke'],
            'line-opacity': ['get', 'stroke-opacity'],
            // 'line-width': ['*', ['get', 'stroke-width'], 10]
            'line-width': [
              'match',
              ['get', 'stroke'],
              '#00aa00', 3,
              // 'value2', ['*', ['get', 'stroke-width'], 20],
              50 // default value
            ]
          },
          'filter': [
            'all',
            ['<', ['number', ['get', 'fill-opacity']], 0.3],
          ]
        }, "settlement-minor-label");

        // LINE LAYER
        this.map.addLayer({
          'id': tileset.sourceValue + '-lines',
          'type': 'line',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-lines',
          'paint': {
            'line-color': [ 'get', 'stroke' ],
            // Stroke opacity em 1 funciona para Rio das Ostras Oleodutos
            'line-opacity': 1,
            // 'line-opacity': ['get', 'stroke-opacity'],
            'line-width': ['get', 'stroke-width']
          }
        }, "settlement-minor-label");

        // new layer for adding name on top of lines
        this.map.addLayer({
          'id': tileset.sourceValue + '-lines-label',
          'type': 'symbol',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-lines',
          'layout': {
            'text-field': ['get', 'name'],
            'symbol-placement': 'line'
          },
          'paint': {
            'text-color': '#f8f8ff'
          }
        }, "settlement-minor-label");

        // ICON LAYER
        this.map.addLayer({
          'id': tileset.sourceValue + '-points',
          'type': 'symbol',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-points',
          "layout": {
            "icon-image": ['get', 'icon'],
            "icon-size": 0.5,
            "icon-allow-overlap": true
          },
          "paint": {
            "icon-opacity": [
              'case',
              ['boolean', ['feature-state', 'hover'], false],
              1,
              0.7
            ]
          }
        }, "settlement-minor-label");

        // ADD EVENT LISTENERS
        this.map.on('mouseenter', tileset.sourceValue + '-points', (event) => {
          this.updateHoveredlayerElement(event, 'inspections-points', tileset.sourceValue)

        })

        this.map.on('mouseleave', tileset.sourceValue + "-points", (e) => {
          if (this.hoveredPolygonId) {
            this.map.getCanvas().style.cursor = '';
            this.map.setFeatureState(
              { source: tileset.sourceValue, sourceLayer: 'inspections-points', id: this.hoveredPolygonId },
              { hover: false }
            );
          }
        })

        this.map.on('mousemove', tileset.sourceValue + '-polygons', (e) => {
          this.updateHoveredlayerElement(e, 'inspections-areas', tileset.sourceValue)
        });


        this.map.on('mouseenter', tileset.sourceValue + '-polygons', (event) => {
          this.updateHoveredlayerElement(event, 'inspections-areas', tileset.sourceValue)

        })

        this.map.on('mouseleave', tileset.sourceValue + "-polygons", (e) => {
          if (this.hoveredPolygonId) {
            this.map.getCanvas().style.cursor = '';
            this.map.setFeatureState(
              { source: tileset.sourceValue, sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
              { hover: false }
            );
          }
        })

        // detect zoomend on console
        this.map.on('zoomend', (e) => {
          console.log(e)
          const zoomLevel = this.map.getZoom();
          console.log("Zoom level: ", zoomLevel);
        });
      })
    })

    // add zoom in to clicked city name
    this.map.on('click', 'settlement-minor-label', (e) => {
      // Zoom to level 10
      this.map.flyTo({
        center: e.lngLat,
        zoom: 12,
        speed: 0.2
      });
    });

    this.map.on('click', (event) => {
      const features = this.map.queryRenderedFeatures(event.point)
      // console.log(features.length > 0)
      const feature = features[0]
      if (!feature) {
        return;
      }

      const isPolygonLayer = feature.layer.id.includes('-polygons')
      const isPointLayer = feature.layer.id.includes('-points')
      const isLineLayer = feature.layer.id.includes('-lines')
      if (isPointLayer || isPolygonLayer || isLineLayer) {
        this.removeSourcePopup()
        this.addSourcePopup(feature, event.lngLat)
      }
    })
  }

  // When the user moves their mouse over the state-fill layer, we'll update the
  // feature state for the feature under the mouse.
  updateHoveredlayerElement(event, sourceLayer, tilesetSourceValue) {
    this.map.getCanvas().style.cursor = 'pointer';
    if (event.features.length > 0) {
      if (this.hoveredPolygonId !== null) {
        this.map.setFeatureState(
          { source: tilesetSourceValue, sourceLayer: sourceLayer, id: this.hoveredPolygonId },
          { hover: false }
        );
      }
      this.hoveredPolygonId = event.features[0].id;
      this.map.setFeatureState(
        { source: tilesetSourceValue, sourceLayer: sourceLayer, id: this.hoveredPolygonId },
        { hover: true }
      );
    }
  }

  removeSourcePopup() {
    if (this.popup && this.popup.isOpen()) {
      this.popup.remove()
    }
    this.hoveredPolygonId = null
  }

  addSourcePopup(feature, coordinates) {
    if (this.popup && this.popup.isOpen()) {
      return undefined
    }

    let popHTML = `<div>`
    const properties = feature.properties
    // console.log(properties)
    popHTML += `<h6><strong>${properties.name}</strong></h6>`
    popHTML += `<p class="mb-0">${properties.description}</p>`
    popHTML += '</div>'

    this.popup = new mapboxgl.Popup({
      closeButton: true,
      closeOnClick: false,
      className: 'area_popup'
    }).setHTML(popHTML)

    this.popup.setLngLat(coordinates)
              .addTo(this.map)
  }

  coverWarning() {
    if (this.map.dragPan.isEnabled() || this.map.scrollZoom.isEnabled()) {
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
