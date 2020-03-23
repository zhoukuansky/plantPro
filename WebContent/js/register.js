//Vue只用了简单的数据绑定
var formVue=new Vue({
    el:"#form",//这里的“formVue”绑定的是相应Html文件中id为“form”的元素及子元素
    data:{
        userName:"123",//绑定id为“form”的子元素中的userName
        passWord:"123",//绑定id为“form”的子元素中的password
        passWord2:"",//绑定id为“form”的子元素中的password2
    }
})


function tijiao(){
    if(formVue.passWord!=formVue.passWord2){//用户填写userName和passWord和passWord2以后，这里的formVue.passWord和formVue.passWord2就能直接获取到数据
        alert("您输入的密码不一致！");
        window.location.href="./register.html";//密码不一致重新跳转到注册页面
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
                var data = res.split("*")[1];//后台返回后是个字符串，这里分割后台返回的字符串，获取有效数据填充到data
                if(data=="0"){//进行判断data的值，0成功，1失败。这是自己在后台设置的标志位
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