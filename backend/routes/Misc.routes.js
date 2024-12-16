import { Router } from 'express'
import miscController from '../controllers/Misc.controller.js';

const routerMisc = Router();

routerMisc.get('/estados', miscController.getEstados);
routerMisc.get('/marcas', miscController.getMarcas);
routerMisc.get('/roles', miscController.getRoles);

routerMisc.post('/estados', miscController.createEstado);
routerMisc.post('/marcas', miscController.createMarca);
routerMisc.post('/roles', miscController.createRol);

routerMisc.put('/estados', miscController.updateEstado);
routerMisc.put('/marcas', miscController.updateMarca);
routerMisc.put('/roles', miscController.updateRol);

routerMisc.delete('/estados', miscController.deleteEstado);
routerMisc.delete('/marcas', miscController.deleteMarca);
routerMisc.delete('/roles', miscController.deleteRol);




export default routerMisc