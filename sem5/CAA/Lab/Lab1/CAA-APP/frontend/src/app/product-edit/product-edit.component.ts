import { Component, OnInit } from '@angular/core';
import { Product } from '../core/models/product.model';
import { ActivatedRoute, Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { AppState } from '../store/app.states';
import { Observable } from 'rxjs';
import { GetProduct } from '../store/actions/product.actions';
import { getSelectedProduct } from '../store/selectors/product.selectors';
import { ProductService } from '../core/services/product.service';
import { MatSnackBar } from '@angular/material';

@Component({
  selector: 'app-product-edit',
  templateUrl: './product-edit.component.html',
})
export class ProductEditComponent implements OnInit {
  product$: Observable<Product>;
  actualProduct: Product;
  id: number;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private store: Store<AppState>,
    private productService: ProductService,
    private snackBar: MatSnackBar
  ) {
    this.product$ = this.store.select(getSelectedProduct);
  }

  ngOnInit() {
    this.id = parseInt(this.route.snapshot.paramMap.get('id'));
    this.store.dispatch(new GetProduct(this.id));
    this.product$.subscribe(
      (product: Product) => (this.actualProduct = product)
    );
  }

  saveProduct(product: Product) {
    this.productService.updateProduct(product).subscribe(
      () => {
        this.snackBar
          .open(`Product ${product.name} updated`, 'Homepage', {
            duration: 5000,
          })
          .onAction()
          .subscribe(() => this.router.navigate(['..']));
      },
      (error) => {
        console.log(error);
        this.snackBar.open(`Couldn't update the product: ${error}`, undefined, {
          duration: 5000,
        });
      }
    );
  }
}
