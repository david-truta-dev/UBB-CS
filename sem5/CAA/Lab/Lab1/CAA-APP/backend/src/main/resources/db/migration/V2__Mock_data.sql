-- Suppliers
insert into
  supplier (id, name)
values
  (1, 'Samsung');

insert into
  supplier (id, name)
values
  (2, 'LG');

insert into
  supplier (id, name)
values
  (3, 'Apple');

insert into
  supplier (id, name)
values
  (4, 'Under Armour');

-- Categories
insert into
  product_category (id, name, description)
values
  (1, 'Phones', 'Phones');

insert into
  product_category (id, name, description)
values
  (2, 'Tablets', 'Tables');

insert into
  product_category (id, name, description)
values
  (3, 'TV', 'TV');

insert into
  product_category (id, name, description)
values
  (4, 'Sport', 'Sportswear');

-- Customers
insert into
  customer (
    id,
    first_name,
    last_name,
    username,
    password,
    email_address
  )
values
  (
    1,
    'Tanhya',
    'Sapp',
    'user',
    '$2a$10$nzCfBboi7aBMnEOhjiJp2OhQUY0aCLY4hXy9711.bGihScamL0pOW'
    /* Decrypted: storepass */
,
    'tsapp0@altervista.org'
  );

insert into
  customer (
    id,
    first_name,
    last_name,
    username,
    password,
    email_address
  )
values
  (
    2,
    'Kathy',
    'Birdsey',
    'user2',
    '{noop}user2',
    'kbirdsey1@issuu.com'
  );

-- Locations
insert into
  location (
    id,
    name,
    address_country,
    address_city,
    address_county,
    address_street_address
  )
values
  (
    1,
    'Showroom Cluj Platinia',
    'Romania',
    'Cluj-Napoca',
    'Cluj',
    '2-6 Calea Manastur'
  );

insert into
  location (
    id,
    name,
    address_country,
    address_city,
    address_county,
    address_street_address
  )
values
  (
    2,
    'Showroom Brasov',
    'Romania',
    'Brasov',
    'Brasov',
    '58 Nicolae Titulescu'
  );

insert into
  location (
    id,
    name,
    address_country,
    address_city,
    address_county,
    address_street_address
  )
values
  (
    3,
    'Showroom Oradea',
    'Romania',
    'Oradea',
    'Bihor',
    '1 Piata Cetatii'
  );

insert into
  location (
    id,
    name,
    address_country,
    address_city,
    address_county,
    address_street_address
  )
values
  (
    4,
    'Showroom Crangasi',
    'Romania',
    'Bucuresti',
    'Bucuresti',
    '148 Soseaua Virtutii'
  );

-- Products
insert into
  product (
    id,
    name,
    description,
    price,
    weight,
    category_id,
    supplier_id,
    image_url
  )
values
  (
    1,
    'Galaxy S20',
    'Galaxy S20',
    3110.99,
    0.8,
    1,
    1,
    'https://lcdn.altex.ro/media/catalog/product/S/2/S20-cosmic-gray_4_88e92f6d.jpg'
  );

insert into
  product (
    id,
    name,
    description,
    price,
    weight,
    category_id,
    supplier_id,
    image_url
  )
values
  (
    2,
    'iPhone SE 2',
    'iPhone SE v2',
    2249.99,
    0.9,
    1,
    3,
    'https://lcdn.altex.ro/resize/media/catalog/product/i/P/2bd48d28d1c32adea0e55139a4e6434a/iPhone_SE_Black_2-up_US-EN_SCREEN.jpg'
  );

insert into
  product (
    id,
    name,
    description,
    price,
    weight,
    category_id,
    supplier_id,
    image_url
  )
values
  (
    3,
    'Sport Hoodie',
    'Hanorac sport UNDER ARMOUR pe negru / alb',
    207.99,
    1,
    4,
    4,
    'https://cdn.aboutstatic.com/file/a0ba460b11752b569f911278a8593408?width=1200&height=1600&quality=75&bg=F4F4F5&trim=1'
  );

insert into
  product (
    id,
    name,
    description,
    price,
    weight,
    category_id,
    supplier_id,
    image_url
  )
values
  (
    4,
    'Televizor LED Smart LG 43UN81003LB, 4K Ultra HD, HDR, 108 cm',
    'Televizor LED Smart LG 43UN81003LB, 4K Ultra HD, HDR, 108 cm',
    2051.92,
    12,
    4,
    4,
    'https://lcdn.altex.ro/media/catalog/product/4/3/43_55UN81003LB_1_.jpg'
  );

-- Stock
insert into
  stock (product_id, location_id, quantity)
values
  (1, 1, 20) on conflict do nothing;

insert into
  stock (product_id, location_id, quantity)
values
  (1, 2, 30) on conflict do nothing;

insert into
  stock (product_id, location_id, quantity)
values
  (1, 3, 200) on conflict do nothing;


insert into
  stock (product_id, location_id, quantity)
values
  (2, 1, 20) on conflict do nothing;

insert into
  stock (product_id, location_id, quantity)
values
  (2, 2, 30) on conflict do nothing;

insert into
  stock (product_id, location_id, quantity)
values
  (2, 3, 200) on conflict do nothing;


insert into
  stock (product_id, location_id, quantity)
values
  (3, 4, 1000) on conflict do nothing;


insert into
  stock (product_id, location_id, quantity)
values
  (4, 2, 30) on conflict do nothing;

insert into
  stock (product_id, location_id, quantity)
values
  (4, 3, 25) on conflict do nothing;

create sequence hibernate_sequence start 10;