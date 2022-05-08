import { HttpClient, HttpParams } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { map, Observable } from 'rxjs';
import { News } from '../news';

@Component({
  selector: 'app-admin-view',
  templateUrl: './admin-view.component.html',
  styleUrls: ['./admin-view.component.css']
})
export class AdminViewComponent implements OnInit {
  readonly ROOT_URL = 'http://localhost/api';
  news: Observable<News[]>;
  newNew: any;


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

  postNews(id: string, title:string, date:string, category:string, content:string, prod:string){
    const idnews = Number(id);
    const idproducer = Number(prod);
    const newNews : News = {
      idnews,
      title,
      date, 
      category,
      text: content,
      idproducer
    }
    this.newNew = this.http.post(`${this.ROOT_URL}/addUpdate.php`, newNews ).pipe(
      map((res: any) => {
        return res['data'];
      })
    ).subscribe();
    this.getAllNews();
  }

  applyFilters(start: string, end:string, category:string){
    const params = new HttpParams().set('start', start).set('end', end).set('category', category);
    this.news = this.http.get<News[]>(`${this.ROOT_URL}/getFilteredData.php`, {params}).pipe(
      map((res: any) => {
        return res['data'];
      }));
  }

}
