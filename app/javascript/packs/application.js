import "bootstrap";
import { toggleActive } from 'components/dashboard';

$('.carousel').carousel({
  touch: true,
  interval: false,
})

toggleActive();
