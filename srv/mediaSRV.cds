using {Media.db as db } from '../db/media' ;
//using {Document.Information.Extraction as doc} from './external/document_information_extraction_api';

service media @(){

    //type document_with_file : doc.types.documentWithFilePost;
    //action   postDocumentWithFile(document_with_file_post : document_with_file);
    //action   document_jobs_post(document_with_file_post : document_with_file);
    entity MediaFile as projection on db.mediaFile;
     
}