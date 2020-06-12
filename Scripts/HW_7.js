//HW 7 1
let name = "John";

function sayHi() {
  alert("Hi, " + name);
}

name = "Pete";

sayHi(); // what will it show: "John" or "Pete"?

//answer  - Pete, variable was initiated on external block, so function will take the latest variant

/*
//HW 7 2 --will be updated later
// code for isInBetween
function isInBetween(item,firstNumber, secondNumber) {
   return (firstNumber <=item  && item <= secondNumber)
}
let arr = [1, 2, 3, 4, 5, 6, 7];
result = arr.filter(isInBetween(3,6))
console.log(result)
*/

//HW 7 3
function showUserInfo(firstName, lastName) {
  const fullName = `${firstName} ${lastName}`;

 (function showMessage() {
  	console.log(fullName);
  })()

 }

showUserInfo('Kostya', 'Bondarenko')

//HW 7 4
const user = { name: 'Ann', age: 54 };
const user2 = {...user};//user;
user2.age = 40;
user2.sayHi = function() {console.log(`Hi from ${this.name}`)};
let userAges = [user, user2].map(item => item.age);
const oldestUserAge = Math.max(...userAges);

// ---> print all 
console.log(userAges);
console.log(...userAges);
console.log(oldestUserAge);
console.table(user);
console.table(user2);
user2.sayHi();