import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import BOATMC from '@salesforce/messageChannel/BoatMessageChannel__c';
import {subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext} from 'lightning/messageService';

const LONGITUDE_FIELD = "Boat__c.Geolocation__Longitude__s";
const LATITUDE_FIELD = "Boat__c.Geolocation__Latitude__s";
const BOAT_FIELDS = [LONGITUDE_FIELD, LATITUDE_FIELD];

export default class BoatMap extends LightningElement {
  subscription;
  error;
  mapMarkers;
  boatId;

  constructor() {
    super();
    this.subscription = null;
    this.error = undefined;
    this.mapMarkers = [];
  }

  @api get recordId() {
    return this.boatId;
  }

  set recordId(value) {
    this.setAttribute('boatId', value);
    this.boatId = value;
  }

  get showMap() {
    return this.mapMarkers.length > 0;
  }

  @wire(MessageContext)
  messageContext;

  connectedCallback() {
    this.subscribeMC();
  }

  disconnectedCallback() {
    this.unsubscribeToMessageChannel();
  }

  @wire(getRecord, {recordId: '$boatId', fields: BOAT_FIELDS})
  wiredRecord({ error, data }) {
    if (data) {
      this.error = undefined;
      const longitude = data.fields.Geolocation__Longitude__s.value;
      const latitude = data.fields.Geolocation__Latitude__s.value;
      this.updateMap(longitude, latitude);
    } else if (error) {
      this.error = error;
      this.boatId = undefined;
      this.mapMarkers = [];
    }
  }

  subscribeMC() {
    this.subscription = subscribe(
        this.messageContext,
        BOATMC,
        (message) => {this.boatId = message.recordId},
        { scope: APPLICATION_SCOPE }
    );
  }

  unsubscribeToMessageChannel() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }

  updateMap(Longitude, Latitude) {
    this.mapMarkers = [{location: { Latitude, Longitude }}];
  }
}