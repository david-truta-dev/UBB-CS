import { Component } from '@angular/core';
import { Product } from '../core/models/product.model';
import { Router } from '@angular/router';
import { ProductService } from '../core/services/product.service';
import { MatSnackBar } from '@angular/material';

@Component({
  selector: 'app-product-add',
  templateUrl: './product-add.component.html',
  styleUrls: ['./product-add.component.css'],
})
export class ProductAddComponent {
  product: Product = new Product();

  constructor(
    private router: Router,
    private productService: ProductService,
    private snackBar: MatSnackBar
  ) {}

  saveProduct(product: Product) {
    this.productService.addProduct(product).subscribe(
      () => {
        this.snackBar
          .open(`Product ${product.name} created`, 'Homepage', {
            duration: 5000,
          })
          .onAction()
          .subscribe(() => this.router.navigate(['..']));
      },
      (error) => {
        console.log(error);
        this.snackBar.open(`Couldn't create the product: ${error}`, undefined, {
          duration: 5000,
        });
      }
    );
  }
}
