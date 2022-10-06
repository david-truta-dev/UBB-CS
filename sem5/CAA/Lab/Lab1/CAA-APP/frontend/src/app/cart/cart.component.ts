import { Component, OnInit } from '@angular/core';
import { CartService } from '../core/services/cart.service';
import { CartItem } from '../core/models/cart-item.model';
import { OrderService } from '../core/services/order.service';
import { Order } from '../core/models/order.model';
import { AuthenticationService } from '../core/services/authentication.service';
import { MatSnackBar } from '@angular/material';
import { Router } from '@angular/router';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
})
export class CartComponent implements OnInit {
  cartItems: Map<number, CartItem>;

  constructor(
    private cartService: CartService,
    private authenticationService: AuthenticationService,
    private orderService: OrderService,
    private snackBar: MatSnackBar,
    private router: Router
  ) {}

  ngOnInit() {
    this.cartItems = this.cartService.getCartItems();
  }

  incrementQuantity(cartItem: CartItem) {
    this.cartService.incrementCartItem(cartItem);
  }

  decrementQuantity(cartItem: CartItem) {
    this.cartService.decrementCartItem(cartItem);
  }

  checkout() {
    if (this.cartService.isEmpty() == true) {
      let order: Order = {
        customerId: this.authenticationService.currentUser.id,
        products: Array.from(this.cartItems.values()).map((p) => ({
          id: p.product.id,
          quantity: p.quantity,
        })),
      };
      this.orderService.createOrder(order).subscribe(
        (data) => {
          this.cartService.clearCart();

          this.snackBar
            .open(
              data
                .map(
                  (result, index) =>
                    `Product ${index + 1} will be delivered from ${
                      result.shippedFrom.addressCity
                    }`
                )
                .join(', '),
              'Homepage',
              {
                duration: 8000,
              }
            )
            .onAction()
            .subscribe(() => this.router.navigate(['..']));
        },
        (error) => {
          console.log(error);
          this.snackBar.open(`Couldn't create the order: ${error}`, undefined, {
            duration: 5000,
          });
        }
      );
    } else {
      this.snackBar.open(
        `You don't have any products in your cart`,
        undefined,
        {
          duration: 2000,
        }
      );
    }
  }
}
