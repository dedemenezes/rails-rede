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
      center: [-42.21261111043489, -22.86973318580614],
      zoom: 10
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }
    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()




    this.hoveredPolygonId = null
    this.map.on('load', (e) => {
      // Load an image from an external URL.
      this.tilesetsValue[0]["icons"].forEach((iconUrl) => {
        this.map.loadImage(iconUrl, (error, image) => {
          if (error) throw error;
          // Add the loaded image to the style's sprite with the ID 'kitten'.
          this.map.addImage(iconUrl, image);
        });
      })

      this.tilesetsValue.forEach((tileset) => {
        // console.log(tileset)
        // ADD SOURCES
        this.map.addSource(tileset.sourceValue, {
          type: 'vector',
          url: tileset.urlValue
        });

        // ADD LAYERS

        // POLYGON LAYER
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
              0.7,
              0.2
            ],
          }
        });

        this.map.addLayer({
          'id': tileset.sourceValue + '-lines',
          'type': 'line',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-lines',
          'paint': {
            'line-color': [ 'get', 'stroke' ],
            // 'line-opacity': ['get', 'stroke-opacity'],
            'line-width': ['get', 'stroke-width']
          }
        })

        // ICON LAYER
        this.map.addLayer({
          'id': tileset.sourceValue + '-points',
          'type': 'symbol',
          'source': tileset.sourceValue,
          'source-layer': 'inspections-points',
          "layout": {
            "icon-image": ['get', 'icon'],
            "icon-size": 0.5,
          },
          "paint": {
            "icon-opacity": [
              'case',
              ['boolean', ['feature-state', 'hover'], false],
              1,
              0.7
            ]
          }
        });

        // ADD EVENT LISTNERS
        this.map.on('mouseenter', tileset.sourceValue + '-points', (event) => {
          this.updateHoveredlayerElement(event, 'inspections-points', tileset.sourceValue)

        })

        this.map.on('mouseleave', tileset.sourceValue + '-points', (e) => {
          if (this.hoveredPolygonId) {
            this.map.getCanvas().style.cursor = '';
            this.map.setFeatureState(
              { source: tileset.sourceValue, sourceLayer: 'inspections-points', id: this.hoveredPolygonId },
              { hover: false }
            );
          }
        })

        // When the user moves their mouse over the state-fill layer, we'll update the
        // feature state for the feature under the mouse.
        this.map.on('mousemove', tileset.sourceValue + '-polygons', (e) => {
          this.updateHoveredlayerElement(e, 'inspections-areas', tileset.sourceValue)
        });

        this.map.on('mouseenter', tileset.sourceValue + '-polygons', (event) => {
          clearTimeout(this.removalTimeout)
          this.updateHoveredlayerElement(event, 'inspections-areas', tileset.sourceValue)
          // Add popup to the right element
          // 1. access feature description
          const longitudes = event.features[0].geometry.coordinates[0].map(coordinate => coordinate[0])
          const avgLongitude = this.#avgCoordinates(longitudes)
          const latitudes = event.features[0].geometry.coordinates[0].map(coordinate => coordinate[1])
          const avgLatitude = this.#avgCoordinates(latitudes)
          // 2. Create Popup
          // this.addSourcePopup(event, avgLongitude, avgLatitude)
          const mostWestAndEastPoints = this.findMostWestAndEastPoints(event.features[0].geometry.coordinates[0])
          const center = (mostWestAndEastPoints.mostEast[0] + mostWestAndEastPoints.mostWest[0]) / 2

          const mapWidth = this.map.getContainer().getClientRects()[0].width
          console.log(event.lngLat.lng > center ? 'right' : 'left')
          if (event.lngLat.lng > center) {
            this.addSourcePopup(event, mostWestAndEastPoints.mostWest)
          } else {
            this.addSourcePopup(event, mostWestAndEastPoints.mostEast)
          }
          // 3.
        })

        this.map.on('mouseleave', tileset.sourceValue + '-polygons', (e) => {
          if (this.hoveredPolygonId) {
            this.map.getCanvas().style.cursor = '';
            this.map.setFeatureState(
              { source: tileset.sourceValue, sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
              { hover: false }
            );


            this.removePopupWithTimeout()
          }
        })

      })

    })

  }

  removePopupWithTimeout() {
    this.removalTimeout = setTimeout(() => {
      this.removeSourcePopup()
    }, 500);
  }

  clearPopupWithTimeout() {
    if(this.removalTimeout) {
      clearTimeout(this.removalTimeout)
      this.removalTimeout = null
    }
  }

  findMostWestAndEastPoints(coordinates) {
    // Initialize with the first coordinate
    let mostWest = coordinates[0];
    let mostEast = coordinates[0];

    // Iterate through the coordinates to find the most west and most east points
    for (const [longitude, latitude] of coordinates) {
      if (longitude < mostWest[0]) {
        mostWest = [longitude, latitude];
      }

      if (longitude > mostEast[0]) {
        mostEast = [longitude, latitude];
      }
    }

    return { mostWest, mostEast };
  }

  #avgCoordinates(coordinates) {
    const coordinatesSum = coordinates.reduce((acc, coordinate) => {
      return acc + coordinate
    }, 0)
    return coordinatesSum / coordinates.length
  }

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

  setFeatureSourceId(sourceValue, feature, index) {
    const featureType = feature.geometry.type
    const featureStyleUrl = feature.properties.styleUrl
    return `${index + 1}_${sourceValue}-${featureType}${featureStyleUrl}`
  }

  addSourcePopupsOnHovering(layerId) {
    this.hoveredPolygonId = null
    this.popup = null

    this.map.on('mouseenter', layerId, (e) => {
      this.addSourcePopup(e)

      const feature = e.features[0]
      console.log(feature);
      console.log(e);
    })

    this.map.on('mouseleave', layerId, (e) => {
      this.removeSourcePopup()
    })
  }

  removeSourcePopup() {
    if (this.popup && this.popup.isOpen()) {
      this.popup.remove()
      this.popup = null
    }
    this.hoveredPolygonId = null
  }

  addSourcePopup(event, coordinates) {
    if (this.popup) {

      return undefined
    }

    let popHTML = `<p data-action="mouseover->map#clearPopupWithTimeout mouseleave->map#removePopupWithTimeout">`
    const properties = event.features[0].properties
    Object.entries(properties).forEach((k) => {
      if(k[0] === 'description') {
        popHTML += `<strong>${k[0]}:</strong> ${k[1]}<br>`
      }
    })
    popHTML += '</p>'

    this.popup = new mapboxgl.Popup({
      closeButton: false,
      closeOnClick: false,
      className: 'area_popup'
    }).setHTML(popHTML)

    this.popup.setLngLat(coordinates)
              .addTo(this.map)
    document.querySelector('.area_popup').addEventListener('mouseover', (e) => {
      console.log('from event listner inside addSourcePopup')
      this.clearPopupWithTimeout()
    })
    document.querySelector('.area_popup').addEventListener('mouseleave', (e) => {
      this.removePopupWithTimeout()
    })
  }

  coverWarning() {
    if (this.map.dragPan.isEnabled() || this.map.scrollZoom.isEnabled()) {
    } else {
      this.#displayCoverElement()
      this.#fadeOutCoverElement()
    }
  }

  #loadImageAndAddToMap(map, icon, callback) {
    const nameRegex = /.+\/(.+\w+)\.\w+$/
    const imgName = icon.match(nameRegex)[1]

    map.loadImage(icon, (error, image) => {
      if (error) throw error

      map.addImage(imgName, image);
      callback(imgName)
    })
  }

  #processFeatures(map, feature, imgName, index) {
    const featureSourceId = this.setFeatureSourceId(this.macae.sourceValue, feature, index)
    map.addSource(featureSourceId, {
      'type': 'geojson',
      'data': feature
    })
    this.map.addLayer(
      {
        id: featureSourceId + '-icon',
        // References the GeoJSON source defined above
        // and does not require a `source-layer`
        source: featureSourceId,
        type: 'symbol',
        layout: {
          // Set the label content to the
          // feature's `name` property
          'icon-image': imgName, // reference the image
          'icon-size': 0.25
        }
      },
    )
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
