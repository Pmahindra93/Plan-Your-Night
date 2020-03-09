// app/javascript/packs/application.js
import { initStarRating } from '../plugins/init_star_rating';

initStarRating();

import "bootstrap";

import { initAutocomplete } from 'plugins/init_autocomplete';
initAutocomplete();

$('.carousel').carousel({
  touch: true,
  interval: false,
})


import { triggerLocation } from 'components/location';
triggerLocation();

import { toggleActive } from 'components/dashboard';
toggleActive();

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from 'plugins/init_mapbox';
initMapbox();
