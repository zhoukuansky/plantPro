<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="showPhoto.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>植物工厂导航页面</title>

    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/showPhoto.css" />

</head>

<body>
    <div id="header">
        <div class="w nav-list">
            <ul class="head-left-nav" id="nav">
                <li>
                    <p>CDSJSD</p>
                </li>
                <li><a href="index.html">首页</a>
                    <!--转主页-->
                </li>
                <li><a href="html/control_management.html">控制管理</a>
                    <!--转登录-->
                </li>
            </ul>

        </div>
    </div>


    <div style="z-index: 1;">
        <div id="img_list">
            <div class="left">
                <img id="img" src="" width="850" height="637" title="滑动滚轮切换图片">
            </div>
            <div class="right">
                <span class="span1">照片采集时间：</span>
                <span class="span2" id="span2"></span>
                <span class="span3" id="span3"></span>
            </div>
        </div>
    </div>
</body>

<script>
    var mark = 0;
    var markMax = 1;
    var markMin = 99999999;
    var year = [];
    var day = [];

    // var img_big = document.getElementById("bigger");
    var img = document.getElementById("img");
    window.onload = function () {
        queryData();
    }

    // function show(src) //显示隐藏层和弹出层
    // {
    //     img_big.src = src;
    //     var hideobj = document.getElementById("hidebg");
    //     hidebg.style.display = "block"; //显示隐藏层
    //     hidebg.style.height = document.documentElement.clientHeight + "px"; //设置隐藏层的高度为当前页面高度
    //     document.getElementById("hidebox").style.display = "block"; //显示弹出层
    // }

    // function hidd() //隐藏隐藏层和弹出层
    // {
    //     var hideobj = document.getElementById("hidebg");
    //     hidebg.style.display = "none"; //显示隐藏层
    //     document.getElementById("hidebox").style.display = "none"; //显示弹出层
    // }

    function queryData() {
        var xhr;
        if (window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        } else {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                setTimeout(function () {
                    var res = xhr.responseText.split("*")[1];
                    var data = res.split("~");

                    mark = data[0];
                    if (mark > markMax) {
                        markMax = mark;
                        markMin = markMax;
                    }
                    console.log(mark);

                    var imgSrc = "images/" + data[0] + ".jpg";
                    img.src = imgSrc;

                    var time = data[1].split(" ");
                    document.getElementById("span2").innerHTML = time[0];
                    year.push(time[0]);
                    if (mark == markMax) {
                        document.getElementById("span3").innerHTML = time[1] + "(最新)";
                        day.push(time[1] + "(最新)");
                    } else {
                        document.getElementById("span3").innerHTML = time[1];
                        day.push(time[1]);
                    }
                }, 3000);
            }
        }
        xhr.open('get', "photo_dispose.jsp?mark=" + mark, false);
        xhr.send();
    }

    setTimeout(function () {
        windowAddMouseWheel()
    }, 3000
    );
    function windowAddMouseWheel() {
        var scrollFunc = function (e) {
            e = e || window.event;
            if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件
                if (e.wheelDelta > 0) { //当滑轮向上滚动时
                    if (mark != markMax) {
                        if (mark < markMin) {
                            mark++;
                            queryData();
                        } else {
                            mark++;
                            img.src = "images/" + mark + ".jpg";
                            document.getElementById("span2").innerHTML = year[markMax - mark];
                            document.getElementById("span3").innerHTML = day[markMax - mark];
                        }
                    }
                    //alert("滑轮向上滚动");
                }
                if (e.wheelDelta < 0) { //当滑轮向下滚动时
                    if (mark != 1) {
                        if (mark - 1 < markMin) {
                            mark--;
                            markMin--;
                            queryData();
                        }
                        else {
                            mark--;
                            img.src = "images/" + mark + ".jpg";
                            document.getElementById("span2").innerHTML = year[markMax - mark];
                            document.getElementById("span3").innerHTML = day[markMax - mark];
                        }
                    }
                    //alert("滑轮向下滚动");
                }
            } else if (e.detail) {  //Firefox滑轮事件
                if (e.detail > 0) { //当滑轮向上滚动时
                    if (mark != markMax) {
                        if (mark < markMin) {
                            mark++;
                            queryData();
                        } else {
                            mark++;
                            img.src = "images/" + mark + ".jpg";
                            document.getElementById("span2").innerHTML = year[markMax - mark];
                            document.getElementById("span3").innerHTML = day[markMax - mark];
                        }
                    }
                    //alert("滑轮向上滚动");
                }
                if (e.detail < 0) { //当滑轮向下滚动时
                    if (mark != 1) {
                        if (mark - 1 < markMin) {
                            mark--;
                            markMin--;
                            queryData();
                        }
                        else {
                            mark--;
                            img.src = "images/" + mark + ".jpg";
                            document.getElementById("span2").innerHTML = year[markMax - mark];
                            document.getElementById("span3").innerHTML = day[markMax - mark];
                        }
                    }
                    //alert("滑轮向下滚动");
                }
            }
        };
        //给页面绑定滑轮滚动事件
        if (document.addEventListener) {
            document.addEventListener('DOMMouseScroll', scrollFunc, false);
        }
        //滚动滑轮触发scrollFunc方法
        document.onmousewheel = scrollFunc;
    }
</script>

</html>