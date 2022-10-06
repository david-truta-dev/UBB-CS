import * as fromAuth from './reducers/auth.reducers';
import * as fromProduct from './reducers/product.reducers';
import { createFeatureSelector } from '@ngrx/store';
import { AuthState } from './states/auth.states';
import { ProductState } from './states/product.states';

export interface AppState {
  authState: AuthState;
  productState: ProductState;
}

export const reducers = {
  auth: fromAuth.reducer,
  product: fromProduct.reducer,
};

export const selectAuthState = createFeatureSelector<AuthState>('auth');
export const selectProductState = createFeatureSelector<ProductState>(
  'product'
);
