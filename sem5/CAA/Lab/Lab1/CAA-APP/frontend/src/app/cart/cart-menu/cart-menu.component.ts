import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-cart-menu',
  templateUrl: './cart-menu.component.html'
})
export class CartMenuComponent {
  @Output() checkout = new EventEmitter();

  constructor() { }

}
