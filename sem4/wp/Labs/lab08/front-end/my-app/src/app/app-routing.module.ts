import { LoginComponent } from './login/login.component';
import { AdminViewComponent } from './admin-view/admin-view.component';
import { NormalViewComponent } from './normal-view/normal-view.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: 'normal-view', component: NormalViewComponent },
  { path: 'admin-view', component: AdminViewComponent },
  { path: '', component: LoginComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
