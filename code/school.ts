//
//Import app from the outlook library.
import { assets } from '../../../outlook/v/code/outlook.js';
import {app} from "./app.js"
import config from './config.js';
import * as library from "./library.js"
//
// 
// 
type uproducts = Array<{id:string,title:string,solution:Array<assets.solution>}>
//
//The school model that link teacher, pupils and parents
export default class school extends app{
    // 
    //The global school property to attach the 
    static current: school;
    //
    //Initialize the school
    constructor(){
        super(
            //
            //Overide the config  
            new config()
        );
    }
    
    // 
    //Converts the uproducts to the correct format of iproduct by expanding the already 
    //existing iproducts.
    activate_Iproducts(src: uproducts, dest: assets.products): assets.products{
        // 
        //Loop through the uproducts appending them to iproduct
        src.forEach(uprod => {
            //
            //Begin with an empty collection of the solutions
            const sols: assets.solutions = {};
            // 
            //Populate the solution.
            uprod.solution.forEach(sol => sols[sol.id] = sol);
            // 
            //Add this user product
            dest[uprod.id] = { id: uprod.id, title: uprod.title, solutions: sols }
        });
        // 
        //Return the expanded products 
        return dest;
    }
    // 
    //Add a home pannel before this pannels are painted 
    async show_panels(): Promise<void>{
        await super.show_panels();
    }

}
//
//Start the application after fully loading the current 
//window.
window.onload = async () => {
    // 
    //This proccess will soon be evocked at the market place but for 
    //the school id  will be kaps
    app.current= new school();
    await app.current.initialize();
}
