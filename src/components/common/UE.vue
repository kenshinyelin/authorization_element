<template>
    <div class="ueditor-box">
        <script :id="randomId" type="text/plain"></script>
    </div>
</template>

<script>
  export default {
    name: "UE",
    props: {  //接收传进来的配置
      defaultMsg: {
        default: '',
        type: String
      },
      config: {
        initialFrameWidth: '100%',
        initialFrameHeight: 300,
        type: Object
      }
    },
    data () {
      return {
        //每个编辑器生成不同的id,以防止冲突
        randomId: 'editor_' + (Math.random() * 100000000000000000),
        //编辑器实例
        instance: null
      }
    },
    mounted() {
      this.initEditor()
    },
    methods: {
      initEditor() {  // 初始化编辑器
        this.$nextTick(() => {
          this.instance = UE.getEditor(this.randomId, this.config);
          // 绑定事件，当 UEditor 初始化完成后，将编辑器实例通过自定义的 ready 事件交出去
          this.instance.addListener("ready", () => {
            this.instance.setContent(this.defaultMsg); // 确保UE加载完成后，放入内容。
            this.$emit('ready', this.instance);
          });
        })
      },
      getUEContent() { // 获取内容方法
        return this.instance.getContent()
      },
      setUEContent(html) { // 设置内容方法
        return this.instance.setContent(html)
      }
    },
    destroyed() {
      // 组件销毁的时候，要销毁 UEditor 实例
      if (this.instance !== null && this.instance.destroy) {
        this.instance.destroy();
      }
    }
  }
</script>

<style scoped>
    .ueditor-box{
        line-height: normal!important;
    }
</style>