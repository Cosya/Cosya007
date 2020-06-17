

function showMessage() {
console.log('Hello')
}

const intervalId = setInterval(showMessage, 1000);

// interval is stopped after 10 seconds

setTimeout(() => clearInterval(intervalId), 10000);


//element.removeEventListener('click', handlerFunction);




