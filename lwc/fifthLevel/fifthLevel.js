import TestExtend from 'c/testExtend';
import { api } from 'lwc';

import firstTemplate from './firstTemplate.html';
import secondTemplate from './secondTemplate.html';
import sendContinuationRequest from '@salesforce/apexContinuation/ContinuationController.sendContinuationRequest';

export default class FifthLevel extends TestExtend {
    templateOne;
    continuationBody;

    constructor() {
        super();
        this.templateOne = true;
        this.continuationBody = '';
    }

    @api set continuationInfo(value) {
        this.continuationBody = value;
        const message = 'Response with delay ' + JSON.stringify(this.continuationBody);
        this.showToast('Success Continuation', message);
    }

    get continuationInfo() {
        return this.continuationBody;
    }


    handleClick(event) {
        console.log('Clicked button');
        const testEvent = new CustomEvent('buttonclicktest', { composed:false, bubbles:false });
        this.dispatchEvent(testEvent);
    }

    render() {
        return this.templateOne ? firstTemplate : secondTemplate;
    }

    changeTemplate() {
        this.templateOne = !this.templateOne;
    }

    sendContinuation() {
        sendContinuationRequest()
            .then(result => {
                this.continuationInfo = result;
            })
            .catch(error => {
                    this.continuationInfo = error;
                }
            );
    }

    showToastExtendTest() {
        this.showToast('Success', 'Test Extend');
    }
}