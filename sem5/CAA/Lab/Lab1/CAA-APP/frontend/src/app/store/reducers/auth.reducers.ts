import { AuthActionTypes, All } from '../actions/user.actions';
import { initialAuthState, AuthState } from '../states/auth.states';

export function reducer(state = initialAuthState, action: All): AuthState {
  switch (action.type) {
    case AuthActionTypes.LOGIN_SUCCESS: {
      return {
        ...state,
        isAuthenticated: true,
        user: action.payload.user,
        errorMessage: null,
      };
    }
    case AuthActionTypes.LOGIN_FAILURE: {
      return {
        ...state,
        errorMessage: 'Incorrect username and/or password.',
      };
    }
    default: {
      return state;
    }
  }
}
