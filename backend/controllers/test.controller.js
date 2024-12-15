import sql from "../dbconnection.js";
const pool = await sql.sequelize;

const getProducts=async (req,res)=>{
    const result = await pool.query("SELECT * FROM Usuarios");

    console.log('getProducts work');

    res.send(result);
}


const createProducto=async (req,res)=>{
    const restult = await pool.query(`EXEC spTestInsert :id,:test`,{
        replacements:{
            id:'123',
            test:'test de esta wea'
        }});

    console.log(restult);
    res.status(200).send('creando producto');
}

export default{
    getProducts,
    createProducto
}