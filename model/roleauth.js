/**
 * Created by Administrator on 2017/3/21.
 * role Model
 */
let DbInit = require('./DbInit');
let sequelize = DbInit.sequelize;
let Sequelize=DbInit.seqobj;
let roleauth = sequelize.define('roleauth', {

    roleid: {
        type: Sequelize.STRING(30),
        primaryKey:true,
        allowNull:false
    },
    authid: {
        type: Sequelize.STRING(30),
        allowNull:false
    }

}, {
    timestamps: true,
    createdAt:false,
    updatedAt:'updatetime',
    charset: 'utf8',
    collate: 'utf8_general_ci',
    freezeTableName: true // Model 对应的表名将与model名相同
});

//roleauth.sync()

module.exports = roleauth;