

function showMessage() {
    console.log('Hello')
}

const intervalId = setInterval(showMessage, 3000);

// interval is stopped after 10 seconds

setTimeout(() => clearInterval(intervalId), 10000);

//HW_10 1
const Ball = document.getElementById('ball');
const moveBallXY = document.getElementById('moveBallXY');
const moveBallX = document.getElementById('moveBallX');


function clickXY() {

    setTimeout(function () {

        if (Ball.style.bottom !== "" && Ball.style.left !== "") {
            let currentYValue = Ball.style.bottom.substring(0, Ball.style.bottom.length - 2)
            Ball.style.bottom = +currentYValue + 15 + "px"
            let currentXValue = Ball.style.left.substring(0, Ball.style.left.length - 2)
            Ball.style.left = +currentXValue + 15 + "px"

        }
        else {
            Ball.style.bottom = "15px";
            Ball.style.left = "15px";
        }

    }, 500);
}

moveBallXY.addEventListener('click', clickXY);
//HW_10 2 
moveBallX.onchange = function () {
    let currentXValue = Ball.style.left.substring(0, Ball.style.left.length - 2)
    Ball.style.left = +currentXValue + (+moveBallX.value) + "px"

}

//HW_10 3
const form = document.getElementById('userForm');

function CheckValues() {

    form.username.classList.remove('invalid');
    form.jobTitle.classList.remove('invalid');
    form.age.classList.remove('invalid');

    console.log(form.elements.username.value.length)

    if (form.username.value.length < 3 || form.username.value.length > 20) {

        form.username.classList.add('invalid')
    }
    
    if (form.jobTitle.value.length < 3 || form.jobTitle.value.length > 20) {

        form.jobTitle.classList.add('invalid')
    }

    if (+form.age.value< 0 || +form.age.value> 115) {

        form.age.classList.add('invalid')
    }

}

form.addEventListener('change', CheckValues)










