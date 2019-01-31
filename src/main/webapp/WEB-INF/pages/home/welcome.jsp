<%--
  Created by IntelliJ IDEA.
  User: zonly
  Date: 2019/1/31
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<!-- 浮动窗口样式css begin -->
<style type="text/css">
    #msg_win{border:1px solid #DCDCDC; filter:alpha(Opacity=80);-moz-opacity:0.5;opacity: 0.5;width:240px;position:absolute;right:0;font-size:12px;font-family:Arial;margin:0px;display:none;overflow:hidden;z-index:99;}
    #msg_win .icos{position:absolute;top:2px;*top:0px;right:2px;z-index:9;}
    .icos a{float:left;color:#DCDCDC;margin:1px;text-align:center;font-weight:bold;width:14px;height:22px;line-height:22px;padding:1px;text-decoration:none;font-family:webdings;}
    .icos a:hover{color:#fff;}
    #msg_title{background:#385b70;border-bottom:1px solid #DCDCDC;border-top:1px solid #FFF;border-left:1px solid #FFF;color:#fff;height:25px;line-height:25px;text-indent:5px;}
    #msg_content{margin:5px;margin-right:0;width:230px;height:126px;overflow:hidden;}
</style>
<!-- 浮动窗口样式css end -->
<body>
<div id="welcome" class="content" style="display:block;">
    <div align="center">
        <p>&nbsp;</p>
        <p style="font-family: '微软雅黑';font-size: 38px;"><strong>欢迎使用OA自动化办公系统！</strong></p>
        <p>&nbsp;</p>
    </div>
</div>
<!-- 浮动窗口html代码 begin -->
<div id="msg_win" style="display:block;top:490px;visibility:visible;opacity:1;">
    <div class="icos">
        <a id="msg_min" title="最小化" href="javascript:void 0">_</a><a id="msg_close" title="关闭" href="javascript:void 0">×
    </a>
    </div>
    <div id="msg_title">
        收到最新通知
    </div>
    <div id="msg_content" style="overflow:auto;height:150px;width:100%;white-space:nowrap">
        收到一封通知,请注意查收
    </div>
</div>
<!-- 浮动窗口html代码 end -->
</body>
</html>
<!-- 浮动窗口js，必须要放置到最后  begin-->
<script language="javascript">
    var Message={
        set: function() {//最小化与恢复状态切换
            var set=this.minbtn.status == 1?[0,1,'block',this.char[0],'最小化']:[1,0,'none',this.char[1],'展开'];
            this.minbtn.status=set[0];
            this.win.style.borderBottomWidth=set[1];
            this.content.style.display =set[2];
            this.minbtn.innerHTML =set[3]
            this.minbtn.title = set[4];
            this.win.style.top = this.getY().top;
        },
        close: function() {//关闭
            this.win.style.display = 'none';
            window.onscroll = null;
        },
        setOpacity: function(x) {//设置透明度
            var v = x >= 100 ? '': 'Alpha(opacity=' + x + ')';
            this.win.style.visibility = x<=0?'hidden':'visible';//IE有绝对或相对定位内容不随父透明度变化的bug
            this.win.style.filter = v;
            this.win.style.opacity = x / 100;
        },
        show: function() {//渐显
            clearInterval(this.timer2);
            var me = this,fx = this.fx(0, 100, 0.1),t = 0;
            this.timer2 = setInterval(function() {
                t = fx();
                me.setOpacity(t[0]);
                if (t[1] == 0) {clearInterval(me.timer2) }
            },10);
        },
        fx: function(a, b, c) {//缓冲计算
            var cMath = Math[(a - b) > 0 ? "floor": "ceil"],c = c || 0.1;
            return function() {return [a += cMath((b - a) * c), a - b]}
        },
        getY: function() {//计算移动坐标
            var d = document,b = document.body, e = document.documentElement;
            var s = Math.max(b.scrollTop, e.scrollTop);
            var h = /BackCompat/i.test(document.compatMode)?b.clientHeight:e.clientHeight;
            var h2 = this.win.offsetHeight;
            return {foot: s + h + h2 + 2+'px',top: s + h - h2 - 2+'px'}
        },
        moveTo: function(y) {//移动动画
            clearInterval(this.timer);
            var me = this,a = parseInt(this.win.style.top)||0;
            var fx = this.fx(a, parseInt(y));
            var t = 0 ;
            this.timer = setInterval(function() {
                t = fx();
                me.win.style.top = t[0]+'px';
                if (t[1] == 0) {
                    clearInterval(me.timer);
                    me.bind();
                }
            },10);
        },
        bind:function (){//绑定窗口滚动条与大小变化事件
            var me=this,st,rt;
            window.onscroll = function() {
                clearTimeout(st);
                clearTimeout(me.timer2);
                me.setOpacity(0);
                st = setTimeout(function() {
                    me.win.style.top = me.getY().top;
                    me.show();
                },600);
            };
            window.onresize = function (){
                clearTimeout(rt);
                rt = setTimeout(function() {me.win.style.top = me.getY().top},100);
            }
        },
        init: function() {//创建HTML
            function $(id) {return document.getElementById(id)};
            this.win=$('msg_win');
            var set={minbtn: 'msg_min',closebtn: 'msg_close',title: 'msg_title',content: 'msg_content'};
            for (var Id in set) {this[Id] = $(set[Id])};
            var me = this;
            this.minbtn.onclick = function() {me.set();this.blur()};
            this.closebtn.onclick = function() {me.close()};
            this.char=navigator.userAgent.toLowerCase().indexOf('firefox')+1?['_','::','×']:['0','2','r'];//FF不支持webdings字体
            this.minbtn.innerHTML=this.char[0];
            this.closebtn.innerHTML=this.char[2];
            setTimeout(function() {//初始化最先位置
                me.win.style.display = 'block';
                me.win.style.top = me.getY().foot;
                me.moveTo(me.getY().top);
            },0);
            return this;
        }
    };
    Message.init();
</script>
<!-- 浮动窗口js end-->
