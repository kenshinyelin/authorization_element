import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)


const routes= [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name:'login',
    component: resolve => require(['@/components/page/Login.vue'], resolve)
  },
  {
    path: '/home',
    component: resolve => require(['@/components/common/Home'], resolve),
    children:[

      {
        path: '/readme', //默认显示
        name:'readme',
        component: resolve => require(['@/components/page/Readme'], resolve)
      },
        {
            path: '/noauth', //默认显示
            name:'noauth',
            component: resolve => require(['@/components/page/noAuth'], resolve)
        },
      {
        path: '/role',
        name:'role',
        component: resolve => require(['@/components/page/role'], resolve)
      },
      {
        path: '/auth',
        name:'auth',
        component: resolve => require(['@/components/page/auth'], resolve)
      },
      {
        path: '/category',
        name:'category',
        component: resolve => require(['@/components/page/category'], resolve)
      },
      {
        path: '/users',
        name:'users',
        component: resolve => require(['@/components/page/users'], resolve)
      },
      {
        path: '/users_add',
        name:'users_add',
        component: resolve => require(['@/components/page/usersEdit'], resolve)
      },
      {
        path: '/users_edit',
        name:'users_edit',
        component: resolve => require(['@/components/page/usersEdit'], resolve)
      },

      {
          path: '/slide',
          name:'slide',
          component: resolve => require(['@/components/page/slide'], resolve)
      }
    ]
  }
]

const router = new Router({
  routes // （缩写）相当于 routes: routes
})


router.beforeEach((to, from, next) => {
    if(sessionStorage.getItem('token'))//如果token不存在，说明用户没有登录成功
    {
      let authlist=sessionStorage.getItem('authlist')
        authlist+='/readme'//添加一个默认的访问路由
        if(to.path=='/login'){
            next(from.path);
        }
        else if(authlist.includes(to.path))//
        { //如果访问的路由在访问路由列表里,说明有该权限。注意，基础菜单的路由必须和功能能菜单路由一致
            next()
        }
        else {
          if(to.path=='/noauth')//  如果
          {
            next()
          }
          else
          {
              next({name:'noauth'});
          }

        }
    }
    else
    {
        if(to.path=='/login'){//如果是登录页面路径，就直接next()
            next();
        }else{//不然就跳转到登录；
            next('/login');
        }
    }


})
export default router



