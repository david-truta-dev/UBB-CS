import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Product } from 'src/app/core/models/product.model';

@Component({
  selector: 'app-product-detail-delete-modal',
  templateUrl: './product-detail-delete-modal.component.html',
  styleUrls: ['./product-detail-delete-modal.component.css'],
})
export class ProductDetailDeleteModalComponent {
  @Input() product: Product;
  @Output() deleteProduct = new EventEmitter();

  constructor() {}

  doDelete() {
    this.deleteProduct.emit(this.product);
  }
}
