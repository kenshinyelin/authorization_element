

// http request 拦截器
/*axios.interceptors.request.use(
    config => {
        console.log('request')
        return config;
    },
    err => {
        console.log('request err')
        return Promise.reject(err);
    });*/

// http response 拦截器/
axios.interceptors.response.use(
    response => {
        //console.log('response'+JSON.stringify(response))
        if(response.data==='expired') {
            sessionStorage.clear();
            window.location.href='/'

        }
        return response;
    },
    error => {
        console.log('response err')
    });
export default axios
