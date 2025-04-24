
//import  RestRemoteService  from "../lib/service.js";
const { RestRemoteService } = require("../lib/service");

class document_information_extraction_api extends RestRemoteService {
     async init() {

        this.customizeHeaders = (headers) => {
            headers["accept"] = "*/* ";
            headers["content-type"] = "application/json";
            headers["accept-language"] = "";
        };

        await super.init();
    }

}

module.exports = document_information_extraction_api;
