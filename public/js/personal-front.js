$(function () {

  layui.use(['layer'], function () {
    var layer = layui.layer;
    var menu1 = '<li><a href="/mine/user_center">首页</a></li>' +
      '<li><a href="/mine/modify_info">会员申请</a></li>' +
      '<li><a href="/mine/online_payment">在线缴费</a></li>' +
      '<li><a href="/mine/conference_training">会议与培训</a></li>' +
      '<li><a href="/mine/modify_pwd">修改密码</a></li>';

    var menu2 = '<li><a href="/mine/user_center">首页</a></li>' +
      '<li><a href="/mine/modify_info">修改个人信息</a></li>' +
      '<li><a href="/mine/online_payment">在线缴费</a></li>' +
      '<li><a href="/mine/download_vipcard">下载会员证和确认函</a></li>' +
      '<li><a href="/mine/conference_training">会议与培训</a></li>' +
      '<li><a href="/mine/modify_pwd">修改密码</a></li>';

    var url = window.location.pathname; //根据获取到的路径去添加左边菜单选中状态

    //1.发送请求,查询会员表,确认是否为会员
    $.ajax({
      url: '/vip/getvipinfo',
      type: 'post',
      data: {
        uuid: sessionStorage.getItem('token')
      },
      success: function (data) {
        if (data.code == 0) {
          if (data.data.cardstatus == 6 || data.data.cardstatus == 7) {
            // 只有是正常缴费的会员或者是老会员才渲染菜单2
            $('.left-tab ul').html(menu2).find('a[href="' + url + '"]').parent().addClass('this')
            if (url == '/mine/meeting_signup') {
              $('.left-tab ul').find('a[href="/mine/conference_training"]').parent().addClass('this')
            }
            $('.right .position a:last').text($('.left-tab ul .this').text())
          } else {
            // 渲染菜单1
            $('.left-tab ul').html(menu1).find('a[href="' + url + '"]').parent().addClass('this')
            $('.right .position a:last').text($('.left-tab ul .this').text())
            if (url == '/mine/meeting_signup') {
              $('.left-tab ul').find('a[href="/mine/conference_training"]').parent().addClass('this')
              $('.right .position a:last').text('报名')
            }
          }

        } else {
          layer.msg(data.message)
        }
      },
      error: function (err) {
        layer.msg('请求网络失败,错误编码: ' + err.status)
        throw err
      }
    })

  })
})