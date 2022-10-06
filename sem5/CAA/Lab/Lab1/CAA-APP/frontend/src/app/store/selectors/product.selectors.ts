import { createSelector } from '@ngrx/store';
import { selectProductState } from '../app.states';
import { ProductState } from '../states/product.states';

export const getProducts = createSelector(
  selectProductState,
  (state: ProductState) => state.products
);

export const getSelectedProduct = createSelector(
  selectProductState,
  (state: ProductState) => state.selectedProduct
);
