// 
//Resolve the outlook config so as to extend it. s 
import outlook_config from '../../../outlook/v/code/config.js';
// 
//Export the extended config local to the rentize.
export default class config extends outlook_config {
    constructor() { super(); }
    //
    //Subject
    subject = ['student', 'general_school'];
    //
    //The id of this application; if not given, we use this 
    //constructors name
    id = "school";
    db_type = "mysql";
    //
    //The window application's url; if  not provided, we use that of
    //the current window
    url = "";
    //
    //Image associated with this app 
    image = "";
    //
    //The full trademark name of the application
    trade = "School Systems for exams and accounting";
    //
    //For advertising purposes
    tagname = "";
    // 
    //Overide the application database.
    app_db = "general_school";
    // 
    //The maximum number of records that can be retrieved from 
    //the server using one single fetch. Its value is used to modify 
    //the editor sql by  adding a limit clause 
    limit = 30;
}
