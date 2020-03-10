import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const makeMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11'
  });
};

const addUserToMap = (map, userMarker) => {
  const popup = new mapboxgl.Popup().setHTML(userMarker.infoWindow);
  new mapboxgl.Marker({ color: '#8949da' })
    .setLngLat([ userMarker.lng, userMarker.lat ])
    .setPopup(popup)
    .addTo(map);
};

const addVenueToMap = (map, venueMarker) => {
  const popup = new mapboxgl.Popup().setHTML(venueMarker.infoWindow);
  new mapboxgl.Marker()
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
  if (mapElement) {
    const map = makeMap();
    const user = JSON.parse(mapElement.dataset.userMarker);
    const venue = JSON.parse(mapElement.dataset.venueMarker);
    const markers = JSON.parse(mapElement.dataset.markers);
    addUserToMap(map, user);
    addVenueToMap(map, venue);
    fitMapZoom(map, markers);
  }
};

export { initMapbox };
