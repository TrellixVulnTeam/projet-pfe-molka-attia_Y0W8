import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { User } from '../admin/user/user.model';


@Injectable({
  providedIn: 'root'
})
export class AdminService {


  // private userUpdated = new Subject<User[]>();
  constructor(private http:HttpClient) { }
  API_URL: string = 'http://localhost:3000/api/users';

  private userUpdated = new Subject<User[]>();

  getUsers(){
    
    return this.http.get<any>(`http://localhost:3000/api/users`);
  }


  addUser(user:User){
    const userData = new FormData();
    userData.append('name',user.name);
    userData.append('email',user.email);
    userData.append('password',user.password);
    userData.append('type',user.type);
    userData.append('user_img',user.user_img);

  //  userData.append('club_id',JSON.parse(localStorage.getItem('user')).club_id);

    //console.log(userData);
     this.http.post(`http://localhost:3000/api/users/addUser`,userData)
     .subscribe(res=>{
       console.log(res);


    });
  }

  
  EditUser(user:User,id:string){

    const userData = new FormData();
    userData.append('name',user.name);
    userData.append('email',user.email);
    userData.append('type',user.type);
    // userData.append('password',user.password);
    userData.append('user_img',user.user_img);

  //  userData.append('club_id',JSON.parse(localStorage.getItem('user')).club_id);

    //console.log(userData);
     this.http.put(`http://localhost:3000/api/users/`+id,userData)
     .subscribe(res=>{
       console.log(res);


    }); 
  }

  DeleteUser(id:string){
    this.http.delete(`http://localhost:3000/api/users/${id}/deleteuser`)
    .subscribe(res=>{
      console.log(res);
  
  
   }); 
  }
  getStats(){
    return this.http.get(`http://localhost:3000/api/users/stats`);

  }

}
