const express = require('express'),
  router = express.Router(),
  _ = require('lodash'),
  util = require("../util/util"),
  gps_auth = require("../model/auth"),
  gps_roleauth = require("../model/roleauth");

let reObj = util.reObj;
let randomString = util.randomString;
let recursion = util.recursion;



/**
 * @function 增加权限
 * @author yelin
 * @modified by maxing
 * @date 2017-05-25
 * @param authid,authname,authtype,authicon,parentid,authappid,authurl,authdata,authcomment,status
 * @取消authappid的验证
 */
router.post('/add', (req, res) => {
  let ran = randomString(8);
  let authid = ran;
  let authname = req.body.authname
  let authicon = req.body.authicon || ''
  let parentid = req.body.parentid || ran

  let authurl = req.body.authurl
  let authtype = req.body.authtype

  let authcomment = req.body.authcomment
  let status = req.body.status
  let sortid = req.body.sortid
  let authflag = req.body.authflag
  let params = {
    authid: authid,
    authname: authname,
    authicon: authicon,
    parentid: parentid,
    authurl: authurl,
    authtype: authtype,
    authcomment: authcomment,
    status: status,
    sortid: sortid,
    authflag: authflag
  }
  let queryparam = {
    authid: authid
  }
  if (authid && authname && parentid && authurl && authtype && authcomment && status && authflag) {

    if (authid.length > 30 || authname.length > 50 || authicon.length > 250 || parentid.length > 30 || authurl.length > 250 || authtype.length > 1 || authcomment.length > 250 || status.length > 1) {

      res.send(reObj(-1, '请求参数长度超出限制'))
    } else {
      gps_auth.findOrCreate({where: queryparam, defaults: params}).then(record => {
        if (record[1]) {
          res.send(reObj(0, '添加权限成功', record[0]))
        } else {
          res.send(reObj(-1, '权限已存在'))
        }
      }).catch(err => {
        res.send(reObj(-1, '添加权限失败', err))
      });
    }
  } else {
    res.send(reObj(-1, 'authid,authname,parentid,authurl,authtype,,authcomment,status,sortid,authflag不能为空'))
  }
})

/**
 * @function 修改权限信息
 * @author yelin
 * @date 2017-05-26
 * @param authid,authname,authtype,authicon,parentid,authappid,authurl,authdata,authcomment,status
 */
router.post('/edit', (req, res) => {
  let authid = req.body.authid
  let authname = req.body.authname || ''
  let authicon = req.body.authicon || ''
  let parentid = req.body.parentid || ''

  let authtype = req.body.authtype || ''
  let authcomment = req.body.authcomment || ''
  let status = req.body.status || ''
  let sortid = req.body.sortid || ''
  let authurl = req.body.authurl || ''
  let authflag = req.body.authflag || ''
  let params = {
    authid: authid
  }
  let updateparams = {
    authname: authname,
    authicon: authicon,
    parentid: parentid,
    authurl: authurl,
    authtype: authtype,
    authcomment: authcomment,
    status: status,
    sortid: sortid,
    authflag: authflag
  }

  //去掉空的属性
  for (var key of Object.keys(updateparams)) {
    if (!updateparams[key])
      delete updateparams[key]
  }

  if (authname.length > 50 || authicon.length > 250 || parentid.length > 30 || authurl.length > 250 || authtype.length > 1 || authcomment.length > 250 || status.length > 1 || sortid.length > 4) {
    res.send(reObj(-1, '请求参数长度超出限制'))
  } else {

    gps_auth.update(updateparams, {where: params}).then(record => {
      if (record[0] > 0) {
        res.send(reObj(0, '修改权限成功', record[0]))
      } else {
        res.send(reObj(-1, '无效的权限id', []))
      }
    }).catch(err => {
      res.send(reObj(-1, '修改权限失败', err))
    });

  }
})

/**
 * @function 删除权限数据
 * @author yelin
 * @date 2017-05-25
 * @param authid
 */
router.post('/del', (req, res) => {
  let params = {
    authid: req.body.authid || ''
  }
  gps_auth.destroy({where: params}).then(record => {
    if (record > 0) {
      res.send(reObj(0, '删除权限成功', record))
    } else {
      res.send(reObj(-1, '删除权限失败或此记录不存在', record))
    }
  }).catch(err => {
    res.send(reObj(-1, '删除权限失败', err))
  });
})


/**
 * @function 获取权限数据（下属，递归调用）
 * @author yelin
 * @date 2017-06-5
 * @param parentid
 */
