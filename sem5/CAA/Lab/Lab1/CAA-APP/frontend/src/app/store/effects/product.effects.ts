import { Injectable } from '@angular/core';
import { Actions, Effect, ofType } from '@ngrx/effects';
import { Observable, of } from 'rxjs';
import { map, switchMap, catchError } from 'rxjs/operators';
import { ProductService } from 'src/app/core/services/product.service';
import {
  CreateProduct,
  ProductActionTypes,
  CreateProductSuccess,
  CreateProductFailure,
  GetProduct,
  GetProductSuccess,
  GetProductFailure,
  GetProducts,
  GetProductsSuccess,
  GetProductsFailure,
  UpdateProduct,
  UpdateProductSuccess,
  UpdateProductFailure,
  DeleteProductSuccess,
  DeleteProduct,
  DeleteProductFailure,
} from '../actions/product.actions';
import { ProductHeader } from 'src/app/core/models/product-header.model';
import { Product } from 'src/app/core/models/product.model';

@Injectable()
export class ProductEffects {
  constructor(
    private actions$: Actions,
    private productService: ProductService
  ) {}

  // Create Product
  @Effect()
  CreateProduct: Observable<any> = this.actions$.pipe(
    ofType<CreateProduct>(ProductActionTypes.CREATEPRODUCT),
    map((action: CreateProduct) => action.payload),
    switchMap((payload) => {
      return this.productService.addProduct(payload).pipe(
        map(() => {
          new CreateProductSuccess({ product: payload });
        }),
        catchError((error) => {
          return of(new CreateProductFailure({ error: error }));
        })
      );
    })
  );

  // Get Product
  @Effect()
  GetProduct: Observable<any> = this.actions$.pipe(
    ofType<GetProduct>(ProductActionTypes.GETPRODUCT),
    map((action: GetProduct) => action.payload),
    switchMap((payload) => {
      return this.productService.getProduct(payload).pipe(
        map((product: Product) => {
          return new GetProductSuccess(product);
        }),
        catchError((error) => {
          return of(new GetProductFailure({ error: error }));
        })
      );
    })
  );

  // Get Products
  @Effect()
  getProducts: Observable<any> = this.actions$.pipe(
    ofType<GetProducts>(ProductActionTypes.GETPRODUCTS),
    switchMap(() => {
      return this.productService.getProducts().pipe(
        map((products: ProductHeader[]) => {
          return new GetProductsSuccess(products);
        }),
        catchError((error) => {
          return of(new GetProductsFailure({ error: error }));
        })
      );
    })
  );

  // Update Product
  @Effect()
  UpdateProduct: Observable<any> = this.actions$.pipe(
    ofType<UpdateProduct>(ProductActionTypes.UPDATEPRODUCT),
    map((action: UpdateProduct) => action.payload),
    switchMap((payload) => {
      return this.productService.updateProduct(payload).pipe(
        map(() => {
          new UpdateProductSuccess({ product: payload });
        }),
        catchError((error) => {
          return of(new UpdateProductFailure({ error: error }));
        })
      );
    })
  );

  // Delete Product
  @Effect()
  DeleteProduct: Observable<any> = this.actions$.pipe(
    ofType<DeleteProduct>(ProductActionTypes.DELETEPRODUCT),
    map((action: DeleteProduct) => action.payload),
    switchMap((payload) => {
      return this.productService.deleteProduct(payload).pipe(
        map(() => {
          new DeleteProductSuccess({ product: payload });
        }),
        catchError((error) => {
          return of(new DeleteProductFailure({ error: error }));
        })
      );
    })
  );
}
