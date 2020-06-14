//HW  3
function toggleClass(element, className) {
  let currentElement = document.getElementById(element)
  console.log(currentElement.children) ;
  
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
console.log(toggleClass( 'grid-1','grid-item-background'))

//HW  4
  let userText = prompt('Enter any text here:');
  const  currentClass = '.text-placeholder';
  let currentElement = document.querySelector(currentClass);
  console.log(currentElement);
  currentElement.innerText = userText;
  console.log(currentElement);
  





