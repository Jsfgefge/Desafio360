const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('GDA00545OT_AngelMarroquin', 'dbo', null, {
    dialect: 'mssql',
    host: 'localhost',
    dialectOptions: {
        authentication: {
            type: 'ntlm',
            options: {
                userName: 'jsfge',
                password: '',
                domain: 'JSFGEFGE',
                encrypt: true,
                trustServerCertificate:true
            },
        },
        options: {
            port: 1433
        },
    }
});


async function test() {
    try {
        await sequelize.authenticate();
        console.log("Nice");
    } catch (err) {
        console.log("Error", err)
    }
}


test();