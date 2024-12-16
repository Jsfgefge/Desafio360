import {Router} from 'express'
import productController from '../controllers/Products.controller.js';

const routerProducts = Router();

routerProducts.get('/', productController.getProducts);

routerProducts.get('/:id',(req,res)=>{
    res.send('obteniendo un soloproducto ');
});
routerProducts.post('/new', productController.createProducto);


routerProducts.post('/test',(req,res)=>{
    res.send('actualizada esta wea');
})

export default routerProducts