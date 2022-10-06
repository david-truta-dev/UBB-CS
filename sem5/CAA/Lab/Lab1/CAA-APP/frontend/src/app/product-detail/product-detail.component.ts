import { Component, OnInit } from '@angular/core';
import { Product } from '../core/models/product.model';
import { ActivatedRoute, Router } from '@angular/router';
import { CartService } from '../core/services/cart.service';
import { Store } from '@ngrx/store';
import { AppState } from '../store/app.states';
import { getSelectedProduct } from '../store/selectors/product.selectors';
import { GetProduct, DeleteProduct } from '../store/actions/product.actions';
import { Observable } from 'rxjs';
import { MatSnackBar } from '@angular/material';
import { AuthenticationService } from '../core/services/authentication.service';

@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.css'],
})
export class ProductDetailComponent implements OnInit {
  product$: Observable<Product>;
  id: number;
  actualProduct: Product;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cartService: CartService,
    private store: Store<AppState>,
    private snackBar: MatSnackBar,
    public authenticationService: AuthenticationService
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

  deleteProduct() {
    this.store.dispatch(new DeleteProduct(this.id));
    this.router.navigateByUrl('/products');
  }

  addToCart() {
    this.cartService.addProduct(this.actualProduct);
    this.snackBar.open(
      `${this.actualProduct.name} added to your shopping cart`,
      undefined,
      {
        duration: 2000,
      }
    );
  }
}
