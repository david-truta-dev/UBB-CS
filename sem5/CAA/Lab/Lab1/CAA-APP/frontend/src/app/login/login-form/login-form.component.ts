import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { Credentials } from 'src/app/core/models/credentials.model';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css'],
})
export class LoginFormComponent implements OnInit {
  @Output() login = new EventEmitter();
  @Input() error: string;
  credentials: Credentials;

  constructor() {}

  ngOnInit() {
    this.credentials = new Credentials();
  }
}
