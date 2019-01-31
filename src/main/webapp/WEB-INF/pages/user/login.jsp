<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/30
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>oa自动化办公系统-登录</title>
    <style>
        .text{
            width: 266px;
            height: 33px;
            border: none;
            outline: none;
            font-size: 20px;
            color: gainsboro;
            font-family: "franklin gothic medium cond";
        }
        .input_div{
            margin-left: 50px;
            margin-bottom: 25px;
            padding-bottom: 20px;
        }
        .login_btn{
            width: 321px;
            height: 50px;
            position: absolute;
            top: 580px;
            left: 41.6%;
            opacity:0;
            cursor: pointer;
        }
    </style>
    <script src="/js/jquery.min.1.8.2.js"></script>
    <script>
        $(function(){
            $(".login_btn").click(function(){
                window.location.href = "/user/userAction_login.action";
            });
        });
    </script>
</head>
<body style="background-image: url(/img/oa_login.jpg);background-repeat:no-repeat;">
<div align="center">
    <img src="/img/oa_title.png"/>
</div>
<div align="center" style="padding-top: 325px;">
    <%--<form>--%>
        <div class="input_div">
            <input name="userName" type="text" placeholder="用户名" class="text"/>
        </div>
        <div class="input_div">
            <input name="password" type="password" placeholder="密码" class="text"/>
        </div>
        <div>
            <button class="login_btn"></button>
        </div>
    <%--</form>--%>
</div>
</body>
</html>
