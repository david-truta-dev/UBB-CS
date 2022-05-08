import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NormalViewComponent } from './normal-view.component';

describe('NormalViewComponent', () => {
  let component: NormalViewComponent;
  let fixture: ComponentFixture<NormalViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NormalViewComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NormalViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
