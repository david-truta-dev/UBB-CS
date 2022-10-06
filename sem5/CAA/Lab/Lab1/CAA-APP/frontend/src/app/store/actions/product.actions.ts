import { Action } from '@ngrx/store';
import { ProductHeader } from 'src/app/core/models/product-header.model';
import { Product } from 'src/app/core/models/product.model';

export enum ProductActionTypes {
  CREATEPRODUCT = '[Product] Product Create',
  CREATEPRODUCT_SUCCESS = '[Product] Product Create Success',
  CREATEPRODUCT_FAILURE = '[Product] Product Create Failure',
  GETPRODUCT = '[Product] Get Product',
  GETPRODUCT_SUCCESS = '[Product] Get Product Success',
  GETPRODUCT_FAILURE = '[Product] Get Product Failure',
  GETPRODUCTS = '[Product] Get Products',
  GETPRODUCTS_SUCCESS = '[Product] Get Products Success',
  GETPRODUCTS_FAILURE = '[Product] Get Products Failure',
  UPDATEPRODUCT = '[Product] Update Product',
  UPDATEPRODUCT_SUCCESS = '[Product] Update Product Success',
  UPDATEPRODUCT_FAILURE = '[Product] Update Product Failure',
  DELETEPRODUCT = '[Product] Delete Product',
  DELETEPRODUCT_SUCCESS = '[Product] Delete Product Success',
  DELETEPRODUCT_FAILURE = '[Product] Delete Product Failure',
}

// Create Product
export class CreateProduct implements Action {
  readonly type = ProductActionTypes.CREATEPRODUCT;
  constructor(public payload: any) {}
}
export class CreateProductSuccess implements Action {
  readonly type = ProductActionTypes.CREATEPRODUCT_SUCCESS;
  constructor(public payload: any) {}
}
export class CreateProductFailure implements Action {
  readonly type = ProductActionTypes.CREATEPRODUCT_FAILURE;
  constructor(public payload: any) {}
}
// Get Product (one)
export class GetProduct implements Action {
  readonly type = ProductActionTypes.GETPRODUCT;
  constructor(public payload: any) {}
}
export class GetProductSuccess implements Action {
  readonly type = ProductActionTypes.GETPRODUCT_SUCCESS;
  constructor(public payload: Product) {}
}
export class GetProductFailure implements Action {
  readonly type = ProductActionTypes.GETPRODUCT_FAILURE;
  constructor(public payload: any) {}
}
// Get Products (all)
export class GetProducts implements Action {
  readonly type = ProductActionTypes.GETPRODUCTS;
  constructor() {}
}
export class GetProductsSuccess implements Action {
  readonly type = ProductActionTypes.GETPRODUCTS_SUCCESS;
  constructor(public payload: ProductHeader[]) {}
}
export class GetProductsFailure implements Action {
  readonly type = ProductActionTypes.GETPRODUCTS_FAILURE;
  constructor(public payload: any) {}
}
// Update Product
export class UpdateProduct implements Action {
  readonly type = ProductActionTypes.UPDATEPRODUCT;
  constructor(public payload: any) {}
}
export class UpdateProductSuccess implements Action {
  readonly type = ProductActionTypes.UPDATEPRODUCT_SUCCESS;
  constructor(public payload: any) {}
}
export class UpdateProductFailure implements Action {
  readonly type = ProductActionTypes.UPDATEPRODUCT_FAILURE;
  constructor(public payload: any) {}
}
// Delete Product
export class DeleteProduct implements Action {
  readonly type = ProductActionTypes.DELETEPRODUCT;
  constructor(public payload: any) {}
}
export class DeleteProductSuccess implements Action {
  readonly type = ProductActionTypes.DELETEPRODUCT_SUCCESS;
  constructor(public payload: any) {}
}
export class DeleteProductFailure implements Action {
  readonly type = ProductActionTypes.DELETEPRODUCT_FAILURE;
  constructor(public payload: any) {}
}

export type All =
  | CreateProduct
  | CreateProductFailure
  | CreateProductSuccess
  | GetProduct
  | GetProductFailure
  | GetProductSuccess
  | GetProducts
  | GetProductsFailure
  | GetProductsSuccess
  | UpdateProduct
  | UpdateProductFailure
  | UpdateProductSuccess
  | DeleteProduct
  | DeleteProductFailure
  | DeleteProductSuccess;
