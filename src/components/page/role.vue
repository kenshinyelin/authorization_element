<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 系统管理</el-breadcrumb-item>
                <el-breadcrumb-item>角色管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="handle-box">

            <el-button type="primary" size="mini" icon="" @click="addFormVisible = true">添加角色</el-button>

        </div>
        <el-table size="mini" :data="tableData" border style="width: 100%">


            <el-table-column prop="roleid" label="角色编码" width="" v-if=false></el-table-column>
            <el-table-column prop="rolename" label="角色名称" width=""></el-table-column>
            <el-table-column prop="comment" label="角色备注" width=""></el-table-column>


            <el-table-column label="操作" width="300">
                <template slot-scope="scope">
                    <el-button @click="edit(scope.$index, scope.row)"
                               size="mini">编辑
                    </el-button>
                    <el-button @click="authorize(scope.$index, scope.row)"
                               size="mini">授权
                    </el-button>
                    <el-button @click="deleteRow(scope.row.roleid)" type="danger"
                               size="mini">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
        <!--分页-->
        <div class="pagination" style="float: left">
            <el-pagination small
                           @current-change="handleCurrentChange" background
                           layout="total, prev, pager, next, jumper"
                           :total="totalPage">
            </el-pagination>
        </div>

        <!--新增弹窗-->
        <el-dialog title="新增角色" :visible.sync="addFormVisible" size="tiny">
            <el-form :model="form" size="mini" :rules="rules" ref="ruleForm">
                <el-form-item label="角色名称:" :label-width="formLabelWidth" prop="rolename">
                    <el-input v-model="form.rolename" placeholder="请角色名称" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="角色描述:" :label-width="formLabelWidth" prop="comment">
                    <el-input v-model="form.comment" placeholder="请角色描述" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="add('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 编辑弹窗 -->
        <el-dialog title="编辑角色" size="tiny" :visible.sync="editFormVisible">
            <el-form :model="form" size="mini" :rules="rules" ref="ruleForm">
                <el-form-item label="角色名称:" :label-width="formLabelWidth" prop="rolename">
                    <el-input v-model="form.rolename" placeholder="请角色名称" auto-complete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="角色描述:" :label-width="formLabelWidth" prop="rolecoment">
                    <el-input v-model="form.comment" placeholder="请角色描述" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="editFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="editConfirm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>

        <!-- 授权弹窗 -->
        <el-dialog :title="authorizeTitle" size="tiny" :visible.sync="authorizeFormVisible" @close="resetChecked">
            <el-tree :data="items" :props="defaultProps" :default-checked-keys="checkedkeys" default-expand-all
                     show-checkbox ref="tree" node-key="authid">
    <span class="custom-tree-node" slot-scope="{ node, data }" style="float: right">
      <span>{{ node.label }}</span>
      </span>
            </el-tree>
            <div slot="footer" class="dialog-footer">
                <el-button @click="authorizeFormVisible = false;resetChecked">取 消</el-button>
                <el-button type="primary" @click="authorizeConfirm">确 定</el-button>
            </div>
        </el-dialog>
    </div>

</template>

