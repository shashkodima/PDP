import {LightningElement} from 'lwc';

export default class eventsBubbleTest extends LightningElement {

    handleChildEvent(event) {
        console.log('Parent handle event');
    }

    handleChildEventDiv() {
        console.log('Parent handle event in div');
    }
}