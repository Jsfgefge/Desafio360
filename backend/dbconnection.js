import { Sequelize } from 'sequelize';
import dotenv from 'dotenv'
dotenv.config();

const DBNAME = process.env.DBNAME
const DBUSER = process.env.DBUSER
const DBPASS = process.env.DBPASS

const sequelize = new Sequelize(DBNAME,DBUSER,DBPASS, {
    dialect:'mssql',
    pool:{
        max:5,
        min:0,
        acquire:30000,
    }
});

const sqlConn = async ()=> {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}



export default sqlConn;