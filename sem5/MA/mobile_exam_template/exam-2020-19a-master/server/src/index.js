var koa = require('koa');
var app = module.exports = new koa();
const server = require('http').createServer(app.callback());
const WebSocket = require('ws');
const wss = new WebSocket.Server({server});
const Router = require('koa-router');
const cors = require('@koa/cors');
const bodyParser = require('koa-bodyparser');

app.use(bodyParser());

app.use(cors());

app.use(middleware);

function middleware(ctx, next) {
  const start = new Date();
  return next().then(() => {
    const ms = new Date() - start;
    console.log(`${start.toLocaleTimeString()} ${ctx.request.method} ${ctx.request.url} ${ctx.response.status} - ${ms}ms`);
  });
}

const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
};

const names = ['Wright Flyer',
  'Supermarine Spitfire',
  'Boeing 787',
  'Lockheed SR-71 Blackbird',
  'Cirrus SR22',
  'Learjet 23',
  'Lockheed C-130',
  'Douglas DC-3',
  'Bleriot XI',
  'Cessna 172',
  'Boeing B-29 Superfortress',
  'Gulfstream G500',
  'Boeing 747',
  'Bell X-1',
  'Spirit of St. Louis'];
const statuses = ['new', 'working', 'damaged', 'private'];
const owners = ['John', 'Joe', 'Jim', 'Jone', 'Joan', 'Jack'];
const manufactures = ['Boeing', 'Airbus', 'Bombardier', 'Embraer', 'Dassault', 'Gulfstream'];
const planes = [];

for (let i = 0; i < 50; i++) {
  planes.push({
    id: i + 1,
    name: names[getRandomInt(0, names.length)],
    status: statuses[getRandomInt(0, statuses.length)],
    size: getRandomInt(200, 1000),
    owner: owners[getRandomInt(0, owners.length)],
    manufacturer: manufactures[getRandomInt(0, manufactures.length)],
    capacity: getRandomInt(0, 10000)
  });
}

const router = new Router();

router.get('/all', ctx => {
  ctx.response.body = planes;
  ctx.response.status = 200;
});

router.get('/types', ctx => {
  ctx.response.body = [...new Set(planes.map(obj => obj.manufacturer))];
  ctx.response.status = 200;
});

router.get('/planes/:manufacturer', ctx => {
  const headers = ctx.params;
  const manufacturer = headers.manufacturer;
  if (typeof manufacturer !== 'undefined') {
    ctx.response.body = planes.filter(obj => obj.manufacturer == manufacturer);
    ctx.response.status = 200;
  } else {
    console.log("Missing or invalid: manufacturer!");
    ctx.response.body = {text: 'Missing or invalid: manufacturer!'};
    ctx.response.status = 404;
  }
});

router.get('/my/:owner', ctx => {
  const headers = ctx.params;
  const owner = headers.owner;
  if (typeof owner !== 'undefined') {
    ctx.response.body = planes.filter(obj => obj.owner == owner);
    ctx.response.status = 200;
  } else {
    console.log("Missing or invalid: owner!");
    ctx.response.body = {text: 'Missing or invalid: owner!'};
    ctx.response.status = 404;
  }
});


const broadcast = (data) =>
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });

router.post('/plane', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const name = headers.name;
  const size = headers.size;
  const owner = headers.owner;
  const manufacturer = headers.manufacturer;
  const capacity = headers.capacity;
  if (typeof name !== 'undefined' && typeof owner !== 'undefined' && typeof size !== 'undefined'
    && manufacturer !== 'undefined' && capacity !== 'undefined') {
    const index = planes.findIndex(obj => obj.name == name && obj.owner == owner);
    if (index !== -1) {
      console.log("Plane already exists!");
      ctx.response.body = {text: 'Plane already exists!'};
      ctx.response.status = 404;
    } else {
      let maxId = Math.max.apply(Math, planes.map(function (obj) {
        return obj.id;
      })) + 1;
      let obj = {
        id: maxId,
        name,
        status: 'new',
        size,
        owner,
        manufacturer,
        capacity
      };
      // console.log("created: " + JSON.stringify(name));
      planes.push(obj);
      broadcast(obj);
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid fields!");
    ctx.response.body = {text: 'Missing or invalid fields!'};
    ctx.response.status = 404;
  }
});

router.del('/plane/:id', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = planes.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("No plane with id: " + id);
      ctx.response.body = {text: 'Invalid plane id'};
      ctx.response.status = 404;
    } else {
      let obj = planes[index];
      // console.log("deleting: " + JSON.stringify(obj));
      planes.splice(index, 1);
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid fields!");
    ctx.response.body = {text: 'Id missing or invalid'};
    ctx.response.status = 404;
  }
});

app.use(router.routes());
app.use(router.allowedMethods());

server.listen(1876);