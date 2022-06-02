import { LightningElement } from 'lwc';

export default class SecondLevel extends LightningElement {

    handleChildEvent(event) {
        console.log('Second level handle event');
    }

    handleChildEventDiv() {
        console.log('Second level handle event in div');
    }
}