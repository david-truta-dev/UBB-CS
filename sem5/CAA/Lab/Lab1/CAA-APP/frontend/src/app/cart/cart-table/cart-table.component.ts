import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CartItem } from 'src/app/core/models/cart-item.model';

@Component({
  selector: 'app-cart-table',
  templateUrl: './cart-table.component.html',
  styleUrls: ['./cart-table.component.css']
})
export class CartTableComponent {
  @Input() cartItems: CartItem[]
  @Output() incrementQuantity = new EventEmitter()
  @Output() decrementQuantity = new EventEmitter()

  constructor() { }

  incrementItemQuantity(cartItem: CartItem) {
    this.incrementQuantity.emit(cartItem);
  }

  decrementItemQuantity(cartItem: CartItem) {
    this.decrementQuantity.emit(cartItem);
  }

}
