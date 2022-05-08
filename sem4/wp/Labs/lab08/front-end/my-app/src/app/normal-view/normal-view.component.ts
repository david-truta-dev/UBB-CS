import { News } from './../news';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { map, Observable } from 'rxjs';

@Component({
  selector: 'app-normal-view',
  templateUrl: './normal-view.component.html',
  styleUrls: ['./normal-view.component.css']
})
export class NormalViewComponent implements OnInit {
  readonly ROOT_URL = 'http://localhost/api';
  news: Observable<News[]>;


  constructor(private http: HttpClient) { 
    this.news = this.http.get<News[]>(`${this.ROOT_URL}/getAllData.php`).pipe(
      map((res: any) => {
        return res['data'];
      }));
  }

  ngOnInit(): void {
  }

  getAllNews() {
    this.news = this.http.get<News[]>(`${this.ROOT_URL}/getAllData.php`).pipe(
      map((res: any) => {
        return res['data'];
      }));
  }
  
  applyFilters(start: string, end:string, category:string){
    const params = new HttpParams().set('start', start).set('end', end).set('category', category);
    this.news = this.http.get<News[]>(`${this.ROOT_URL}/getFilteredData.php`, {params}).pipe(
      map((res: any) => {
        return res['data'];
      }));
  }

}
