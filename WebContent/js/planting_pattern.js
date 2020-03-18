// $.getUrlParam = function (name) {
//     var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
//     var r = window.location.search.substr(1).match(reg);
//     if (r != null) return unescape(r[2]); return null;
// }
var user = document.cookie.split(";")[0].split("=")[1];
var nowModel = document.cookie.split(";")[2].split("=")[1];

var contentVue = new Vue({
    el: "#content",
    data: {
        items: [],
        nowModel: nowModel,
    }
})

$(function () {
    queryModelList();
})

function queryModelList() {
    $.ajax({
        url: "../queryModelList.jsp",
        type: "GET",
        data: {
            userID: user,
        },
        success: function (res) {
            console.log(res);
            var data = res.split("*")[1].split("~");
            for (let i = 0; i < data.length; i++) {
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
    var word = $(e).attr("value");
    word = escape(word);
    window.location.href = "pattern_edit.html?word=" + word;
}

function deleteModel(e) {
    var word = $(e).attr("value");

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
                nowModel = escape(nowModel);
                window.location.href = "planting_pattern.html?";
            }
        }
    })
}