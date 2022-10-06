import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-product-list-menu',
  templateUrl: './product-list-menu.component.html',
  styleUrls: ['./product-list-menu.component.css'],
})
export class ProductListMenuComponent {
  @Input() isAdmin: boolean;
  @Input() isCustomer: boolean;
  constructor() {}
}
