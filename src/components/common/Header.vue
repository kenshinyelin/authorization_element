<template>
    <div class="header">
        <div class="logo">
            <img src="../../assets/logo_gpa.png" alt="">
        </div>
        <div class="user-info">
            <el-dropdown trigger="hover" @command="handleCommand" placement="bottom">
                <span class="el-dropdown-link">
                  <!--   <img class="user-logo" src="../../../static/img/img.jpg"> -->
                    {{username}}
                </span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item command="loginout">退出</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </div>
    </div>
</template>
<script>
    export default {
        data() {
            return {
                name: 'Eric Ye'
            }
        },
        computed:{
            username(){
                let username = sessionStorage.getItem('ms_username');
                return username ? username : this.name;
            }
        },
        methods:{
            handleCommand(command) {
                if(command == 'loginout'){
                  sessionStorage.removeItem('token')
                    this.$router.push('/');
                }
            }
        }
    }
</script>
<style scoped>
    .header {
        position: relative;
        box-sizing: border-box;
        width: 100%;
        height: 70px;
        font-size: 22px;
        line-height: 70px;
        color: #fff;
        background-color: #3f596f;
    }
    .header .logo{
        float: left;
        width:250px;
        height: 70px;
        text-align: center;
    }
    .logo img{
        width: 100%;
        height: 100%;
        display: block;
    }
    .user-info {
        float: right;
        padding-right: 30px;
        font-size: 16px;
        color: #fff;
    }
    .user-info .el-dropdown-link{
        position: relative;
        display: inline-block;
        padding-left: 25px;
        padding-right: 25px;
        color: #fff;
        cursor: pointer;
        vertical-align: middle;
    }
    .user-info .user-logo{
        position: absolute;
        left:0;
        top:15px;
        width:40px;
        height:40px;
        border-radius: 50%;
    }
    .el-dropdown-menu__item{
        text-align: center;
    }
</style>
