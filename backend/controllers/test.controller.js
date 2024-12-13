import sql from "../dbconnection.js";
const pool = await sql.sequelize;

const getProducts=async (req,res)=>{
    const result = await pool.query("SELECT * FROM Usuarios");

    console.log('getProducts work');

    res.send(result);
}

export default{
    getProducts
}