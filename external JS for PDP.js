window.sayHello = (function() {
    const helloString = 'Hello! I`m external JS';
    return {
        getHelloString: function() {
            return helloString;
        }
    };
}());

window.squareNumber = (function() {
    return {
        getSquareNumber: function(number) {
            return number ** 2;
        }
    };
}());
