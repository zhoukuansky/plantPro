$.getUrlParam = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

//得到user参数
var divice = $.getUrlParam("divice");

var dateTime = [];
var vale = [];
window.onload = function () {
    getData();
    showChart();

    var li = [];
    li = document.getElementsByTagName("li");
    for (let i = 0; i < li.length; i++) {
        li[i].onclick = function () {
            flag = i;
            change();
            getData();
            showChart();
        }
    }
}

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