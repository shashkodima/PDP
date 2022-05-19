import {LightningElement, api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

import boatSearchTemplateWithNew from './boatSearchWithNew.html';
import boatSearchTemplateWithoutNew from './boatSearchWithoutNew.html';

export default class BoatSearch extends NavigationMixin(LightningElement) {
    isLoading;
    boatSearchTemplateWithoutNew;

    constructor() {
        super();
        this.isLoading = false;
        this.boatSearchTemplateWithoutNew = true;
    }

    render() {
        return this.boatSearchTemplateWithoutNew ? boatSearchTemplateWithoutNew : boatSearchTemplateWithNew;
    }

    handleLoading() {
        this.isLoading = true;
    }

    handleDoneLoading() {
        this.isLoading = false;
    }

    searchBoats(event) {
        const boatType = event.detail.boatTypeId;
        this.template.querySelector('c-boat-search-results').searchBoats(boatType);
        this.handleDoneLoading();
    }

    enableCreation() {
        this.boatSearchTemplateWithoutNew = !this.boatSearchTemplateWithoutNew;
    }

    createNewBoat() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Boat__c',
                actionName: 'new'
            },
        });
    }
}