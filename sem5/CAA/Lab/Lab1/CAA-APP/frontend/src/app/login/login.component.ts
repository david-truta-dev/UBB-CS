import { Component } from '@angular/core';
import { Credentials } from '../core/models/credentials.model';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { selectAuthState } from '../store/app.states';
import { LogIn } from '../store/actions/user.actions';
import { AuthState } from '../store/states/auth.states';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent {
  credentials: Credentials = new Credentials();
  users$: Observable<AuthState>;
  errorMessage: string | null;

  constructor(private store: Store<AuthState>) {
    this.users$ = this.store.select(selectAuthState);
  }

  login(credentials: Credentials): void {
    this.store.dispatch(new LogIn(credentials));
  }
}
