import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from '../common/api.service'
import { Signup } from "./signup.component";
import { Miniform } from "../common/miniform.component"

@Component({
  selector: 'login',
  template: require('./login.template.jade'),
  directives: [Signup]
})
export class Login extends Miniform {
  constructor(
    private route: Router,
    private api: ApiService) {super()}
  form = {
    user: "",
    password: "",
  }

  private teamList: Array<any> = [];
  private selectedTeamId: string;
  private get selectedTeam(){
    return this.teamList.find(t => t.id == parseInt(this.selectedTeamId))
  }

  ngOnInit() {
  }

  post(){
    return this.api.login(this.form.user, this.form.password)
  }
  success(response: any){
    console.log("OK");
    this.route.navigate(["/"]);
  }
  error(response: any){
    return "ログインが失敗しました";
  }
}
