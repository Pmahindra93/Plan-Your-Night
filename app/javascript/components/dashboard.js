// find the item with the same data target as the thing clicked
 // remove the hidden class from its content

const menu = document.querySelectorAll('.menu-list');
const contents = document.querySelectorAll('.content');

const hideContent = () => {
  contents.forEach(content => {
    content.classList.add('hidden');
  });
};

const revealContent = () => {
  hideContent();
  const active = document.querySelector('.menu-item.active');
  const content = document.querySelector(`[data-info-type='${active.id}']`);
  content.classList.remove('hidden');
};

const toggleActive = () => {
 if (contents) {
  revealContent();
  menu.forEach(item => {
    item.addEventListener('click', (event) => {
      document.querySelector('.menu-item.active').classList.remove('active');
      event.target.classList.add('active');
      revealContent();
    });
  });
 }
};





export { toggleActive };
