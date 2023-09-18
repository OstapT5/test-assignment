import { LightningElement, track } from 'lwc';
import getCurrentName from "@salesforce/apex/EmailSettingsNameUpdateController.getCurrentName";
import setNewName from "@salesforce/apex/EmailSettingsNameUpdateController.setNewName";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EmailSettingsNameUpdate extends LightningElement {

    @track currentName;
    error;
    newName;

    connectedCallback() {
        this.handleGetCurrentName();
    }

    handleGetCurrentName() {
        getCurrentName()
        .then((result) => {
            this.currentName = result;
        })
        .catch((error) => {
            this.error = error;
        });
    }
    
    handleInputChange(event) {
        this.newName = event.detail.value;
    }

    handleSave() {
        setNewName({ newName : this.newName})
        .then(() => {
            this.showSuccessToast();
        })
        .catch((error) => {
            this.error = error;
            this.showErrorToast(this.error);
        })
        .finally(() => {
            this.handleGetCurrentName();
        });
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Name updated',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    showErrorToast(msg) {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: msg,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}