//公共对话框
function myalert(str) {
    var div = '<div class="mark">'
        +'<div class="title">操作提示<span class="delete">ⓧ</span></div>'
        +'<div class="tipContent"></div>'
        +'<div class="btn"><div class="cancel">取消</div><div class="confirm">确定</div></div>'
        +'</div>';
    $('body').append(div)
    $('.tipContent').html(str);
    $('.mark').show();
    /*setTimeout(function() {
        $('.mark').hide();
        $('.mark').remove();
    }, 2000);*/

    $(".delete,.cancel").click(function(){
        $(".mark").hide();
    });
}