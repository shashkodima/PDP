import {LightningElement} from 'lwc';

export default class FourthLevel extends LightningElement {

    handleChildEvent(event) {
        console.log('Fourth level handle event');
    }

    handleChildEventDiv() {
        console.log('Fourth level handle event in div');
    }
}