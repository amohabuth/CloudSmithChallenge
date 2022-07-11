import { LightningElement } from 'lwc';
import saveIdInformation from '@salesforce/apex/SaveInformation.saveIdInformation'
const PH_URL = 'https://calendarific.com/api/v2/holidays?api_key=24c5e86734eb44dc4a962826324a5546e74dc42f&country=ZA&year='

const columns = [
    { label: 'Name', fieldName: 'name' },
    { label: 'Description', fieldName: 'description'},
];

export default class SaApp extends LightningElement {
    isValid = true;
    idNum = '';
    holidays;
    columns = columns; 
    showSpinner = false;   
    
    handleClick(){
       this.showSpinner = true;
       this.callApex(); 
       this.fetchHoliday();
    }

    callApex(){
        saveIdInformation({idNumber:this.idNum})
        .then(() => {
            console.log('Success');
        })
        .catch(error => {
            console.log(error);
        })
    }

    handleChange(event){
        let inputFields = this.template.querySelectorAll('.validate');
        this.idNum = event.target.value;
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                this.isValid = true;
            }else{
                inputField.reportValidity();
                this.isValid = false;                
            }
            //this.contact[inputField.name] = inputField.value;
        });
    }

    fetchHoliday(){
        let dobYear = this.idNum.slice(0,2);
        let currentYear = new Date().getFullYear().toString().slice(-2);
        let getYear = dobYear <= currentYear? '20':'19';
        getYear += dobYear;
        fetch(PH_URL+getYear)
        .then(response=>response.json())
        .then(data=>{
            console.log(data);
            this.holidays = data.response.holidays;            
            this.showSpinner = false;
        })
        .catch(error=>{
            console.error(error);
            this.showSpinner = false;

        })
    }


}