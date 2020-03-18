var formVue=new Vue({
    el:"#form",
    data:{
        userName:"",
        passWord:"",
    }
})
var msgVue=new Vue({
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
            url:"../login.jsp",
            type:"GET",
            data:{
                userName:formVue.userName,
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
            		window.location.href="control_management.html?user="+formVue.userName;
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