
//HW_9 1
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

//HW_9 2

function escHandlerFunction(event){
    const keyName = event.key;
    let popup = document.querySelector('.popup');
    if (keyName === 'Escape') 
    {
        console.log('Escape');
        popup.classList.remove('visible');
    }   
    return popup;
    }
 document.addEventListener('keydown', escHandlerFunction);

 //HW_9 3
 const circleButton = document.getElementById('addCircleButton');
 circleButton.onclick = function() {
    
    let circleContainer = document.querySelector('.circle-container') 
    let newCircleElement  = document.createElement('div')
    newCircleElement.classList.add('circle');
    circleContainer.append(newCircleElement); 
    let divCount = document.getElementsByTagName('div')
    if (divCount.length%2 !==0) {
        newCircleElement.classList.add('odd');  
        newCircleElement.classList.add('circle'); 
    }

//HW_9 4 
 //On #removeCircleButton click remove last circle from .circle-container


 const circleButton = document.getElementById('removeCircleButton');
 circleButton.onclick =function() {
    
    let divCount = document.getElementsByTagName('div');
    let lastElement = divCount[divCount.length-1]
    lastElement.remove()
    }
}

 
