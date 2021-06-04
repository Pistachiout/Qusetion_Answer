<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>    
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="icon" href="/resources/images/favicon.ico">
  <link rel="stylesheet" href="/resources/layui/css/layui.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.8/css/AdminLTE.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.8/css/skins/_all-skins.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker.min.css" />
  <link href="https://cdn.bootcss.com/bootstrap-switch/4.0.0-alpha.1/css/bootstrap-switch.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/resources/css/admin.css">
  <link rel="stylesheet" href="/resources/wangEditor/wangEditor.min.css">
  <link rel="stylesheet" href="/resources/cropper/cropper.css">
  <style>
    @media screen and (max-width: 768px) {
      .content-header {
        position: relative;
        padding: 65px 15px 0 15px;
      }
    }
  </style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/js/bootstrap-datepicker.min.js"></script>
  <script src="https://cdn.bootcss.com/bootstrap-switch/4.0.0-alpha.1/js/bootstrap-switch.min.js"></script>
  <script src="/resources/admin/js/app.min.js"></script>
  <script src="/resources/layui/layui.js"></script>
  <script src="/resources/layui/layui-paginate.js"></script>
  <script src="/resources/js/admin/avatar.js"></script>
  <script src="/resources/cropper/cropper.min.js"></script>
  <script type="text/javascript">
    $(function(){
      $.ajax({
        url: "/admin/user/info",
        type: "get",
        dataType: "json",
        success: function(data){
          if(data.success === true){
            $("#user-name").text(data.data.username);
            $("#user-avatar").attr("src",data.data.avatar);
          }
        },
        error: function(data){

        }
      });
    })
  </script>
  <script>
    function toast(txt, icon) {
      $.toast({
        text: txt, // Text that is to be shown in the toast
        heading: '系统提醒', // Optional heading to be shown on the toast
        icon: icon || 'error', // Type of toast icon warning, info, success, error
        showHideTransition: 'slide', // fade, slide or plain
        allowToastClose: true, // Boolean value true or false
        hideAfter: 2000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
        stack: false, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
        position: 'top-right', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
      });
    }
  </script>
</head>
<body class="hold-transition skin-blue sidebar-mini" style="background-color: #ecf0f5;">
<div>

<!-- 内容主体区域 -->
<div class="content-wrapper" style="padding: 50px 0 40px; margin-left: 140px;margin-right: 140px">
	<section class="content-header">
    <h1>
      评论
      <small>编辑</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/reply/list">评论</a></li>
      <li class="active">编辑</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">评论编辑</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form id="from">
          <div class="form-group" style="margin-bottom: 10px;">
          	<div class="form-group">
            	<div id="editor" style="margin-bottom: 10px;"></div>
          	</div>
            <button type="submit" class="btn btn-primary btn-sm">更新评论</button>
          </div>
        </form>
      </div>
    </div>
  </section>
  <script src="/resources/wangEditor/wangEditor.min.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$(".sidebar-menu li:eq(3)").addClass("active");
  		var E = window.wangEditor;
  	    var editor = new E('#editor');
  	    editor.customConfig.uploadFileName = 'file';
  	    editor.customConfig.uploadImgServer = '/common/wangEditorUpload';
  	    editor.customConfig.menus = [
  	    	  'head',  // 标题
  	    	  'bold',  // 粗体
  	    	  'italic',  // 斜体
  	    	  'underline',  // 下划线
  	    	  'strikeThrough',  // 删除线
  	    	  'link',  // 插入链接
  	    	  'list',  // 列表
  	    	  'quote',  // 引用
  	    	  'emoticon',  // 表情
  	    	  'image',  // 插入图片
  	    	  'table',  // 表格
  	    	  'code',  // 插入代码
  	    	  'undo',  // 撤销
  	    	  'redo'  // 重复
  	        ];
  	    editor.create();
  	    editor.txt.html('${fn:replace(reply.replyContent,vEnter,'')}');
		  $("#from").submit(function() {
			if (confirm("确定编辑此评论吗？")) {
				var contentHtml = editor.txt.html();
				$.ajax({
					url: '/admin/reply/edit',
					type: 'post',
					async: false,
					cache: false,
					dataType: 'json',
					data: {
						id: ${reply.replyId},
						content: contentHtml
					},
					success: function(data) {
						if (data.success != null && data.success == true) {
							toast(data.error, "success");
							setTimeout(function() {
								window.location.href = "http://localhost:8080/user/${reply.replyAuthorName}";
							},
							500);
						} else {
							toast(data.error);
						}
					},
					error: function(data) {
						toast(data.error);
						console.log(data.error);
					}
				})
			}
			return false;
		});
  	});
  </script>
</div>
<%@ include file="../layout/footer.jsp"%>