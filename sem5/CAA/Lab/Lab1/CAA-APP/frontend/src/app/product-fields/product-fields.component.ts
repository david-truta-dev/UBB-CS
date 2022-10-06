import { Component, Input, EventEmitter, Output } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../core/models/category.model';
import { Product } from '../core/models/product.model';
import { Supplier } from '../core/models/supplier.model';
import { ProductService } from '../core/services/product.service';

@Component({
  selector: 'app-product-fields',
  templateUrl: './product-fields.component.html',
  styleUrls: ['./product-fields.component.css'],
})
export class ProductFieldsComponent {
  @Input() product: Product;
  @Output() saveProduct = new EventEmitter();
  categories$: Observable<Category[]>;
  suppliers$: Observable<Supplier[]>;

  constructor(private productService: ProductService) {}

  ngOnInit() {
    this.categories$ = this.productService.getCategories();
    this.suppliers$ = this.productService.getSuppliers();
  }

  doSave() {
    this.saveProduct.emit(this.product);
  }
}
