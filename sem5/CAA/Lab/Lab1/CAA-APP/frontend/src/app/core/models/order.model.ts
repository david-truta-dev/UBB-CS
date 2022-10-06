export class Order {
  customerId: number;
  products: OrderProduct[];
}

export interface OrderProduct {
  id: number;
  quantity: number;
}

export interface OrderResult {
  id: number;
  shippedFrom: Location;
}

export interface Location {
  id: number;
  name: string;
  addressCountry: string;
  addressCounty: string;
  addressCity: string;
  addressStreetAddress: string;
}
