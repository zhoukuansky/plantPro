//加载图片js

var user = document.cookie.split(";")[0].split("=")[1];
var divice = document.cookie.split(";")[1].split("=")[1];

var contentVue = new Vue({
    el: "#content",
    data: {
        input: "",

        co2: "",
        PH: "",
        TDS: "",
        sun: "",
        water: "",
        waterHeight: "",
        temperature: "",
        humidity: "",
        cycle: "",
        sterilize:"",
        sunTime:"",
    }
})

var seeVue=new Vue({
    el:"#see",
    data:{
        name1:"",
        score1:"",
        name2:"",score2:"",
        name3:"",score3:"",
        name4:"",score4:"",
        name5:"",score5:"",
    }
})

var picVue = new Vue({
    el: "#pic",
    data: {
        src: "../images/pic.gif",
    }
})
var btnVue=new Vue({
    el:"#btnSure",
    data:{
        mark:true,
    }
})

var flag = false;
var first = 0;

function addModel() {
    if (contentVue.input != "" && contentVue.co2 != "" && contentVue.PH != "" && contentVue.TDS != "" && contentVue.sun != "" && contentVue.waterHeight != "" && contentVue.water != "" && contentVue.temperature != "" && contentVue.humidity != "" && contentVue.cycle != ""&& contentVue.sunTime != ""&& contentVue.sterilize != "") {
        $.ajax({
            url: "../addModel.jsp",
            type: "GET",
            data: {
                userID: user,
                name: contentVue.input,

                co2: contentVue.co2,
                PH: contentVue.PH,
                TDS: contentVue.TDS,
                sun: contentVue.sun,
                water: contentVue.water,
                waterHeight: contentVue.waterHeight,
                temperature: contentVue.temperature,
                humidity: contentVue.humidity,
                cycle: contentVue.cycle,
                sunTime:contentVue.sunTime,
                sterilize:contentVue.sterilize,
            },
            success: function (res) {
                console.log(res);
                var data = res.split("*")[1];
                if (data == "0") {
                    alert("新加模式成功");
                    window.location.href = "planting_pattern.html";
                }
            }
        })
    } else {
        alert("所有填写不能为空")
    }

}

$("#btn").click(function () {
    flag=false;
    first=0;
    btnVue.mark=true;

    seeVue.name1="",seeVue.score1="";
    seeVue.name2="",seeVue.score2="";
    seeVue.name3="",seeVue.score3="";
    seeVue.name4="",seeVue.score4="";
    seeVue.name5="",seeVue.score5="";

    var t1 = window.setInterval(function () {
        if (!flag) {
            loadingPIC();
        } else {
            window.clearInterval(t1);
        }
        if (first == 0) first = 1;
    }, 3000);

    document.getElementById("one_modal").style.display = "block";
})

function btnClose() {
    document.getElementById("one_modal").style.display = "none";
    picVue.src="../images/pic.gif";
    flag=true;
}

//加载图片
function loadingPIC(){
    $.ajax({
        url:"../loadingPIC.jsp",
        type:"GET",
        data:{
            first:first,
            divice:divice,
        },
        async:false, 
        success:function(res){
            console.log(res);
            var data = res.split("*")[1];
            if(data=="0"){
                flag=true;
                picVue.src="../images/0.jpg";
                seePic();
            }
        }
    })
}

//查看图片
function seePic(){
    $.ajax({
        url:"../seePic.jsp",
        type:"GET",
        data:{},
        dataType:"json",
        success:function(res){
            console.log(res);
            
            btnVue.mark=false;
            seeVue.name1=res.result[0].name;
            seeVue.score1=res.result[0].score;

            seeVue.name2=res.result[1].name;
            seeVue.score2=res.result[1].score;

            seeVue.name3=res.result[2].name;
            seeVue.score3=res.result[2].score;

            seeVue.name4=res.result[3].name;
            seeVue.score4=res.result[3].score;

            seeVue.name5=res.result[4].name;
            seeVue.score5=res.result[4].score;
        }
    })
}

//查看下一张图片
function seeAdd(){
    document.getElementById("one_modal").style.display = "none";
    picVue.src="../images/pic.gif";
    flag=true;

    contentVue.input=seeVue.name1;
    $.ajax({
        url:"../queryMoren.jsp",
        type:"GET",
        data:{
            name:seeVue.name1,
            userID:user,
        },
        success:function(res){
            var data = res.split("*")[1].split("~");
            if(data[0]=="0"){
            }else{
                contentVue.co2 = data[0];
                contentVue.sun = data[1];
                contentVue.waterHeight = data[2];
                contentVue.temperature = data[3];
                contentVue.humidity = data[4];
                contentVue.TDS = data[5];
                contentVue.PH = data[6];
                contentVue.water = data[7];
                contentVue.cycle = data[8];
            }
        }
    })
}