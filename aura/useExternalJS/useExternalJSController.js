({
    closeAction: function (component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },

    handleHello: function (component, event, helper) {
        const message = sayHello.getHelloString();
        const title = $A.get("$Label.c.Success");
        const type =  "success";
        helper.showToast(title, message, type);
    },

    handleSquare: function (component, event, helper) {
        let currentNumber = component.find("inputNumber").get("v.value");
        let calculateResult = squareNumber.getSquareNumber(currentNumber);
        const message = 'Result: ' + calculateResult;
        const title = $A.get("$Label.c.Success");
        const type =  "success";
        helper.showToast(title, message, type);
    },
});