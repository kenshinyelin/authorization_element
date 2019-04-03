/**
 * Created by Administrator on 2017/3/21.
 * role Model
 */
let DbInit = require('./DbInit');
let sequelize = DbInit.sequelize;
let Sequelize=DbInit.seqobj;
let role = sequelize.define('role', {

    roleid: {
        type: Sequelize.STRING(30),
        allowNull:false
    },
    rolename: {
        type: Sequelize.STRING(50),
        primaryKey:true,
        allowNull:false
    },
    comment:{
        type: Sequelize.STRING(100),
        allowNull:false
    }

}, {
    createdAt: 'creattime',
    updatedAt:'updatetime',
    charset: 'utf8',
    collate: 'utf8_general_ci',
    freezeTableName: true // Model 对应的表名将与model名相同
});

//role.sync()

module.exports = role;