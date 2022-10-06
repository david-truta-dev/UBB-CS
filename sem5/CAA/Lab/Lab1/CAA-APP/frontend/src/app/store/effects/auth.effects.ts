import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Actions, Effect, ofType } from '@ngrx/effects';
import { AuthenticationService } from 'src/app/core/services/authentication.service';
import { Observable, of } from 'rxjs';
import {
  AuthActionTypes,
  LogIn,
  LogInSuccess,
  LogInFailure,
} from '../actions/user.actions';
import { tap, map, switchMap, catchError } from 'rxjs/operators';

@Injectable()
export class AuthEffects {
  constructor(
    private actions: Actions,
    private authService: AuthenticationService,
    private router: Router
  ) {}

  @Effect()
  LogIn: Observable<any> = this.actions.pipe(
    ofType<LogIn>(AuthActionTypes.LOGIN),
    map((action: LogIn) => action.payload),
    switchMap((payload) => {
      return this.authService.login(payload).pipe(
        map(() => new LogInSuccess({ credentials: payload.credentials })),
        catchError((error) => {
          return of(new LogInFailure({ error: error }));
        })
      );
    })
  );

  @Effect({ dispatch: false })
  LogInSuccess: Observable<any> = this.actions.pipe(
    ofType(AuthActionTypes.LOGIN_SUCCESS),
    tap(() => this.router.navigateByUrl('/'))
  );

  @Effect({ dispatch: false })
  LogInFailure: Observable<any> = this.actions.pipe(
    ofType(AuthActionTypes.LOGIN_FAILURE)
  );
}
