// $.getUrlParam = function (name) {
//     var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
//     var r = window.location.search.substr(1).match(reg);
//     if (r != null) return unescape(r[2]); return null;
// }

// //得到user参数
// var user = $.getUrlParam("user");
var user = document.cookie.split(";")[0].split("=")[1];
console.log(user)
var diviceVue = new Vue({
    el: "#divice",
    data: {
        items: [],
        nowDivice: "",
        mark: 1
    }
})

var modelVue = new Vue({
    el: "#model",
    data: {
        nowModel: "",
        items: []
    }
})

var controllVue = new Vue({
    el: "#controll",
    data: {
        RT0: 0,
        RT1: 0,
        RT2: 0,
        RT3: 0,
        RT4: 0,
        RT5: 0,
        RT6: 0,
        RT7: 0,
        RT8: 0,
        Sta0: 0,
        Sta1: 0,
        Sta2: 0,
        Sta3: 0,
        Sta4: 0,
        Sta5: 0,
        Sta6: 0,
        Sta7: 0,
        Sta8: 0,
        Sta9: 0,
        Sta10: 0,
        divice: "",
    }
})

var btnVue = new Vue({
    el: "#btn",
    data: {
        open: true,
        sun: 0,
    }
})


//第一次登陆。查询以前保存的模式
function queryModel() {
    $.ajax({
        url: "../chooseDivice.jsp",
        type: "GET",
        data: {
            nowDivice: diviceVue.nowDivice,
        },
        success: function (res) {
            var res = res.split("*")[1];
            //console.log(res);
            diviceVue.mark = res.split("^")[0];
            var data = res.split("^")[1].split("~");
            //                console.log(diviceVue.mark);
            //               console.log(data);
            modelVue.nowModel = data[0];
            document.cookie = "model=" + modelVue.nowModel;
            console.log(data)

            modelChange();
            queryOpen();
        }
    })
}

//设备id改变，读取RT
function diviceChange() {
    queryRT();
    queryModel();
    controllVue.divice = diviceVue.nowDivice;
    document.cookie = "divice=" + diviceVue.nowDivice;
}

//当模式改变,读取Sta数据
function modelChange() {
    $.ajax({
        url: "../queryModel.jsp",
        type: "GET",
        data: {
            user: user,
            nowModel: modelVue.nowModel,
            nowDivice: diviceVue.nowDivice
        },
        success: function (res) {
            var data = res.split("*")[1].split("~");
            //console.log(data);
            controllVue.Sta0 = data[0]; controllVue.Sta1 = data[1];
            controllVue.Sta2 = data[2]; controllVue.Sta3 = data[3];
            controllVue.Sta4 = data[4]; controllVue.Sta5 = data[5];
            controllVue.Sta6 = data[6]; controllVue.Sta7 = data[7];
            controllVue.Sta8 = data[8]; controllVue.Sta9 = data[9];
            controllVue.Sta10 = data[10];
        },
        error: function (res) {
            if (res.status) {
                controllVue.Sta0 = 0; controllVue.Sta1 = 0;
                controllVue.Sta2 = 0; controllVue.Sta3 = 0;
                controllVue.Sta4 = 0; controllVue.Sta5 = 0;
                controllVue.Sta6 = 0; controllVue.Sta7 = 0;
                controllVue.Sta8 = 0; controllVue.Sta9 = 0;
                controllVue.Sta10 = 0;
            }
        }
    })

    document.cookie = "model=" + modelVue.nowModel;
    queryOpen();
    updateDiviceStatus();
}

$(function () {
    queryDivice();
    queryUserModel();
})
//查询所有model
function queryUserModel() {
    modelVue.items = [];
    $.ajax({
        url: "../queryUserModel.jsp",
        type: "GET",
        data: {
            userID: user,
        },
        success: function (res) {
            var data = res.split("*")[1].split("~");
            for (let i = 0; i < data.length; i++) {
                modelVue.items.push({ "model": data[i] });
            }
        }
    })
}

//查询设备id
function queryDivice() {
    $.ajax({
        url: "../queryDivice.jsp",
        type: "GET",
        data: {
            user: user,
        },
        success: function (res) {
            var data = res.split("*")[1].split("~");
            for (let i = 0; i < data.length; i++) {
                diviceVue.items.push({ "divice": data[i] });
            }
            diviceVue.nowDivice = diviceVue.items[0].divice;
            controllVue.divice = diviceVue.nowDivice;
            document.cookie = "divice=" + diviceVue.nowDivice;
            queryModel();
            queryRT();
        }
    })
}

//查询当前设备id的RT
function queryRT() {
    $.ajax({
        url: "../queryRT.jsp",
        type: "GET",
        data: {
            nowDivice: diviceVue.nowDivice,
        },
        success: function (res) {
            //           console.log(res)
            var data = res.split("*")[1].split("~");
            //console.log(data);
            controllVue.RT0 = data[0]; controllVue.RT1 = data[1];
            controllVue.RT2 = data[2]; controllVue.RT3 = data[3];
            controllVue.RT4 = data[4]; controllVue.RT5 = data[5];
            controllVue.RT6 = data[6]; controllVue.RT7 = data[7];
            controllVue.RT8 = data[8];
        }
    })
    $.ajax({
        url: "../querySunModel.jsp",
        type: "GET",
        data: {
            nowDivice: diviceVue.nowDivice
        },
        success: function (res) {
            var data = res.split("*")[1];
            //console.log(data);
            btnVue.sun = data;
        },
    })
}

//查询设备功能配件是否打开
function queryOpen() {
    $.ajax({
        url: "../queryOpen.jsp",
        type: "GET",
        data: {
            diviceID: diviceVue.nowDivice,
        },
        success: function (res) {
            //console.log(res)
            var data = res.split("*")[1];
            //console.log(data)
            if (data == "0") {
                btnVue.open = false;
            } else {
                btnVue.open = true;
            }
        }
    })
}

// function changeShebei() {
//     $.ajax({
//         url: "../changeShebei.jsp",
//         type: "GET",
//         data: {
//             diviceID: diviceVue.nowDivice,
//         },
//         success: function (res) {
//             //console.log(res)
//             var data = res.split("*")[1];
//             //console.log(data)
//             if (data == "0") {
//                 btnVue.open = !btnVue.open;
//             }
//         }
//     })
// }

function toBianji() {
    var nowModel = escape(modelVue.nowModel);
    window.location.href = "planting_pattern.html?nowModel=" + nowModel;
}

//每次选择下拉框 刷新数据库
function updateDiviceStatus() {
    $.ajax({
        url: "../updateDiviceStatus.jsp",
        type: "GET",
        data: {
            nowModel: modelVue.nowModel,
            nowDivice: diviceVue.nowDivice,
        },
        success: function (res) {
            //console.log(res);
            var data = res.split("*")[1].split("~");
        }
    })
}

//点击视频监控页面
function toVideo() {
    window.location.href = "../vide.jsp?divice=" + diviceVue.nowDivice;
}

//点击切换光照模式
function changeSunModel() {
    if (btnVue.sun == 0) {
        btnVue.sun = 1;
    } else {
        btnVue.sun = 0;
    }
    $.ajax({
        url: "../updateSunModel.jsp",
        type: "GET",
        data: {
            nowDivice: diviceVue.nowDivice,
            sun: btnVue.sun,
        },
        success: function (res) {
            //console.log(res);
            var data = res.split("*")[1].split("~");
        }
    })
}