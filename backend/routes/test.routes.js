import {Router} from 'express'
import testController from '../controllers/test.controller.js';

const routerTest = Router();

routerTest.get('/', testController.getProducts);

routerTest.get('/test/:id',(req,res)=>{
    res.send('obteniendo un soloproducto ');
})

routerTest.post('/test',(req,res)=>{
    res.send('actualizada esta wea');
})

export default routerTest