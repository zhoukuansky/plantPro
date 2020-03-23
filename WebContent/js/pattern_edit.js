$.getUrlParam = function (name) {//获取跳转页面时，url中携带的参数函数，主要是通过js跳转页面
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

//得到user参数
var diviceID = $.getUrlParam("diviceID");//获取url中的diviceID
var word = $.getUrlParam("word");//获取url中的word
word = unescape(word);
var user = document.cookie.split(";")[0].split("=")[1];//获取网站cookie

var contentVue = new Vue({//这里的Vue有点绑定了html页面中id为“content”的元素。需要联系html进行解释。下面data中的数据在html中都能找到相应绑定
    el: "#content",
    data: {
        name: word,
        co2: "",
        PH: "",
        TDS: "",
        sun: "",
        water: "",
        waterHeight: "",
        temperature: "",
        humidity: "",
        cycle: "",
        sunTime:"",
        sterilize:"",
    }
})

$(function () {//页面加载之后马上执行函数
    queryModelInfo();
})

function queryModelInfo() {
    $.ajax({
        url: "../queryModelInfo.jsp",
        type: "GET",
        data: {
            word: word,
            userID: user,
        },
        success: function (res) {
            //console.log(res);
            var data = res.split("*")[1].split("~");
            console.log(data);
            //这里进行数据的填充，将数据填入相应绑定 然后反应到页面上 可以将之反应到页面上
            contentVue.co2 = data[0];
            contentVue.sun = data[1];
            contentVue.waterHeight = data[2];
            contentVue.temperature = data[3];
            contentVue.humidity = data[4];
            contentVue.TDS = data[5];
            contentVue.PH = data[6];
            contentVue.water = data[7];
            contentVue.cycle = data[8];
            contentVue.sunTime = data[9];
            contentVue.sterilize = data[10];
        }
    })
}

function update() {
    $.ajax({
        url: "../updateModel.jsp",
        type: "GET",
        data: {//将数据上传，通过contentVue的数据绑定获取页面数据
            word: word,
            userID: user,
            name:contentVue.name,
            co2: contentVue.co2,
            PH: contentVue.PH,
            TDS: contentVue.TDS,
            sun: contentVue.sun,
            water: contentVue.water,
            waterHeight: contentVue.waterHeight,
            temperature: contentVue.temperature,
            humidity: contentVue.humidity,
            cycle: contentVue.cycle,
            sunTime: contentVue.sunTime,
            sterilize: contentVue.sterilize,
        },
        success: function (res) {
            console.log(res);
            var data = res.split("*")[1];
            if (data == "0") {
                alert("修改成功");
                word=contentVue.name;
                queryModelInfo();
            }
        }
    })
}