import places from 'places.js';

console.log("log 1")
const initAutocomplete = () => {
  console.log("log 2")
  const addressInput = document.getElementById('venue_location');
  if (addressInput) {
    places({
      container: addressInput,
     });
  }
};

export { initAutocomplete };
