const express = require('express'),
  router = express.Router(),
  gps_role = require("../model/role"),
  gps_roleauth = require("../model/roleauth"),
  async = require('async'),
  util = require("../util/util");

let reObj = util.reObj;
let randomString = util.randomString;


/**
 * @function 增加角色
 * @author yelin
 * @date 2017-11-9
 * @param roleid,orgtype,appid,rolename,comment
 */
router.post('/add', (req, res) => {
  let roleid = req.body.roleid || randomString(6)
  let rolename = req.body.rolename || ''
  let comment = req.body.comment || ''
  let params = {
    roleid: roleid,
    rolename: rolename,
    comment: comment
  }
  if (rolename) {
    gps_role.findOrCreate({where: {rolename: rolename}, defaults: params}).then(record => {
      if (record[1]) {
        res.send(reObj(0, '新增角色成功', record[0]))
      } else {
        res.send(reObj(-1, '角色已存在'))
      }
    }).catch(err => {
      res.send(reObj(-1, '新增角色失败', err))
    });
  } else {
    res.send(reObj(-1, 'roleid can not be null,empty'))
  }

})

/**
 * @function 修改角色信息
 * @author yelin
 * @date 2017-11-9
 * @param roleid,appid,orgtype,rolename,,comment
 */
router.post('/edit',  (req, res)=>  {
  let roleid = req.body.roleid
  let rolename = req.body.rolename
  let comment = req.body.comment
  let params = {
    roleid: roleid,
  }

  let updateparams = {
    rolename: rolename,
    comment: comment
  }
  //去掉空的属性
  for (var key of Object.keys(updateparams)) {
    if (!updateparams[key])
      delete updateparams[key]
  }
  if (roleid) {
    gps_role.update(updateparams, {where: params}).then(record => {
      if (record > 0) {
        res.send(reObj(0, '更新成功', record))
      } else {
        res.send(reObj(-1, '无效角色', []))
      }
    }).catch(err => {
      res.send(reObj(-1, '更新失败', err))
    });
  } else {
    res.send(reObj(-1, '角色名称不能为空'))
  }
})

/**
 * @function 删除角色数据
 * @author yelin
 * @date 2017-11-9
 * @param roleid
 */
router.post('/del', (req, res) =>  {
  let roleid = req.body.roleid
  let params = {
    roleid: roleid
  }
  if (roleid) {
    gps_role.destroy({where: params}).then(record => {
      if (record > 0) {
        res.send(reObj(0, 'del success', []))
      } else {
        res.send(reObj(-1, 'del failed or record not exist', []))
      }
    }).catch(err => {
      res.send(reObj(-1, 'del error', err))
    });
  } else {
    res.send(reObj(-1, 'roleid can not be null'))
  }
})


/**
 * @function 获取所有角色数据
 * @author Eric
 * @date 2018-05-28
 * @param orgtype,appid （可选）
 */
router.post('/getrolelist',(req, res)=>  {
  let params = {}
  let pagerow = parseInt(req.body.pagesize)
  let page = parseInt(req.body.skipnum)
  //对页码进行容错
  if (pagerow > 999) {
    pagerow = 999
  }
  if (page == 0) {
    page = 1
  }
  params.limit = pagerow || 100;
  params.offset = parseInt(pagerow * (page - 1)) || 0;
  params.order = "creattime DESC";

  gps_role.findAndCountAll(params).then(record => {
    res.send(reObj(0, '查询成功!', record.rows, record.count))
  }).catch(err => {
    console.error('Unable to connect to the database:', err);
    res.send(reObj(-1, '查询失败', err))
  });

})

/**
 * @function 获取角色数据
 * @author siwei
 * @date 2018-08-08
 * @param roleid
 */
router.post('/getroleinfo', (req, res)=>  {
  let params = {
    roleid: req.body.roleid
  }
  gps_role.findOne({where: params}).then(record => {
    if (record) {
      res.send(reObj(0, '获取角色信息成功', record))
    } else {
      res.send(reObj(-1, '获取角色信息失败或此记录不存在', {}))
    }
  }).catch(err => {
    res.send(reObj(-1, '获取角色信息失败', err))
  });
})

/**
 * @function 获取角色权限数据
 * @author Eric
 * @date 2018-05-28
 * @param roleid
 */

router.post('/getroleauthlist',  (req, res)=>  {
  let roleid = req.body.roleid
  let params = {
    roleid: roleid
  }
  if (roleid) {

    gps_roleauth.findAll({where: params}).then(record => {
      if (record.length > 0) {
        res.send(reObj(0, '获取角色权限数据成功', record))
      } else {
        res.send(reObj(-1, '该角色暂无权限或此记录不存在', record))
      }
    }).catch(err => {
      res.send(reObj(-1, '获取角色权限数据失败', err))
    })
  } else {
    res.send(reObj(-1, 'roleid不能为空'))
  }
})


/**
 * @function 配置角色权限数据（先删除后增加）
 * @author Eric
 * @date 2018-07-06
 * @param optype,roleid,authdata:[{authid:'',authid:'',...}]
 */
router.post('/setroleauth',  (req, res) => {
    let roleid = req.body.roleid
    let authdata = req.body.authdata;
    let delparam = {roleid: roleid}
    if (typeof authdata === 'string')
        authdata = JSON.parse(authdata)

    gps_roleauth.destroy({where: delparam}).then(results => {
        async.map(authdata, (item, callback) => {
            let authid = item.authid
            let params = {
                roleid: roleid,
                authid: authid,
            }

            gps_roleauth.create(params).then(addrecord => {
                callback(null, reObj(0, 'del gps_roleauth success', addrecord))
            }).catch(err => {
                callback(null, reObj(-1, 'del gps_roleauth error', err));
            });
        }, (err, results) => {
            if (!err) {
                res.send(results)
            } else {
                res.send(reObj(-1, 'del gps_userrole faild', err))
            }
        })
    }).catch(err => {
        res.send(reObj(-1, 'del error', err))
    })

})
module.exports = router;
