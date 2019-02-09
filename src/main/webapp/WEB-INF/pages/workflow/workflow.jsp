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
    <title>流程定义列表</title>
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

        /**新增模型模态框*/
        .addModel {
            display: none;
            position: fixed;
            top: 0;
            right: 0;
            bottom: 200px;
            left: 0;
            margin: auto;
            height: 25rem;
            line-height: 0.88rem;
            width: 30%;
            font-size: 18px;
            color: #fff;
            background: #FFFFFF;
            border: 3px #EEEEEE solid;
            border-radius: 0.1rem;
            z-index: 999;
        }

        .add_title {
            background: #385B70;
            width: 100%;
            height: 50px;
            line-height: 50px;
            text-indent: 10px;
            text-align: center;
            font-family: "微软雅黑";
            font-size: 23px;
            margin-bottom: 18px;
        }

        .add_delete {
            float: right;
            font-size: 25px;
            margin-right: 6px;
            cursor: pointer;
        }

        .add_tipContent {
            color: black;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            padding-top: 15px;
        }

        .add_btn {
            text-align: center;
            padding-top: 30px;
            width: 100%;
            padding-left: 100px;
        }

        .add_btn div {
            float: left;
            height: 30px;
            width: 100px;
            border-radius: 15px;
            line-height: 30px;
            margin-left: 50px;
            cursor: pointer;
        }

        .add_cancel {
            border: 1px #385B70 solid;
            color: black;
        }

        .add_confirm {
            border: 1px darkred solid;
            background: darkred;
        }

        .model_bg {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            background: rgba(0, 0, 0, .6);
            z-index: -1;
        }
        div.left{
            height: 121px;
            overflow: hidden;
            padding-left: 0px;
            padding-top: 0px;
            position: absolute;
            left: 50px;
            width: 100px;
            line-height: 30px;
        }
        div.right{
            padding-bottom: 10px;
            width: 650px;
        }
        .text_input{
            width: 47%;
            height: 30px;
        }
    </style>
    <link href="${pageContext.request.contextPath}/css/message.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/myplus/dialog.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/message.js"></script>
    <script src="${pageContext.request.contextPath}/js/myplus/dialog.js"></script>
    <script>
        $(function(){
            $("#addModel").click(function(){
                $(".addModel").show();
                $('.model_bg').fadeIn(300);
            });
            $(".delete").click(function(){
                $(".addModel").hide();
                $('.model_bg').fadeOut(300);
            });

            $(".confirm").click(function(){
                $(".confirm").click(function(){
                    $.ajax({
                        type:"POST",
                        url:"${pageContext.request.contextPath}/workflowAction_create.action",
                        data:$("#addModelForm").serialize(),
                        success:function(){
                            $.message("新增模型成功");
                            $(".addModel").hide();
                            $('.model_bg').fadeOut(300);
                            setTimeout(function() {
                                window.location.reload();
                            }, 3000);

                        }
                    });
                });
            });
        });

        function deleteModel(id,name){
            myalert("确定要删除模型【" + name + "】吗?");
            $(".confirm").click(function(){
                $.ajax({
                    type:"GET",
                    url:"${pageContext.request.contextPath}/workflowAction_deleteModel.action?modelId="+id,
                    success:function(){
                        $.message("删除成功");
                        $(".mark").hide();
                        $('.model_bg').fadeOut(300);
                        setTimeout(function() {
                            window.location.reload();
                        }, 3000);

                    }
                });
            });
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
                <td style="padding-right:10px;">
                    <div align="left" style="padding-bottom: 10px;padding-left: 10px;">
                        <button id="addModel" type="button" style="width: 100px;height: 35px;background-color: #385b70;color: #fff9ec;border: 1px #385B70 solid;cursor: pointer">新增模型</button>
                    </div>
                    <div align="right">
                    <table border="0" align="right" cellpadding="0" cellspacing="0">
                       <%-- <tr>
                            <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                                <tr class="add">
                                    <td class="STYLE1"><div align="center"><img src="/img/user/001.gif" width="14" height="14" /></div></td>
                                    <td class="STYLE1"><div align="center">新增</div></td>
                                </tr>
                            </table></td>
                            <td width="52"><table width="88%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="STYLE1"><div align="center"><img src="/img/user/083.gif" width="14" height="14" /></div></td>
                                    <td class="STYLE1"><div align="center">删除</div></td>
                                </tr>
                            </table></td>
                        </tr>--%>
                    </table>
                </div></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td><table width="100%" border="0" cellpadding="8" cellspacing="1" bgcolor="#c9c9c9" class="tb_context">
            <tr style="background:#EEEEEE">
                <td height="22" ><div align="center"><strong><span class="STYLE1">模型ID</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">模型名称</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">key</span></strong></div></td>
                <td height="22" width="274px" ><div align="center"><strong><span class="STYLE1">版本</span></strong></div></td>
                <td height="22" width="274px" ><div align="center"><strong><span class="STYLE1">部署ID</span></strong></div></td>
                <td height="22" width="274px" ><div align="center"><strong><span class="STYLE1">创建时间</span></strong></div></td>
                <td height="22" ><div align="center"><strong><span class="STYLE1">操作</span></strong></div></td>
            </tr>
            <s:if test="#request.models != null && #request.models.size() > 0">
                <s:iterator value="#request.models">
                    <tr>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="id" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3">
                            <a href="${pageContext.request.contextPath}/workflowAction_design.action?modelId=<s:property value="id" />"><s:property value="name" /></a>
                        </span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="key" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="version" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:property value="deploymentId" /></span></div></td>
                        <td height="22" ><div align="center"><span class="STYLE3"><s:date name="createTime" format="yyyy-MM-dd hh:mm:ss"/></span></div></td>
                        <td height="22" >
                            <div align="center" class="STYLE5">
                                <span class="cancelBtn" >部署</span>
                                <span class="exportBtn" ><a href="${pageContext.request.contextPath}/workflowAction_export.action?modelId=<s:property value="id" />">导出</a></span>
                                <span class="deleteBtn" onclick="javascript:deleteModel(<s:property value="id" />,'<s:property value="name" />')" >删除</span>
                            </div>
                        </td>
                    </tr>
                </s:iterator>
            </s:if>
            <s:else>
                <tr>
                    <td colspan = "7" align="center">没有数据记录</td>
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
<!-- 新增模型 -->
<section class="model_bg"></section>
<div class="addModel">
    <div class="add_title">新&nbsp;增&nbsp;模&nbsp;型<span class="delete">ⓧ</span></div>
    <div class="add_tipContent">
        <form id="addModelForm">
            <div class="left">模型Key</div>
            <div class="right"><input name="modelBean.key" class="text_input" type="text" /></div>
            <div class="left">模型名称</div>
            <div class="right"><input name="modelBean.name" class="text_input" type="text" /></div>
            <div class="left">&nbsp;&nbsp;&nbsp;&nbsp;描述</div>
            <div class="right"><textarea name="modelBean.description" style="width: 47%;" rows="8"></textarea></div>
        </form>
    </div>
    <div class="add_btn">
        <div class="add_cancel">重置</div>
        <div class="add_confirm">确定</div>
    </div>
</div>
</body>
</html>
