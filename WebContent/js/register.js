var formVue=new Vue({
    el:"#form",
    data:{
        userName:"123",
        passWord:"123",
        passWord2:"",
    }
})

function tijiao(){
    if(formVue.passWord!=formVue.passWord2){
        alert("您输入的密码不一致！");
        window.location.href="./register.html";
    }else{
        $.ajax({
            url:"../register.jsp",
            type:"GET",
            data:{
                userName:formVue.userName,
                passWord:formVue.passWord,
            },
            success:function(res){
                console.log(res);
                var data = res.split("*")[1];
                if(data=="0"){
                    alert("添加用户成功");
                    window.location.href="../index.html";
                }
                if(data=="1"){
                    alert("该用户已经存在！");
                    window.location.href="./register.js";
                }
            },
            error:function(res){
                console.log("失败");
            }
        })
    }
}