<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/31
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>OA自动化办公系统</title>
    <link href="/css/myplus/dialog.css" />
    <script src="/js/jquery.min.1.8.2.js"></script>
    <script src="/js/myplus/dialog.js"></script>
    <script>
        $(document).ready(function(){
            var mainFrame = $(window.top.mainFrame.document).find(".logintext");
            mainFrame.click(function(){
                alert(1);
                myalert("确定退出系统吗?");
                //top.location.href = "/user/userAction_loginout.action";
            });
        });
    </script>
</head>
<frameset rows="60,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="/home/homeAction_top.action" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" />
    <frameset id="main" rows="*" cols="188,*" framespacing="0" frameborder="no" border="0">
        <frame src="/home/homeAction_left.action" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" />
        <frameset rows="73,*" cols="*">
            <frame src="/home/homeAction_rightTop.action" name="mainFrame" id="mainFrame" />
            <frame src="/home/homeAction_welcome.action" id="homeFrame" name="homeFrame" />
        </frameset>
    </frameset>
</frameset>
<noframes><body>
</body>
</noframes>
</html>
