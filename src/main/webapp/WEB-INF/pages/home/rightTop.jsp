<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/31
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/myplus/dialog.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery.min.1.8.2.js"></script>
<script src="${pageContext.request.contextPath}/js/myplus/dialog.js"></script>
<script>
    $(document).ready(function(){
        $(".logintext").click(function(){
            myalert("确定退出系统吗?");
            $(".confirm").click(function(){
                top.location.href = "/user/userAction_loginout.action";
            });
        });
    });
</script>
<style>
    #right_font{
        padding-left: 20px;
    }
    .content{
        width:85px;
        height:15px;
        display:block;
        padding:5px;
        font-size: 14px;
        color: #FFF;
        background-color: #385b70;
        border: 1px #EEEEEE solid;
        float: left;
        margin-right: 10px;
        text-align: center;
        line-height: 15px;
    }
    .open_img{
        transform: rotate(0deg);
        -webkit-transform: rotate(180deg);
        transition: transform .5s;
    }
    .close_img{
        transform: rotate(180deg);
        -webkit-transform: rotate(0deg);
        transition: transform .5s;
    }

    .img,.imgtext{
        cursor: pointer;
    }

    .yuanjiao{
        border-radius:15px;
        background:gray;
    }

</style>
<script src="${pageContext.request.contextPath}/js/jquery.min.1.8.2.js"></script>
<script>
    $(document).ready(function() {
        $(".img,.imgtext").click(function() {
            if(parent.document.getElementById("main").cols == "188,*") {
                parent.document.getElementById("main").cols = "0,100%";
                $(".imgtext").text("打开左栏");
                $(".img").removeClass("close_img").addClass("open_img");
            } else if(parent.document.getElementById("main").cols == "0,100%") {
                parent.document.getElementById("main").cols = "188,*";
                $(".imgtext").text("关闭左栏");
                $(".img").removeClass("open_img").addClass("close_img");
            }
        });

        //显示tab
        var leftFrameEle = $(window.parent.leftFrame.document).find("#leftMenu ul li p");
        leftFrameEle.on("click",function(){
            $(".content").removeClass("yuanjiao");
            var content;
            var id = $(this).find("a").attr("id");
            if($("#right_font div").text().indexOf($(this).text()) == -1 && $(this).text() != '首页'){
                content = "<div id= '"+id+"' class='content'></div>";
                content = $(content).html($(this).text() + "&nbsp;<span style='color: gainsboro;'>ⓧ</span>");
                $("#right_font").append(content);
                $(content).addClass("yuanjiao");
                //打开页面
                //window.parent.document.getElementById("homeFrame").src = "right.html";
            }else{
                //相同的不再次追加，显示选中
                $("#"+id).addClass("yuanjiao");
            }
        });

    });
</script>


<div id="right_top">
    <div id="img"><img class="img" src="${pageContext.request.contextPath}/img/home/close.gif" /></div>
    <span class="imgtext">关闭左栏</span>
    <div id="loginout">
        <div id="loginoutimg"><img src="${pageContext.request.contextPath}/img/home/loginout.gif" /></div>
        <span class="logintext">退出系统</span>
    </div>
</div>
<div id="right_font"></div>