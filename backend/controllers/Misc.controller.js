import sql from "../dbconnection.js";
const pool = await sql.sequelize;


//GET METHODS-------------------------------------------------------------------
const getEstados = async (req, res) => {
    const result = await pool.query("SELECT * FROM Estados");
    console.log("Estados retrieved");
    res.status(200).send(result);
};

const getMarcas = async (req, res) => {
    const result = await pool.query("SELECT * FROM Marcas");
    console.log("Estados retrieved");
    res.status(200).send(result);
};

const getRoles = async (req, res) => {
    const result = await pool.query("SELECT * FROM Roles");
    console.log("Estados retrieved");
    res.status(200).send(result);
};

//CREATE METHODS----------------------------------------------------------------

const createEstado = async (req, res) => {
    const query = pool.query("EXEC spEstados_Insert :estadoName", {
        replacements: {
            estadoName: req.body.estadoName
        }
    });
    console.log('Estado created');

    res.status(200).send(query);
}
const createMarca = async (req, res) => {
    const query = pool.query("EXEC spMarcas_Insert :marcaName", {
        replacements: {
            marcaName: req.body.marcaName
        }
    });
    console.log('Marca created');

    res.status(200).send(query);
}

const createRol = async (req, res) => {
    const query = pool.query("EXEC spRoles_Insert :rolName", {
        replacements: {
            rolName: req.body.rolName
        }
    });
    console.log('Rol created');

    res.status(200).send(query);
}

//UPDATE METHODS----------------------------------------------------------------

const updateEstado = async (req, res) => {
    const query = pool.query("EXEC spEstados_Update :estadoId,:estadoName", {
        replacements: {
            estadoId: req.body.id,
            estadoName: req.body.estadoName
        }
    });
    console.log('Estado updated');

    res.status(200).send(query);
}

const updateMarca = async (req, res) => {
    const query = pool.query("EXEC spMarcas_Update :marcaId,:marcaName", {
        replacements: {
            marcaId: req.body.id,
            marcaName: req.body.marcaName
        }
    });
    console.log('Marca updated');

    res.status(200).send(query);
}

const updateRol = async (req, res) => {
    const query = pool.query("EXEC spRoles_Update :rolId,:rolName", {
        replacements: {
            rolId: req.body.id,
            rolName: req.body.rolName
        }
    });
    console.log('Rol updated');

    res.status(200).send(query);
}

//UPDATE METHODS----------------------------------------------------------------

const deleteEstado = async (req, res) => {
    const query = pool.query("EXEC spEstados_Delete :estadoId", {
        replacements: {
            estadoId: req.body.id
        }
    });
    console.log('Estado deleted');

    res.status(200).send(query);
}

const deleteMarca = async (req, res) => {
    const query = pool.query("EXEC spMarcas_Delete :marcaId", {
        replacements: {
            marcaId: req.body.id
        }
    });
    console.log('Marca deleted');

    res.status(200).send(query);
}

const deleteRol = async (req, res) => {
    const query = pool.query("EXEC spRoles_Delete :rolId", {
        replacements: {
            rolId: req.body.id
        }
    });
    console.log('Rol deleted');

    res.status(200).send(query);
}




export default {
    getEstados,
    getMarcas,
    getRoles,
    createEstado,
    createMarca,
    createRol,
    updateEstado,
    updateMarca,
    updateRol,
    deleteEstado,
    deleteMarca,
    deleteRol
}