//HW_6 1
let user={} ;
console.log(user);
user.name ='John';
console.log(user);
user.surname = 'smith';
console.table(user)
user.name = 'peter'
console.table(user)
;

//HW_6 2

const users = [
  {name: 'Ivan', age: 35, gender: 'male'},
  {name: 'Ann', age: 33, gender: 'female'},
  {name: 'Jane', age: 40, gender: 'female'},
  {name: 'Alex', age: 20, gender: 'male'},
  {name: 'Sam', age: 52, gender: 'female'}
];

function getObjectAverageAge(users)
  {
    let ages = users.map(user => user.age);
     result = ages.reduce((sum,current) => sum+ +current, 0) /ages.length;
    return result;
  }

console.log(getObjectAverageAge(users))

//HW_6 3

let user = {name: 'Ivan', age: 30, gender: 'male'};
//let user = {};
function isEmpty(obj) 
{
  let isEmpty ;
  let keyArray = Object.keys(user);
    if (keyArray[0] === undefined) {
      isEmpty = true;
    }
    else {  
   isEmpty = false;
    }
    return isEmpty;
  }
 
console.log(isEmpty(user));

//HW_6 4
let user = {name: 'Ivan', age: 30, size: 15, gender: 'male'};

function multiplyNumeric(obj) 
{
  for (let key in obj) {
    //console.log(typeof obj[key])
    if (typeof obj[key]=='number'){
      obj[key] = obj[key]*2;
    }
   
  }
  
}
multiplyNumeric(user);
console.table(user);

//HW_6 5

let calculator = {
 
  read() {
    calculator.number1 = +prompt('Enter number 1');
    calculator.number2 = +prompt('Enter number 2');
  },
  sum(){
    let result = this.number1+this.number2; 
    return result},
  mul(){
    let result = this.number1*this.number2; 
    return result}
  }
calculator.read();
alert( calculator.sum() );
alert( calculator.mul() );  