// $.getUrlParam = function (name) {
//     var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
//     var r = window.location.search.substr(1).match(reg);
//     if (r != null) return unescape(r[2]); return null;
// }
var user = document.cookie.split(";")[0].split("=")[1];
var nowModel = document.cookie.split(";")[2].split("=")[1];

//Vue只用了简单的数据绑定
var contentVue = new Vue({
    el: "#content",//这里的“contentVue”绑定的是相应Html文件中id为“content”的元素及子元素
    data: {
        items: [],//绑定id为“content”的子元素中的items，这里是个数组。要查看相应的html文件
        nowModel: nowModel,
    }
})

$(function () {//页面加载之后马上执行函数
    queryModelList();
})

function queryModelList() {
    $.ajax({
        url: "../queryModelList.jsp",//请求的jsp文件
        type: "GET",
        data: {
            userID: user,
        },
        success: function (res) {
            console.log(res);
            var data = res.split("*")[1].split("~");//后台返回后是个字符串，这里分割后台返回的字符串，获取有效数据填充到data
            for (let i = 0; i < data.length; i++) {//这里进行数据的填充，将数据填入contentVue.items数组 可以之江反应到页面上
                contentVue.items.push({ "name": data[i] });
            }
            console.log(data)
            if (data[0] == 0) {
                alert("此设备还未有自定义模式，请添加");
            }
        }
    })
}

function bianji(e) {
    var word = $(e).attr("value");//获取相关元素的value属性值。这里需要结合html文件来看，相应html文件中插入了“bianji()”函数
    word = escape(word);//对字符进行编码，因为用户输入里面可能含有中文字符
    window.location.href = "pattern_edit.html?word=" + word;//页面跳转
}

function deleteModel(e) {
    var word = $(e).attr("value");//获取相关元素的value属性值。这里需要结合html文件来看，相应html文件中插入了“bianji()”函数

    $.ajax({
        url: "../deleteModel.jsp",
        type: "GET",
        data: {
            word: word,
            userID: user,
        },
        success: function (res) {
            console.log(res);
            var data = res.split("*")[1];
            if (data == "0") {
                alert("删除模式成功！");
                nowModel = escape(nowModel);//对nowModel进行编码
                window.location.href = "planting_pattern.html?";
            }
        }
    })
}