/**
 * Created by Administrator on 2017/3/21.
 * 用户会员 Model
 */
let DbInit = require('./DbInit');
let sequelize = DbInit.sequelize;
let Sequelize = DbInit.seqobj;
let user = sequelize.define('user', {
  uuid: {
    type: Sequelize.STRING(40),
    primaryKey: true,
    allowNull: false
  },
  uname: {//用户名
    type: Sequelize.STRING(30),
    allowNull: false
  },
  utype: {//用户类型，即角色
    type: Sequelize.STRING(30),
    allowNull: false
  },
  name: {//姓名
    type: Sequelize.STRING(20),
    allowNull: true
  },
  unickname: {
    type: Sequelize.STRING(30),
    allowNull: true
  },
  valid: {
    type: Sequelize.CHAR(1),
    allowNull: true
  },


  upwd: {
    type: Sequelize.STRING(50),
    allowNull: false
  },
  ucomment: {
    type: Sequelize.STRING(100),
    allowNull: true
  },

  status: {
    type: Sequelize.CHAR(1),
    allowNull: true
  },
  uicon: {//用户图标
    type: Sequelize.STRING(60),
    allowNull: true
  },
  mail: {
    type: Sequelize.STRING(50),
    allowNull: true
  },
  phone: {//联系电话
    type: Sequelize.STRING(20),
    allowNull: true
  }
}, {
  timestamps: true,
  createdAt: 'creattime',
  updatedAt: 'updatetime',
  charset: 'utf8',
  collate: 'utf8_general_ci',
  freezeTableName: true // Model 对应的表名将与model名相同
});

user.sync()
module.exports = user;