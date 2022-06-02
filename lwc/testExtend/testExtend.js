import {LightningElement} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class TestExtend extends LightningElement {

    showToast(title, message) {
        const event = new ShowToastEvent({
            variant: 'Success',
            title: title,
            message: message
        });
        this.dispatchEvent(event);
    }
}