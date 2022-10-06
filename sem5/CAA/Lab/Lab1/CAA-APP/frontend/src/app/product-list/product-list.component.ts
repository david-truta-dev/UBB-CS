import { Component, OnInit } from '@angular/core';
import { ProductHeader } from '../core/models/product-header.model';
import { AuthenticationService } from '../core/services/authentication.service';
import { Observable } from 'rxjs';
import { AuthState } from '../store/states/auth.states';
import { selectAuthState, AppState } from '../store/app.states';
import { Store } from '@ngrx/store';
import { GetProducts } from '../store/actions/product.actions';
import { getProducts } from '../store/selectors/product.selectors';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
})
export class ProductListComponent implements OnInit {
  productHeaders: ProductHeader[] = [];
  user$: Observable<AuthState>;
  products$: Observable<ProductHeader[] | null>;

  constructor(
    public authenticationService: AuthenticationService,
    private store: Store<AppState>
  ) {
    this.user$ = this.store.select(selectAuthState);
    this.products$ = this.store.select(getProducts);
  }

  ngOnInit() {
    this.store.dispatch(new GetProducts());
  }
}
