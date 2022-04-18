import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Ticket } from '../../admin/ticket/ticket.model';
import { tickets } from './tickets-list';
import {AdminService } from '../../services/admin.service';
import { users } from '../../admin/user/users-list';
import { User } from '../../admin/user/user.model';

@Component({
  selector: 'app-tech-tickets',
  templateUrl: './tech-tickets.component.html',
  styleUrls: ['./tech-tickets.component.css']
})
export class TechTicketsComponent  implements OnInit {
  public ticketsList : Ticket[] = tickets;
  public showTicketDetails = false;
  public showTicketaffectation = false;
  public currentticket=tickets[0];
  public fetchedTicket=tickets;
  public fetchedTechniciens=users;
  public user:User;
  public technicienaffecte:User;
  public formclourer:FormGroup;
  public showTicketcloturation = false;

  constructor(private userService : AdminService, private route:ActivatedRoute,private router:Router) { }
  technicienId = localStorage.getItem('user');
  
  ngOnInit(): void {
    // this.userService.getTickets().subscribe(
    //   (resultatTicket) => {
    //     this.fetchedTicket = resultatTicket;
    //      console.log(resultatTicket);
    //   }  
    //   );
    this.userService.getTicketsTech(JSON.parse(this.technicienId).userId).subscribe(
        (resultatTicket) => {
          this.fetchedTicket = resultatTicket;
           console.log(resultatTicket);
        }  
        );
     
        this.formclourer = new FormGroup({
          note: new FormControl(null,{validators:[Validators.required]}),
   
        });
       
      
  }
  
  onClickShowForm2(ticket:Ticket){
    this.showTicketDetails = true;
    this.currentticket=ticket;
//ticket.opened="opened";
this.userService.getUser(this.currentticket.demandeur) .subscribe(
  (resultat:any) => {
    console.log(resultat);
    this.user = resultat;
  
  });
  this.userService.getUser(this.currentticket.assignetech) .subscribe(
    (resultat:any) => {
      console.log(resultat);
      this.technicienaffecte = resultat;
    
    }
    );
  }
  onClickCloseForm2(){
 
    
    this.showTicketDetails = false;
  }
  onCloturerTiket(userId:string){

    this.userService.EditCloturer(this.formclourer.value.note,userId);
    this.showTicketcloturation = false;
    this.showTicketDetails = false
   
  }
  onClickShowAffecter(){
    this.showTicketaffectation = true;
   

  }
  onClickCloseAffecter(){
    this.showTicketaffectation = false;
  }
  onDeleteTiket(user:string){
    // this.route.paramMap.subscribe(params=>{
      // const userId=params.get("id");
      // const userId=id;
      //  console.log(user.id)
      //  this.currentuser=user;
       this.userService.DeleteTicket(user);
    //this.router.navigate(['admin/user']);
  // })
  }
   
  onClickShowcloturation(ticket:Ticket){
    this.showTicketDetails = false;
    this.showTicketcloturation = true;
    this.currentticket=ticket;
      
     // this.router.navigate(['dash-respo/events']);
   

  }
  onClickClosecloturation(){
    this.showTicketcloturation = false;
  }
}
