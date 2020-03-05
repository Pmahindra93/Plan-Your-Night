// app/javascript/packs/application.js
import { initStarRating } from '../plugins/init_star_rating';

initStarRating();

import "bootstrap";
// import { toggleActive } from 'components/dashboard';
import { initAutocomplete } from 'plugins/init_autocomplete';

$('.carousel').carousel({
  touch: true,
  interval: false,
})

// toggleActive();
initAutocomplete()
