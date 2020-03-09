const menu = document.querySelectorAll('.menu-item');
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
 if (contents.length) {
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
