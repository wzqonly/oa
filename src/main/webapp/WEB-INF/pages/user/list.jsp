<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/31
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>员工列表</title>
    <style type="text/css">
        <!--
        .STYLE1 {font-size: 15px;;cursor: pointer;}
        .STYLE3 {color: #707070; font-size: 14px; }
        .STYLE5 {color: #0a6e0c; font-size: 14px; }
        body {
            margin-top: 0px;
            margin-bottom: 0px;
        }
        .STYLE7 {font-size: 12px}
        -->
        .tb_context tr:hover{
            background: #EEEEEE;
        }
        .tb_context tr{
            background:#FFFFFF
        }
        .opeartorInput{
            /*border: 1px #385b70 solid;*/
            display: none;
        }
        .cancelBtn {
            color: darkred;
            font-size: 14px;
            cursor: pointer ;
        }

        .cancelBtn:hover{
            color: red;
        }
        .confirmBtn{
            color: blue;
            font-size: 14px;
            cursor: pointer;
            margin-left: 10px;
        }
        .confirmBtn:hover{
            color: dodgerblue;
        }

        .validate{
            border: 1px darkred solid;
        }
        input.validate::-webkit-input-placeholder{
            color: darkred;
        }
    </style>
    <link rel="stylesheet" href="/js/layui-v2.4.5/layui/css/layui.css" />
    <link href="/css/myplus/dialog.css" rel="stylesheet" type="text/css" />
    <link href="/css/message.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery.min.1.8.2.js"></script>
    <script src="/js/myplus/dialog.js"></script>
    <script src="/js/layui-v2.4.5/layui/layui.js" charset="utf-8"></script>
    <script src="/js/message.js"></script>
    <script>
        layui.use('laydate', function() {
            var laydate = layui.laydate;

            //常规用法
            laydate.render({
                elem: '#hiredate'
                ,showBottom: true
                ,theme: '#385b70'
            });
        });
    </script>
    <script>
        $(function(){
            //添加员工
            $(".add").click(function(){
                $(".opeartorInput").show();
                /*$("tr.add td:eq(1)").text("保存");*/

            });
            //取消按钮事件
            $(".cancelBtn").click(cancel);

            $("input[name=userName],input[name=email],input[name=hiredate]").focus(function(){
                if($(this).hasClass("validate")){
                    $(this).attr("placeholder","");
                }
                $(this).removeClass("validate");
            });

            //确定按钮事件
            $(".confirmBtn").click(function(){
                var userName = $("input[name=userName]");
                var email = $("input[name=email]");
                var hiredate = $("input[name=hiredate]");
                var flag = true;
                if(!checkUserNameInput(userName)){
                    flag = false;
                }
                if(!checkEmailInput(email)){
                    flag = false;
                }
                if(!checkHiredateInput(hiredate)){
                    flag = false;
                }
                if(!flag){
                    return flag;
                }
                $.ajax({
                    type:"post",
                    data:{"employee.userName":userName.val(),"employee.email":email.val(),"employee.hiredate":hiredate.val()},
                    dataType:"json",
                    url:"/user/userAction_add.action",
                    success:function(data){
                        $.message(data.message);
                        if(data.success == true){
                            window.location.href = "/user/userAction_list.action";
                        }
                    }
                });
            });
        });

        function cancel(){
            $(".opeartorInput").hide();
           /* $("tr.add td:eq(1)").text("新增");*/

            //清空文本框数据
            $("tr.opeartorInput td input").attr("placeholder","").removeClass("validate");
        }

        function checkUserNameInput(userName){
            //员工姓名
            if(userName.val() == ""){
                userName.attr("placeholder","员工名称不能为空");
                userName.addClass("validate");
                return false;
            }
            return true;
        }

        function checkEmailInput(email){
            if(email.val() == ""){
                email.attr("placeholder","电子邮箱不能为空");
                email.addClass("validate");
                return false;
            }
            return true;
        }
        function checkHiredateInput(hiredate){
            if(hiredate.val() == ""){
                $.message({
                    message:'入职日期不能为空',
                    type:'warning'
                });
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<jsp:include page="../home/rightTop.jsp" />
<link href="/css/message.css" rel="stylesheet" type="text/css" />
<script src = "/js/message.js"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>&nbsp;</td>
                <td style="padding-right:10px;">
                    <div align="left" style="padding-bottom: 1px;">
                        <input type="text"  placeholder="输入员工编号/员工姓名" class="layui-input" style="width: 238px;height: 35px;float: left;"/>
                        <button type="button" style="width: 100px;height: 35px;background-color: #385b70;color: #fff9ec;border: 1px #385B70 solid;cursor: pointer">搜索</button>
                    </div>
                    <div align="right">
                    <table border="0" align="right" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="60"><table width="87%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="STYLE1"><div align="center">
                                        <input type="checkbox" name="checkbox62" value="checkbox" />
                                    </div></td>
                                    <td class="STYLE1"><div align="center">全选</div></td>
                                </tr>
                            </table></td>
                            <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                                <tr class="add">
                                    <td class="STYLE1"><div align="center"><img src="/img/user/001.gif" width="14" height="14" /></div></td>
                                    <td class="STYLE1"><div align="center">新增</div></td>
                                </tr>
                            </table></td>
                            <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="STYLE1"><div align="center"><img src="/img/user/114.gif" width="14" height="14" /></div></td>
                                    <td class="STYLE1"><div align="center">修改</div></td>
                                </tr>
                            </table></td>
                            <td width="52"><table width="88%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="STYLE1"><div align="center"><img src="/img/user/083.gif" width="14" height="14" /></div></td>
                                    <td class="STYLE1"><div align="center">删除</div></td>
                                </tr>
                            </table></td>
                        </tr>
                    </table>
                </div></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td><table width="100%" border="0" cellpadding="8" cellspacing="1" bgcolor="#c9c9c9" class="tb_context">
            <tr style="background:#EEEEEE">
                <td height="22" ><div align="center"><strong><span class="STYLE1">
                    <input type="checkbox" name="checkAll" value="checkbox" />
                </span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">员工编号</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">员工名称</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">电子邮箱</span></strong></div></td>
                <td height="22" width="274px" ><div align="center"><strong><span class="STYLE1">入职时间</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">操作</span></strong></div></td>
            </tr>
            <tr class="opeartorInput">
                <td height="22" ><div align="center"><span class="STYLE3"><input type="checkbox" name="checkAll" disabled="disabled" value="checkbox" /></span></div></td>
                <td height="22" >
                    <div align="center">
                        <span class="STYLE3" aria-disabled="true">

                        </span>
                    </div>
                </td>
                <td height="22" style="padding: 0;margin: 0px">
                    <input class="STYLE3" type="text" name="userName" style="text-align:center;width: 100%;height: 35px;padding: 0px; ">
                </td>
                <td height="22" style="padding: 0;margin: 0px">
                    <input class="STYLE3" type="text" name="email" style="text-align:center; width: 100%;height: 35px;padding: 0px;">
                </td>
                <td height="22" style="padding: 0;margin: 0px">
                    <input type="text" placeholder="" class="layui-input STYLE3" name="hiredate" id="hiredate" style="text-align:center;">
                </td>
                <td height="22">
                    <div align="center">
                        <span class="cancelBtn" >取消</span>
                        <span class="confirmBtn" >确定</span>
                    </div>
                </td>
            </tr>
            <s:if test="#request.list != null && #request.list.size() > 0">
                <s:iterator value="#request.list">
                    <tr>
                        <td height="22" ><div align="center"><span class="STYLE3"><input type="checkbox" name="checkAll" value="checkbox" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="userCode" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="userName" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="email" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:date name="hiredate" format="yyyy-MM-dd"/></span></div></td>
                        <td height="22" ><div align="center" class="STYLE5">明细</div></td>
                    </tr>
                </s:iterator>
            </s:if>
            <s:else>
                <tr colspan = "6">
                    <td>没有数据记录</td>
                </tr>
            </s:else>
        </table></td>
    </tr>
    <tr>
        <td height="35"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="25%" height="29" nowrap="nowrap"><table width="342" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="44%" class="STYLE1">当前页：1/2页 每页15条</td>
                        <td width="42%" class="STYLE1"><span class="STYLE7">数据总量 15 </span></td>
                    </tr>
                </table></td>
                <td width="75%" valign="top" class="STYLE1"><div align="right">
                    <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="62" height="22" valign="middle"><div align="right"><img src="/img/home/page_first_1.gif" width="48" height="28" /></div></td>
                            <td width="50" height="22" valign="middle"><div align="right"><img src="/img/home/page_back_1.gif" width="55" height="28" /></div></td>
                            <td width="54" height="22" valign="middle"><div align="right"><img src="/img/home/page_next.gif" width="58" height="28" /></div></td>
                            <td width="49" height="22" valign="middle"><div align="right"><img src="/img/home/page_last.gif" width="52" height="28" /></div></td>
                            <td width="59" height="22" valign="middle"><div align="right">转到第</div></td>
                            <td width="25" height="22" valign="middle"><span class="STYLE7">
                  <input name="textfield" type="text" class="STYLE1" style="height:10px; width:25px;" size="5" />
                </span></td>
                            <td width="23" height="22" valign="middle">页</td>
                            <td width="30" height="22" valign="middle"><img src="/img/home/go.gif" width="26" height="20" /></td>
                        </tr>
                    </table>
                </div></td>
            </tr>
        </table></td>
    </tr>
</table>
</body>
</html>
