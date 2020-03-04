// find the item with the same data target as the thing clicked
 // remove the hidden class from its content
const menu = document.querySelectorAll('.list-group.list-group-flush');
const contents = document.querySelectorAll('.content');

const hideContent = () => {
  contents.forEach(content => {
    content.classList.add('hidden');
  });
};

const revealContent = () => {
  hideContent();
  const active = document.querySelector('.list-group-item.active');
  const content = document.querySelector(`[data-info-type='${active.id}']`);
  content.classList.remove('hidden');
};

const toggleActive = () => {
  menu.forEach(item => {
    item.addEventListener('click', (event) => {
    document.querySelector('.list-group-item.active').classList.remove('active');
    event.target.classList.add('active');
    revealContent();
    });
  });
};

export { toggleActive };
