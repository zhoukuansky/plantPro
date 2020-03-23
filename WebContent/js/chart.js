$.getUrlParam = function (name) {//获取跳转页面时，url中携带的参数函数，主要是通过js跳转页面
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

//得到user参数
var divice = $.getUrlParam("divice");

var dateTime = [];
var vale = [];
window.onload = function () {
    getData();//先获得数据
    showChart();//然后利用插件框架echarts进行渲染

    var li = [];
    li = document.getElementsByTagName("li");
    for (let i = 0; i < li.length; i++) {
        li[i].onclick = function () {//点击事件，进行相应操作
            flag = i;
            change();
            getData();
            showChart();
        }
    }
}

//这个change函数是在点击事件之后，移除html的元素class属性 通过预选设置的class属性  实现样式的改变
function change() {
    if (flag == 0) {
        $("#1").removeClass("unchoice").addClass('choice');
        $("#2").removeClass("choice").addClass('unchoice');
        $("#3").removeClass("choice").addClass('unchoice');
    } else if (flag == 1) {
        $("#2").removeClass("unchoice").addClass('choice');
        $("#1").removeClass("choice").addClass('unchoice');
        $("#3").removeClass("choice").addClass('unchoice');
    } else {
        $("#3").removeClass("unchoice").addClass('choice');
        $("#1").removeClass("choice").addClass('unchoice');
        $("#2").removeClass("choice").addClass('unchoice');
    }
}

//获取图图表的数据
function getData() {
    var xhr;
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else {
        xhr = new ActiveXObject("Microsoft.XMLHTTP")
    }
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var data1 = xhr.responseText.split("*")[1];
            var data2 = xhr.responseText.split("*")[2];
            dateTime = data1.split("~");
            vale = data2.split("~");
            /*			console.log(data1);
                        console.log(data2);
                        console.log(dateTime);
                        console.log(vale);*/
        }
    }
    xhr.open('get', 'chart_dispose.jsp?num=' + num + '&flag=' + flag+ '&divice=' + divice, false);
  
    xhr.send();
}

//这里是图标用的是框架插件，是assets目录下的echarts，可以查询echarts的相关接口进行查询
function showChart() {
    var myChart = echarts.init(document.getElementById('main'));
    var text;
    if (flag == 0) {
        text = "24小时数据";
    } else if (flag == 1) {
        text = "24小时~48小时数据";
    } else {
        text = "过去一周数据";
    }
    myChart.setOption({
        title: {
            text: text
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            color: 'rgba(255, 255, 255)',
        },
        grid: {
            left: '5%',
            right: '6%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: dateTime
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            type: 'line',
            stack: '总量',
            data: vale
        },],
    });
}