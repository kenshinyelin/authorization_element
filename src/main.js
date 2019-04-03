// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.



//import Vue from 'vue'  //can import from cdn
//import ElementUI from 'element-ui' //can import from cdn
//import 'element-ui/lib/theme-chalk/index.css' //can import from cdn
import App from './App.vue'
import router from './router'
import axios from './axio';

//import axios from 'axios' //can import from cdn
import moment from 'moment';
// import fullCalendar from 'vue-fullcalendar'
import config from '../config/rootConfig.js'
//import '../static/iconfont/iconfont.css';
// import '../static/lib/ztree/css/zTreeStyle/zTreeStyle.css'
// import '../static/lib/ztree/jquery.ztree.all.min.js'

//time format filter
Vue.filter('time', function (value, formatString) {
  if(value){
    formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
    return moment(value).format(formatString);
  }else {
    return ''
  }
})
//Vue.use(ElementUI) //can import from cdn
// Vue.component('full-calendar', fullCalendar)
Vue.prototype.$axios = axios;
Vue.prototype.$moment = moment;
Vue.prototype.$config = config;
var app=new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
