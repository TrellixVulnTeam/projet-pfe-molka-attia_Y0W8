export interface Ticket {
  _id?: string;
  description?:string;
  priorite?:string;
  demandeur?:string;
  assignetech?:string;
  etat?:string;
  specialite?:string;
  Datecreaation?:Date;
  Datecloturation?:Date;
  ticket_groupe?:Ticket;
}

//  Dateopening:{type: Date, required: false},
//Datecloturation:{type: Date, required: false},