/**
 * Created by user on 5/26/2022.
 */

import {LightningElement} from 'lwc';

export default class ThirdLevel extends LightningElement {

    handleChildEvent(event) {
        console.log('Third level handle event');
    }

    handleChildEventDiv() {
        console.log('Third level handle event in div');
    }
}