router.post('/getauthlist', (req, res) => {
  let parentid = req.body.parentid || ''
  let authtype = req.body.authtype || ''
  let params = {}
  if (authtype) {
    params.authtype = authtype
  }

  gps_auth.findAll({
    order: 'sortid ASC',
    where: params
  }).then(record => {
    if (record.length > 0) {
      let arr = []
      let serilize_res = JSON.parse(JSON.stringify(record))
      for (i in serilize_res) {
        arr.push(serilize_res[i]);
      }
      let tree = recursion(arr, parentid,'authid');
      res.send(reObj(0, '获取权限列表成功', tree))
    } else {
      res.send(reObj(-1, '获取权限列表失败或记录不存在', []))
    }
  }).catch(err => {
    res.send(reObj(-1, '获取权限列表失败', err))
  });
})

/**
 * @function 获取左侧菜单
 * @author yelin
 * @date 2017-06-5
 * @param parentid
 * 逻辑，由于获取的数据中，可能会不包含某叶子节点的根节点，导致在菜单中无法正常显示，需要特殊处理
 * 实现的逻辑是获取角色权限列表的所有根节点，然后与权限列表的数据合并，去掉重复的根节点数据
 * 由于树的结构比较多层，所以会进行两次查询根节点，然后将叶子节点和根节点合并去重
 */
router.post('/getSiderbar', (req, res) => {
  let parentid = req.body.parentid || ''
  let authtype = req.body.authtype || ''
  let roleid = req.body.roleid || ''
  let params = {}
  if (authtype) {
    params.authtype = authtype
  }



  gps_auth.findAll({
    order: 'sortid ASC',
    where: params
  }).then(record => {
    if (record.length > 0) {
      let arr = []
      let serilize_res = JSON.parse(JSON.stringify(record))//重新序列化查询结果

      gps_roleauth.findAll({
        where: {roleid: roleid}
      }).then(rolerecord => {

        let originrolelist = JSON.parse(JSON.stringify(rolerecord))
        let orginnroleauthlist = [] //角色的初始权限信息
        let orginparentlist = []//初始的权限根节点信息
        //根据角色的权限id获取对应的权限并赋值给rest
        for (const item of serilize_res) {
          for (const useritem of originrolelist) {
            if (item.authid == useritem.authid) {
              orginnroleauthlist.push(item)
              if (item.parentid !== 'ROOT') {
                //查询每个权限的parentid并赋值到parentidlist
                orginparentlist.push(item.parentid)
              }
            }
          }
        }
        let orginuniqlist = _.uniq(orginparentlist)//去掉重复的parentid
        let userrolelist = []//最新的角色权限，包含parentid信息的权限
        let newroleauthlist = [] //角色新的权限信息
        for (i in orginnroleauthlist) {
          orginuniqlist.push(orginnroleauthlist[i].authid)//节点合并
        }
        orginuniqlist = _.uniq(orginuniqlist)//去掉重复的节点

        for (i in orginuniqlist) {
          userrolelist.push({"roleid": roleid, "authid": orginuniqlist[i]})
        }
        /***start 对orginuniqlist再一次查询其根节点，然后与其合并去重**/
        let newparentlist = []//权限的根节点信息

        for (const item of serilize_res) {
          for (const useritem of userrolelist) {
            if (item.authid == useritem.authid) {
              newroleauthlist.push(item)
              if (item.parentid !== 'ROOT') {
               // console.log('item:' + JSON.stringify(item))
                //查询每个权限的parentid并赋值到parentidlist
                orginparentlist.push(item.parentid)
              }
            }
          }
        }
        let neworginuniqlist = _.uniq(orginparentlist)//去掉重复的parentid
        let newuserrolelist = []//最新的角色权限，包含parentid的权限
        for (i in newroleauthlist) {
          neworginuniqlist.push(newroleauthlist[i].authid)//与根节点合并
        }
        neworginuniqlist = _.uniq(neworginuniqlist)//去掉重复的根节点

        for (i in neworginuniqlist) {
          newuserrolelist.push({"roleid": roleid, "authid": neworginuniqlist[i]})
        }

        /*** end对orginuniqlist再一次查询其根节点，然后与其合并去重**/
        //重新获取角色权限列表
        for (const item of serilize_res) {
          for (const userroleitem of newuserrolelist) {
            if (item.authid == userroleitem.authid) {
              arr.push(item)
            }
          }
        }
        let tree = recursion(arr, parentid,'authid');
        res.send(reObj(0, '获取左侧菜单成功', tree))
      })

    } else {
      res.send(reObj(-1, '获取左侧菜单失败或记录不存在', []))
    }
  }).catch(err => {
    res.send(reObj(-1, '获取左侧菜单失败', err))
  });
})


module.exports = router;
