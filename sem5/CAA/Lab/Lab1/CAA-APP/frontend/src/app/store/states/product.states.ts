import { Product } from 'src/app/core/models/product.model';
import { ProductHeader } from 'src/app/core/models/product-header.model';

export interface ProductState {
  products: ProductHeader[];
  selectedProduct: Product;
  errorMessage: string | null;
  loading: boolean;
}

export const initialProductState: ProductState = {
  products: [],
  selectedProduct: null,
  errorMessage: null,
  loading: false,
};
