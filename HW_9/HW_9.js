
const openButton = document.getElementById('openPopupButton');
const closeButton = document.getElementById('closePopupButton');

 function handlerFunction() {
 
  let popup = document.querySelector('.popup');
  console.log('click-click');
  popup.classList.toggle('visible');
  return popup;
 }
openButton.addEventListener('click', handlerFunction);
closeButton.addEventListener('click', handlerFunction);






//element.removeEventListener('click', handlerFunction);




