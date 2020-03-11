import mapboxgl from 'mapbox-gl';

const showMap = document.getElementById('map');
const summaryMap = document.getElementById('summary-map')

const makeMap = () => {
  mapboxgl.accessToken = showMap.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11'
  });
};

const addUserToMap = (map, userMarker) => {
  const popup = new mapboxgl.Popup().setHTML(userMarker.infoWindow);
  const uMarker = document.createElement('i');
  uMarker.className = 'fas fa-map-marker-alt'
  uMarker.style.fontSize = '25px'
  uMarker.style.color = '#3FB1CE'

  new mapboxgl.Marker(uMarker)
    .setLngLat([ userMarker.lng, userMarker.lat ])
    .setPopup(popup)
    .addTo(map);
};

const addVenueToMap = (map, venueMarker) => {
  const popup = new mapboxgl.Popup().setHTML(venueMarker.infoWindow);
  const vMarker = document.createElement('i');
  vMarker.className = 'fas fa-map-marker-alt'
  vMarker.style.fontSize = '25px'
  vMarker.style.color = '#8949da'

  new mapboxgl.Marker(vMarker)
    .setLngLat([ venueMarker.lng, venueMarker.lat ])
    .setPopup(popup)
    .addTo(map);
};

const fitMapZoom = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 50, maxZoom: 15 });
};

const initMapbox = () => {
  if (showMap) {
    const map = makeMap();
    const user = JSON.parse(showMap.dataset.userMarker);
    const venue = JSON.parse(showMap.dataset.venueMarker);
    const markers = JSON.parse(showMap.dataset.markers);
    addUserToMap(map, user);
    addVenueToMap(map, venue);
    fitMapZoom(map, markers);
  }
};

const makeSummaryMap = () => {
  mapboxgl.accessToken = summaryMap.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'summary-map',
    style: 'mapbox://styles/mapbox/streets-v11'
  });
};

const addMarkers = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    const venueMarker = document.createElement('i');
    if (marker.markerType === "bar") {
      venueMarker.className = 'fas fa-glass-martini-alt';
    } else {
      venueMarker.className = 'fas fa-music';
    }
    venueMarker.style.fontSize = '25px';
    venueMarker.style.color = '#8949da';

    new mapboxgl.Marker(venueMarker)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
}

const initSummaryMapbox = () => {
  if (summaryMap) {
    const map = makeSummaryMap();
    const markers = JSON.parse(summaryMap.dataset.markers);
    addMarkers(map, markers);
    fitMapZoom(map, markers);
  }
};

export { initMapbox, initSummaryMapbox };
