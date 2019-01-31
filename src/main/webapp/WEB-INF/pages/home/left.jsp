<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/31
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="/css/main.css" rel="stylesheet" type="text/css" />
</head>
<style>
    #leftMenu ul{
        margin:10px;
        padding-left: 1px;
    }
    #leftMenu ul li{
        display:block;
        cursor:pointer;
        text-align:center;
        margin-bottom:6px;
        border: 1px #EEEEEE solid;
        background-color: #eeeeee;
        background-position: 0px 0px;
        padding-top: 2px;
        line-height: 20px;
        font-size: 14px;
    }

    #leftMenu ul li a{
        color:#000000;
        text-decoration:none;
        background-repeat: repeat-x;
    }
    div p{
        padding-left: 20px;border-bottom: 1px #EEEEEE solid;
        margin: 0px;
    }
    div p:hover{
        background: #808080;
    }
    .pull-right{
        font-weight: bolder;
    }
</style>
<script type="text/javascript" src="/js/jquery.min.1.8.2.js" ></script>
<script>
    $(document).ready(function(){
        $('.parentMenu').on('click',function(){
            if($(this).toggleClass('selected').next().next('div').is(":hidden")){
                $(this).toggleClass('selected').next().text("-");
            }else{
                $(this).toggleClass('selected').next().text("+");
            }

            $(this).toggleClass('selected').next().next('div').slideToggle(500);
            $(this).parent().siblings().children('div').slideUp(500);
            $(this).parent().siblings().children('span.pull-right').text("+");
            $(this).parent().siblings().children('.parentMenu').removeClass('selected');
        })
    });
</script>
<body>
<div id="left">
    <div id="left_menu"></div>
    <div id="leftMenu">
        <ul>
            <li><a href="welcome.html" target="homeFrame">首页</a></li>
            <li>
                <a>系统管理</a>&nbsp;&nbsp;
                <span style="min-width: 13px;">&nbsp;&nbsp;</span>
            </li>
            <li>
                <a class="parentMenu">菜单管理</a>&nbsp;&nbsp;
                <span class='pull-right'> + </span>
                <div style="background-color: #DCDCDC;display: none;">
                    <p><a href="right.html" id="0" target="homeFrame">菜单列表</a></p>
                </div>
            </li>
            <li>
                <a class="parentMenu">用户管理</a>&nbsp;&nbsp;
                <span class='pull-right'> + </span>
                <div style="background-color: #DCDCDC;display: none;">
                    <p><a href="right.html" id="1" target="homeFrame">用户列表</a></p>
                </div>
            </li>
            <li>
                <a class="parentMenu">审批流转</a>&nbsp;&nbsp;
                <span class='pull-right'> + </span>
                <div style="background-color: #DCDCDC;display: none;">
                    <p><a href="right.html" id="2" target="homeFrame">我的待办</a></p>
                    <p><a href="right.html" id="3" target="homeFrame">请假申请</a></p>
                </div>
            </li>
        </ul>
    </div>
    <div id="tree_down"></div>
</div>
</body>
</html>
