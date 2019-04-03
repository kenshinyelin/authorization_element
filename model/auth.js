/**
 * Created by Administrator on 2017/3/21.
 * user Model
 */
let DbInit = require('./DbInit');
let sequelize = DbInit.sequelize;
let Sequelize=DbInit.seqobj;
let auth = sequelize.define('auth', {

    authid: {
        type: Sequelize.STRING(30),
        primaryKey:true,
        allowNull:false
    },
    authname: {
        type: Sequelize.STRING(50),
        allowNull:false
    },
    authtype: {
        type: Sequelize.CHAR(1),
        allowNull:false
    },
    authicon: {
        type: Sequelize.STRING(250),
        allowNull:false
    },
    parentid: {
        type: Sequelize.STRING(30),
        allowNull:false
    },
    authcomment:{
        type: Sequelize.STRING(250),
        allowNull:false
    },

    authurl: {
        type: Sequelize.STRING(250),
        allowNull:false
    },

    status: {
        type: Sequelize.CHAR(1),
        allowNull:false
    },
    sortid: {
        type: Sequelize.CHAR(4),
        allowNull:false
    },
    authflag: {
        type: Sequelize.CHAR(1),
        allowNull:false
    },
}, {
    timestamps: true,
    createdAt:false,
    updatedAt:'updatetime',
    charset: 'utf8',
    collate: 'utf8_general_ci',
    freezeTableName: true // Model 对应的表名将与model名相同
});


//auth.sync()
module.exports = auth;