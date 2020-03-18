// $.getUrlParam = function (name) {
//     var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
//     var r = window.location.search.substr(1).match(reg);
//     if (r != null) return unescape(r[2]); return null;
// }

// //得到user参数
// var user = $.getUrlParam("user");
var user = document.cookie.split(";")[0].split("=")[1];

var contentVue = new Vue({
    el: "#contents",
    data: {
        items: [{ name: "加载失败" }],
        input: "",
    }
})

$(function () {
    queryDiviceNum();
})

//查询渲染数据
function queryDiviceNum() {
    contentVue.items = [];
    $.ajax({
        url: "../queryDiviceNum.jsp",
        type: "GET",
        data: {
            userID: user,
        },
        success: function (res) {
            //console.log(res);
            var data = res.split("*")[1].split("~");
            for (let i = 0; i < data.length; i++) {
                contentVue.items.push({ "name": data[i] });
            }
        }
    })
}

//新增设备id
function add() {
    var reg = /^[\w\u4e00-\u9fa5]{8}$/;
    if(reg.test(contentVue.input)){
      $.ajax({
        url: "../addDivice.jsp",
        type: "GET",
        data: {
            userID: user,
            input: contentVue.input,
        },
        success: function (res) {
            console.log(res);
            var data=res.split("*")[1];
            if(data=="0"){
                alert("新增设备成功！");
                queryDiviceNum();
                contentVue.input="";
            }
        }
    })  
    }else{
        alert("请输入8位字符！");
        contentVue.input="";
    }
    
}

function deleteDivice(e){
    var deleteId = $(e).attr("value");
    $.ajax({
        url:"../deleteDivice.jsp",
        type:"GET",
        data:{
            userId:user,
            deleteId:deleteId,
        },
        success:function(res){
            var data=res.split("*")[1];
            if(data=="0"){
                alert("删除成功");
                queryDiviceNum();
                contentVue.input="";
            }
        }
    })
}