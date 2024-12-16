import express from 'express'
import cors from 'cors'
import routerTest from './routes/test.routes.js';
import routerMisc from './routes/Misc.routes.js';
// import routerOrders from './routes/Orders.routes.js';
// import routerProducts from './routes/Products.routes.js';
// import routerUsers from './routes/Users.routes.js';

const app = express();

app.use(cors())

app.use(express.json());

app.use('/misc',routerMisc);
// app.use('/orders',routerOrders);
// app.use('/products',routerProducts);
// app.use('/users',routerUsers);

app.listen(3000,console.log('listening on 3000'));





