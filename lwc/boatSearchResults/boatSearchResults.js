import { LightningElement, api, wire, track } from 'lwc';
import getBoats from '@salesforce/apex/BoatDataService.getBoats';

import NAME_LABEL from '@salesforce/label/c.Name';
import OWNER_LABEL from '@salesforce/label/c.Owner';
import LENGTH_LABEL from '@salesforce/label/c.Length';
import PRICE_LABEL from '@salesforce/label/c.Price';


import BOATMC from '@salesforce/messageChannel/BoatMessageChannel__c';
import { publish, MessageContext } from 'lightning/messageService';


export default class BoatSearchResults extends LightningElement {
    @track boats;
    selectedBoatId;
    columns;
    boatTypeId;
    isLoading;

    label = {
        NAME_LABEL,
        OWNER_LABEL,
        LENGTH_LABEL,
        PRICE_LABEL
    };

    constructor() {
        super();
        this.columns = [];
        this.boatTypeId = '';
        this.isLoading = false;
    }

    @wire(MessageContext)
    messageContext;

    @wire(getBoats, {boatTypeId: '$boatTypeId'})
    wiredBoats({data, error}) {
        if (data) {
            this.boats = data;
        } else if (error) {
            console.log('Error ' +  error);
        }
    }

    @api searchBoats(typeId) {
        this.boatTypeId = typeId;
        this.isLoading = true;
        this.notifyLoading(this.isLoading);
    }

    updateSelectedTile(event) {
        this.selectedBoatId = event.detail.boatId;
        this.sendMessageService(this.selectedBoatId)
    }

    sendMessageService(boatId) {
        publish(this.messageContext, BOATMC, { recordId: boatId });
    }

    notifyLoading(isLoading) {
        if (isLoading) {
            this.dispatchEvent(new CustomEvent('loading'));
        } else {
            this.dispatchEvent(new CustomEvent('doneloading'));
        }
    }
}