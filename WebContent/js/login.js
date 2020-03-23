var formVue=new Vue({//这里的“formVue”绑定的是相应Html文件中id为“form”的元素及子元素
    el:"#form",
    data:{
        userName:"",
        passWord:"",
    }
})
var msgVue=new Vue({//这里的“msgVue”绑定的是相应Html文件中id为“msg”的元素及子元素
    el:"#msg",
    data:{
        msg:"Enter your username and password to log on:"
    }
})


function login(){
    if(formVue.userName==""||formVue.passWord==""){
        msgVue.msg="用户和密码不能为空";
    }
    else{
        $.ajax({
            url:"../login.jsp",//调回用登录接口
            type:"GET",
            data:{
                userName:formVue.userName,//通过formVue绑定获取上传的数据
                passWord:formVue.passWord,
            },
            success:function(res){
            	var data= res.split("*");
                console.log(data);
                for(i=0;i<data.length;i++){
                    if(data[i]=="0"){
                    document.cookie = "user="+formVue.userName;
                    document.cookie = "divice=0";
                    document.cookie = "model=0";
            		window.location.href="control_management.html?user="+formVue.userName;//通过url传值
                }
                }
            		msgVue.msg="用户名或密码有错";
            },
            error:function(res){
                console.log(res)
            },
        })
    }
}