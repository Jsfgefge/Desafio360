const { Sequelize } = require('sequelize');
require('dotenv').config();
const DBNAME = process.env.DBNAME
const DBUSER = process.env.DBUSER
const DBPASS = process.env.DBPASS


const sequelize = new Sequelize(DBNAME,DBUSER,DBPASS, {
    dialect:'mssql',
});

async function test() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}


test();