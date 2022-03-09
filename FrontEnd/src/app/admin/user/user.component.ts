import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { User } from './user.model';
import { users } from './users-list';
import {AdminService } from '../../services/admin.service';


@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
  public usersList : User[] = users;
 
 public imagePreview:string;

  constructor(private userService : AdminService, private route:ActivatedRoute,private router:Router) {
   
   }
    formaddUser:FormGroup;
    formEdit:FormGroup;
   public showAddUserForm = false;
   public showUserDetails = false;
   public showEditUserForm=false;
   public currentuser=users[0];
   public fetchedUser=users;

  ngOnInit(): void {
    this.userService.getUsers().subscribe(
      (resultatUser) => {
        this.fetchedUser = resultatUser;
         console.log(resultatUser);
      }
    );
    this.formaddUser = new FormGroup({
      name: new FormControl(null,{validators:[Validators.required]}),
      email: new FormControl(null,{validators:[Validators.required]}),
     password: new FormControl(null,{validators:[Validators.required]}),
     type: new FormControl(null,{validators:[Validators.required]}),
     user_img: new FormControl(null,{validators:[Validators.required]}),
    });

    this.formEdit = new FormGroup({
      name: new FormControl(null,{validators:[Validators.required]}),
      email: new FormControl(null,{validators:[Validators.required]}),
      // password: new FormControl(null,{validators:[Validators.required]}),
     type: new FormControl(null,{validators:[Validators.required]}),
     user_img: new FormControl(null,{validators:[Validators.required]}),
    });
  }
  oneEditSubmit(userId:string){

    this.userService.EditUser(this.formEdit.value,userId);
    this.showEditUserForm = false;
   
  }
  onDeleteUser(user:string){
    // this.route.paramMap.subscribe(params=>{
      // const userId=params.get("id");
      // const userId=id;
      //  console.log(user.id)
      //  this.currentuser=user;
       this.userService.DeleteUser(user);
    //this.router.navigate(['admin/user']);
  // })
  }
  async onAddSubmit(){
    await this.userService.addUser(this.formaddUser.value);
    this.showAddUserForm = false;
   // this.router.navigate(['dash-respo/events']);
  }
  onImagePicked(event :Event){
    const file = (event.target as HTMLInputElement).files[0];
    this.formaddUser.patchValue({user_img:file});
    this.formaddUser.get('user_img').updateValueAndValidity();
    const reader = new FileReader();
    reader.onload = () => {
      this.imagePreview = reader.result as string;
    };
    reader.readAsDataURL(file);

  }
  onImagePicked2(event :Event){
    const file = (event.target as HTMLInputElement).files[0];
  this.formEdit.patchValue({user_img:file});
  this.formEdit.get('user_img').updateValueAndValidity();
  const reader = new FileReader();
  reader.onload = () => {
    this.imagePreview = reader.result as string;
  };
  reader.readAsDataURL(file);

  }

  onClickShowForm(){
    this.showAddUserForm = true;
  }
  onClickCloseForm(){
    this.showAddUserForm = false;
  }
  onClickShowForm2(user:User){
    this.showUserDetails = true;
    this.currentuser=user;

  }
  onClickCloseForm2(){
    this.showUserDetails = false;
  }

  onClickCloseForm3(){
    this.showEditUserForm = false;
  }
  onClickShowForm3(){
    this.showUserDetails = false;
this.showEditUserForm=true;
  }

}
