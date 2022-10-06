import { Injectable } from '@angular/core';
import { Product } from '../models/product.model';
import { CartItem } from '../models/cart-item.model';

@Injectable({
  providedIn: 'root',
})
export class CartService {
  cartItems = new Map<number, CartItem>();

  constructor() {}

  getCartItems() {
    return this.cartItems;
  }

  addProduct(product: Product) {
    if (this.checkIfExists(product)) {
      this.incrementCartProduct(product);
    } else {
      this.cartItems.set(product.id, this.newCartItem(product));
    }
  }

  newCartItem(product: Product): CartItem {
    return { product: product, quantity: 1 };
  }

  isEmpty() {
    return this.cartItems.size > 0;
  }

  checkIfExists(product: Product) {
    return this.cartItems.has(product.id);
  }

  incrementCartProduct(product: Product) {
    this.cartItems.get(product.id).quantity += 1;
  }

  decrementCartProduct(product: Product) {
    let item = this.cartItems.get(product.id);
    item.quantity -= 1;
    if (item.quantity < 1) {
      this.removeItemFromCart(item);
    }
  }

  incrementCartItem(cartItem: CartItem) {
    this.cartItems.get(cartItem.product.id).quantity += 1;
  }

  decrementCartItem(cartItem: CartItem) {
    let item = this.cartItems.get(cartItem.product.id);
    item.quantity -= 1;
    if (item.quantity < 1) {
      this.removeItemFromCart(item);
    }
  }

  findCartItemByProductId(productId: number): CartItem {
    return this.cartItems.get(productId);
  }

  removeItemFromCart(cartItem: CartItem) {
    this.cartItems.delete(cartItem.product.id);
  }

  clearCart() {
    this.cartItems.clear();
  }
}
