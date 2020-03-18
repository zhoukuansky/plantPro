$.getUrlParam = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

//得到user参数
var diviceID = $.getUrlParam("diviceID");
var word = $.getUrlParam("word");
word = unescape(word);

var user = document.cookie.split(";")[0].split("=")[1];

var contentVue = new Vue({
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

$(function () {
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
        data: {
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