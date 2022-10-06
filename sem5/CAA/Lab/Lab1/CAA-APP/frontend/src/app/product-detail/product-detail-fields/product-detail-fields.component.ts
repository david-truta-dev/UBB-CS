import { Component, Input } from '@angular/core';
import { Product } from 'src/app/core/models/product.model';

@Component({
  selector: 'app-product-detail-fields',
  templateUrl: './product-detail-fields.component.html',
  styleUrls: ['./product-detail-fields.component.css'],
})
export class ProductDetailFieldsComponent {
  @Input() product: Product;

  constructor() {}
}
