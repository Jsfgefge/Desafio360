import express from 'express'
import routerTest from './routes/test.routes.js';
// import dbconnection from "./dbconnection.js";

const app = express();

app.use(express.json());
app.use(routerTest);

app.listen(3000,console.log('listening on 3000'));





