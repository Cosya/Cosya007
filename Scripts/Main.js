// 1 lesson 
/* 
alert('Hello_alert!') 
src="Scripts/Main.js"> 


// 2 lesson HW1 
let firstNumber = +prompt('Input 1:'), 
secondNumber = +prompt('Input 2:'); 
alert(firstNumber+secondNumber) -->

// 2 lesson HW2

  const name = prompt("What's your name?")
  alert('Hello, '+ name)-->

// 2 lesson HW3
let firstNumber = parseInt(prompt('Input 1:')); //only Int 
alert(firstNumber%2)


//2 lesson HW4

let floatNumber = parseFloat(prompt('Input 1:')); 
let firstPart = parseInt(floatNumber);
let secondPart =  floatNumber - firstPart;
alert(`Before: ${firstPart} , After: ${secondPart}`)    //.toFixed(3)

// 3 Lesson 1 Practice

let Age = prompt('Enter your age');

if (Age >= 14 && Age <= 90) {
  console.log("You are fit!");
}  else{
  console.log("You are not fit!");
}

//HVW 3 1 

let number = prompt('Enter your Number');

  if (number%2 == 0) {
    alert(`Number ${number} is EVEN`);
  }  else{
    alert(`Number ${number} is ODD`);
  }

//HVW 3 2(case 1)
let Age = prompt('Enter your age');

if (Age >= 14 && Age <= 90)
 {
  alert(`Number ${Age} is Between 14 and 90`);
 }   
 else
 {
  alert(`Number ${Age} is NOT Between 14 and 90`);
 }

//HVW 3 2(case 2)
let Age = prompt('Enter your age');
let isBetween = (Age >= 14 && Age <= 90) ? true : false;

if (!isBetween) 
 {
  alert(`Number ${Age} is NOT Between 14 and 90`)
  
 }   
 else
 {
  alert(`Number ${Age} is Between 14 and 90`);;
 }

//HVW 3 3

for (let i = 0; i <= 10; i+=2) { 
  console.log(i); 
}

//HVW 3 4

for (let i = 1; i < 10; i+=2) { 
  console.log(i); 
}

//HVW 3 5

const cLogin = 'Admin';
const cPass = 'TheMaster';
let login;
let pass;

login = prompt("Who's here?");
if (login == cLogin) 
  {
    pass = prompt("Enter your password:");
    if (pass == cPass ) 
      {
      alert("Welcome");
      } 
    else if  (pass == '' || pass == null ) 
      {
      alert("Canceled");
      } 
    else 
      {
        alert("Wrong password");
      }
  } 
else if (login == '' || login == null ) 
  {
    alert("Canceled");
  }
else 
  {
    alert( "I don’t know you");
  }

//HW_4 1 (case1)

function getPower(number,power) {
  let result = number**power
  return result ;
}
console.log(getPower(5,5));  //call


//HW_4 1 (case2)
function getPower(number,power) {
  let result = 1;
 
  for (let index = 0; index < power; index++) {
    
    result = result*number;
   }
  return   result ;
 ;
}
console.log(getPower(5,4));  //call

//HW_4 2 (case2) 

let  calcMin = (a, b) =>  Math.min(a, b);
console.log(calcMin(12, -12) );  //call 


//HW_4 3

let  calcMax = (a, b) =>  Math.max(a, b);
console.log(calcMax(12, -12) ); //call

//HW_4 4
 
let = sayAgree=() => alert("You agreed.");
let = sayCancel=() => alert("You canceled the execution."); 
let = ask=(question, yes, no)=> confirm(question) ? yes() :  no();

ask("Do you agree?",sayAgree,sayCancel); //call

Write a function log(message, logger)
Parameter logger should have default value console.log
Example:
log('Hello!', console.warn) => warning 'Hello!' is logged to console

//HW_4 5

function getLogger(message, logger=console.log )
{
  logger(message)

};
getLogger("Hello", console.warn);
getLogger("Hello", console.error);
getLogger("Hello");


//HW_5 1
let fruits = ["Apples", "Pear", "Orange"];
// push a new value into the "copy"
let shoppingCart = fruits; //array is not copied only has another variable
shoppingCart.push("Banana");

// what's in fruits?
alert( fruits.length ); // ?
console.log(fruits);
console.log(shoppingCart);


//HW_5 2

let styles = ['Jazz', 'Blues'];
console.log (styles)
styles.push ('Rock-n-Roll');
styles[1] = 'Classic'
styles.splice (0, 0, "Rap", "Reggae");
console.log (styles);
*/

//HW_5 2



