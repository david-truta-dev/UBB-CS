import { Component, Input } from '@angular/core';
import { ProductHeader } from 'src/app/core/models/product-header.model';

@Component({
  selector: 'app-product-list-table',
  templateUrl: './product-list-table.component.html',
  styleUrls: ['./product-list-table.component.css'],
})
export class ProductListTableComponent {
  @Input() productHeaders: ProductHeader[];

  constructor() {}
}