<script>

  export default {
    data: function () {
      return {
        items: [],
        checkedkeys: [],
        defaultProps: {
          children: 'children',
          label: 'authname'
        },
        authorizeTitle: '分配权限',
        roleid: '',
        tableData: [],
        addFormVisible: false,
        editFormVisible: false,
        authorizeFormVisible: false,
        formLabelWidth: '120px',
        pagination: 1,
        cur_page: 1,
        pagerow: 10,
        totalPage: 1,
        form: {
          roleid: '',
          rolename: '',
          comment: ''
        },
        rules: {
          rolename: [
            {required: true, message: '请输入名称', trigger: 'blur'}
          ],
          comment: [
            {required: true, message: '请输入描述', trigger: 'blur'}
          ]
        }
      }
    },

    created() {
      this.findrecord(),//初始化角色
        this.findauthlist()//初始化权限
    },
    methods: {
      resetForm() {
        this.form = {
          roleid: '',
          rolename: '',
          comment: ''
        }
      },
      /*添加*/
      add(ruleForm) {
        this.$refs[ruleForm].validate((valid) => {
          if (valid) {
            this.$axios.post('/role/add', this.form).then(res => {
              if (res.data.code == 0) {
                this.addFormVisible = false;
                this.$message.info(res.data.message);
                this.findrecord()
                this.resetForm()
              }
              else {
                this.$message.error(res.data.message);
              }
            }).catch(err => {
              this.$message.error('请求服务器失败，请稍后再试！');
            })
          } else {
            this.$message({
              message: '信息有误或者不完整，请重试。',
              type: 'warning'
            });
            return false;
          }
        });
      },
      /*弹出编辑窗*/
      edit(index, row) {
        this.editFormVisible = true;
        this.form.roleid = row.roleid;
        this.form.rolename = row.rolename;
        this.form.comment = row.comment;
      },
      /*弹出授权窗*/
      authorize(index, row) {
        const self = this
        this.roleid = row.roleid
        this.authorizeFormVisible = true;
        this.authorizeTitle = '权限分配--' + row.rolename
        self.$axios.post('/role/getroleauthlist', {roleid: this.roleid})
          .then(function (response) {
            let keys = []
            if (response.data.data.length > 0) {
              for (let item of response.data.data) {
                keys.push(item.authid)
              }
              self.setChecked(keys)
            }
            else {
              self.resetChecked()
            }
          })
          .catch(function (error) {
            console.log(error);
          });
      },
      /*编辑确认*/
      editConfirm(ruleForm) {
        this.$refs[ruleForm].validate((valid) => {
          if (valid) {
            let url = '/role/edit';
            this.$axios.post(url, this.form).then((res) => {
              if (res.data.code == 0) {
                this.editFormVisible = false;
                this.$message.info(res.data.message);
                this.findrecord()
                this.resetForm()
              } else {
                this.$message.error(res.data.message);
              }
            }).catch((err) => {
              this.$message.error('请求服务器失败，请稍后再试！');
            })
          } else {
            return false;
          }
        })
      },
      /*删除*/
      deleteRow(rowid) {
        this.$confirm("确定删除此记录吗?", "提示", {type: 'warning'})
          .then(() => {
            this.$axios.post('/role/del', {roleid: rowid})
              .then((res) => {
                if (res.data.code == 0) {
                  this.$message.info('您已成功删除该记录!');
                  this.findrecord()
                } else {
                  this.$message.error(res.data.message);
                }
              }).catch(err => {
              this.$message.error('请求服务器失败，请稍后再试！');
            })
          }).catch(() => {
          this.$message.info('已取消该删除操作!');
        })
      },

      //分页
      handleCurrentChange(val) {
        this.cur_page = val;
        this.findrecord()
      },
      setChecked(keys) {
        this.$refs.tree.setCheckedKeys(keys);
      },
      resetChecked() {
        this.$refs.tree.setCheckedKeys([]);

      },
        /*查询所有角色*/
      findrecord() {
        let self = this
        let params = {
          skipnum: self.cur_page,
          pagesize: self.pagerow
        }

        self.$axios.post('/role/getrolelist', {skipnum:self.pagerow*(self.cur_page-1),pagesize:self.pagerow})
          .then(function (response) {
            self.tableData = response.data.data
            self.totalPage = response.data.rowcount
          })
          .catch(function (error) {
            console.log(error);
          });

      },
        /*查询所有权限*/
      findauthlist() {
        const self = this
        this.$axios.post('/auth/getauthlist', {parentid: 'ROOT'})
          .then(function (response) {
            self.items = response.data.data
          })
          .catch(function (error) {
            console.log(error);
          });
      },
        /*授权确认*/
      authorizeConfirm() {
        let nodes = this.$refs.tree.getCheckedNodes(true)
        let roleid = this.roleid
        let authid = [];
        for (let item of nodes) {
          authid.push({authid: item.authid})
        }
        let self = this
        let params = {
          roleid: roleid,
          authdata: authid
        }
        self.authorizeFormVisible = false;
        self.$axios.post('/role/setroleauth', params)
          .then(function (response) {

            self.$message.info('授权成功！');
          })
          .catch(function (error) {
            console.log(error);
          });
      }

    }
  }
</script>

<style scoped>
    .handle-box {
        margin-bottom: 20px;
    }
</style>
