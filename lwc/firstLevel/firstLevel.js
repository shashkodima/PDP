import { LightningElement } from 'lwc';

export default class FirstLevel extends LightningElement {

    handleChildEvent(event) {
        console.log('First level handle event');
    }

    handleChildEventDiv() {
        console.log('First level handle event in div');
    }
}