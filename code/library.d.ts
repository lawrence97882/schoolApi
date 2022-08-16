
import { database, editor, record,library } from "../../../bolster/library"

// 
//The school extension of the library interface 
export interface sch_library extends library{
    school:Ischool
}
// 
export var classes: sch_library;
//
//The school interface that holds the constructor and all the static 
//methods. 
 interface Ischool {
     // 
    //To create a school we need a school id 
    constructor:new(id:string)=>school
}
// 
//The school interface with all the object  methods 
interface school{
    // 
     //returns an sql that retrieves all the students of a particular class in a
    //certain year
    get_student(
        stream:string, 
        grade:string,
        year:string
     ):Array<istudent>;
    // 
    //Returns all the scores of a particular subject in a particular
    //stream for a paticular grade.
    get_subject_scores(
        subject:string,
        stream:string,
        exam:string, 
        grade:string
    ):string;
    // 
    //Returns all the subjects taught to a particular stream
     get_subjects(
        stream:string,
        grade:string,
        year:string
     ): string
     // 
     //returns all the metadata of a column involved in a particular sql 
     get_column_metadata(sql: string): Array<column_meta>
     // 
     hello(): string;
}
//
//The additional information required to paint the fuel information
export type metadata = column_meta/**include udf and the test metadata */
