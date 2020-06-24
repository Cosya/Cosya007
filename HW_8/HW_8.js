//HW_8 1-2

function addStyle(element,evenClassName, oddstyle) {
  let currentElement = document.getElementById(element)
  console.log(currentElement.children);

  for (let i = 0; i < currentElement.children.length; i++) {
    console.log(currentElement.children[i]);

    if (i%2 == 0) {
      currentElement.children[i].classList.add(evenClassName)
    }
    else {
      currentElement.children[i].style = oddstyle ;
    }

  }
}

addStyle('grid-1','grid-item-background','background: #aff0ad;')

//HW  3
function toggleClass(element, className) {
  let currentElement = document.getElementById(element)
  console.log(currentElement.children);

  //  for (let i = 0; i < currentElement.children.length; i++) 
  //{ 
  console.log(currentElement.classList.contains(className));

  if (currentElement.classList.contains(className)) {
    currentElement.classList.remove(className)
  }
  else {
    currentElement.classList.add(className)
  }

  //} 
  return currentElement;
}
toggleClass('grid-1', 'grid-item-background')

//HW  4
let userText = prompt('Enter any text here:');
const currentClass = '.text-placeholder';
let currentElement = document.querySelector(currentClass);
console.log(currentElement);
currentElement.innerText = userText;
console.log(currentElement);






