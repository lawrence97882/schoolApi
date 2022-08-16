var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
//
//Allows methods on this page to talk to the server
import * as server from "../../../bolster/server.js";
//
//Resolve the schema classes, viz.:database, columns, mutall e.t.c. 
import * as schema from "../../../bolster/schema.js";
//
import * as io from "../../../school/v/code/io.js";
// 
import { scroll } from "./scroll.js";
//
//These are pages based on a particular subject as its theme 
export class theme extends scroll {
    // 
    //
    constructor(
    //
    //The database and entity name that is displayed in this 
    //theme panel.
    subject, 
    // 
    //The css for retrieving the html element where to display 
    //the theme's subject record.
    css, 
    // 
    //The view page that is the home of this panel 
    base, 
    // 
    //An optional selection of the first record 
    selection) {
        super(css, base);
        this.subject = subject;
        this.css = css;
        this.base = base;
        this.selection = selection;
    }
    //
    //Paint the content panel with editable records of the subject
    continue_paint() {
        return __awaiter(this, void 0, void 0, function* () {
            //
            //Get the editor description.
            const metadata = yield server.exec(
            //
            //The editor class is an sql object that was originaly designed 
            //to return rich content for driving the crud page.
            "editor", 
            //
            //Constructor args of an editor class are ename and dbname 
            //packed into a subject array in that order.
            this.subject, 
            //
            //Method called to retrieve editor metadata on the editor class.
            "describe", 
            //
            //There are no method parameters
            []);
            //
            //Destructure the metadata
            const [idbase, col_names, sql, max_record] = metadata;
            //
            //Set the metadata properties
            this.sql = sql;
            this.col_names = col_names;
            this.max_records = parseInt(max_record);
            //
            //Activate the static php database.
            this.dbase = new schema.database(idbase);
            //
            //Initialize the crud style for managing the hide/show feature 
            //of columns
            this.initialize_styles(col_names);
            //
            //Retrieve and display $limit number of rows of data starting from the 
            //given offset/request.
            let pk;
            if (this.selection !== undefined)
                pk = this.selection.pk;
            yield this.goto(pk);
            //
            //Select the matching row and scroll it into view.
            this.select_nth_row(pk);
        });
    }
    //
    //Return the io structure associated with the given td
    get_io(meta) {
        //
        //Destructure the subject to get the entity name; its the 
        //first component. 
        const [ename] = this.subject;
        // 
        //Get the column name that matches this td. 
        const col_name = meta.name;
        //
        //Get the actual column from the underlying database.
        const col = this.dbase.entities[ename].columns[col_name];
        //
        //Create and return the io for this column.
        const Io = io.create_io(this, col);
        // 
        return Io;
    }
    // 
    // 
    get sql() {
        if (this.sql_ !== undefined)
            return this.sql_;
        // 
        //Otherwise throw an exception this is because a getter property cannot be asynchronous 
        //hence this property was required before it was set.
        throw new schema.mutall_error("property sql cannot be obtains before the continue paint");
    }
    // 
    // 
    set sql(s) {
        this.sql_ = s;
    }
}
// 
//Saves io instances that created this theme table saved as a map 
//indexed by their position in a thematic oanel
theme.ios = new Map();
