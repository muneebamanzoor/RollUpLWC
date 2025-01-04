import { LightningElement, api, wire } from 'lwc';
import getRollupFieldValue from '@salesforce/apex/RollupIndicatorController.getRollupFieldValue';

export default class RollupIndicator extends LightningElement {
    @api recordId;
    @api targetObject = 'Account';
    @api rollupFieldApiName = 'AnnualRevenue';

    rollupValue;
    error;

    @wire(getRollupFieldValue, {
        targetObject: '$targetObject',
        rollupFieldApiName: '$rollupFieldApiName',
        recordId: '$recordId'
    })
    wiredRollupField({ error, data }) {
        if (data) {
            this.rollupValue = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.rollupValue = undefined;
        }
    }
}
