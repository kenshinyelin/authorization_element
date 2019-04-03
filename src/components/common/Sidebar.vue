<template>
    <div class="sidebar">
        <el-menu  class="el-menu-vertical-demo"  :default-openeds="openeds">
            <template v-for="item in items">
                <!-- <template v-if="item.subs">
                    <el-submenu :index="item.index">
                        <template slot="title"><i :class="item.icon"></i>{{ item.title }}</template>
                        <el-menu-item v-for="(subItem,i) in item.subs" :key="i" :index="subItem.index">{{ subItem.title }}
                        </el-menu-item>
                    </el-submenu>
                </template>
                <template v-else>
                    <el-menu-item :index="item.index">
                        <i :class="item.icon"></i>{{ item.title }}
                    </el-menu-item>
                </template> -->
                <template v-if="item.children">
                    <el-submenu :index="item.sortid">
                        <template slot="title"><i :class="item.authicon" class='iconfont'></i>{{ item.authname }}</template>
                        <el-menu-item v-for="(subItem,i) in item.children" :key="i" :index="subItem.authurl" @click="urlNav(subItem.authurl,subItem.authid)">
                        <i :class="subItem.authicon" class='iconfont'></i>{{ subItem.authname }}
                        </el-menu-item>
                    </el-submenu>
                </template>
                <template v-else>
                    <el-menu-item :index="item.sortid">
                        <i :class="item.authicon"></i>{{ item.authname }}
                    </el-menu-item>
                </template>
            </template>
        </el-menu>
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                items:[],
                openeds: [],//默认展开菜单
            }
        },
        methods:{
          urlNav(target,authid) {
            const url=target.split('/')[1]
              console.log('url:'+url)
            this.$router.push({name:url,params:{authid:authid}})
          },
        },
      mounted: function () {
        
      },
         beforeMount(){
             let utype = sessionStorage.getItem('utype');
           //获取菜单//
            const self=this
            this.$axios.post('/auth/getSiderbar', {authtype: '',parentid:'ROOT',roleid:utype})
              .then(function (response) {
                 // let authlist=response.data.data
                self.items = response.data.data
                  //设置默认展开子菜单
                  for(const item of self.items)
                  {
                      if(item.children)
                          self.openeds.push(item.sortid)
                  }

              })
              .catch(function (error) {
                console.log(error);
              });

        }

    }
</script>

<style scoped lang="scss">
  $color: #3f596f;
  .sidebar{
    display: block;
    position: absolute;
    width: 250px;
    left: 0;
    top: 70px;
    bottom:0;
    background: $color;
  }
  .sidebar > ul {
    height:100%;
    background: $color;
  }
  .el-submenu  /deep/ .el-menu{
      background-color: rgba(30, 30, 37, 0.3);
  }
  .el-menu-item:focus, .el-menu-item:hover,/deep/ .el-submenu__title:hover{
      background-color: #5f81cc;
  }
</style>
