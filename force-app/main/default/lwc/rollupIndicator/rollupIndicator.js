import { LightningElement, api, wire } from 'lwc';
import getRollupFieldDetails from '@salesforce/apex/RollupIndicatorController.getRollupFieldDetails';

export default class RollupIndicator extends LightningElement {
    @api recordId; 
    @api targetObject; 
    @api rollupFieldApiName; 

    rollupFieldLabel; 
    rollupFieldValue;
    error; 
    
    @wire(getRollupFieldDetails, {
        targetObject: '$targetObject',
        rollupFieldApiName: '$rollupFieldApiName',
        recordId: '$recordId'
    })
    wiredRollupField({ error, data }) {
        if (data) {
            this.rollupFieldLabel = data.fieldLabel; 
            this.rollupFieldValue = data.fieldValue; 
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.rollupFieldLabel = undefined;
            this.rollupFieldValue = undefined;
        }
    }
}
