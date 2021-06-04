<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Roothub-${user.userName}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/app.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/resources/layui/css/layui.css" media="all">
<link rel="shortcut icon" href="/resources/images/favicon.ico">
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
<body>
	<div class="wrapper">
		<jsp:include page="../components/head.jsp"></jsp:include>
		<div class="row">

			<div class="box box-primary">
    <div class="cell" style="padding: 10px;">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tbody><tr>
            <td width="73" valign="top" align="center">
            <img src="${user.avatar}"  border="0" align="default" style="border-radius: 4px;" width="73" height="73px"/>
            <div class="sep10"></div>
            </td>
            <td width="10"></td>
            <td width="auto" valign="top" align="left">

                <h1 title="${user.userId}" id="user_id" class= "user_id">${user.userName}</h1>
                <span class="gray" style="font-size: 14px;">第 ${user.userId}位用户，加入于 <fmt:formatDate type="both" value="${user.createDate}" /><div class="sep5"></div>
                </span> 
            </td>
        </tr>
    </tbody></table>
    <div class="sep5"></div>
</div>
</div>
<div class="sep20"></div>
				<div class="panel panel-default">
					<%-- <div class="panel-heading">${user.userName}创建的话题</div> --%>
					<div class="cell_tabs"><div class="fl"><img src="${user.avatar}" width="24" style="border-radius: 24px; margin-top: -2px;" border="0"></div>
					<!-- <a href="javascript:void(0);" onclick="activitiesList()" class="cell_tab_current">动态</a> -->
					<a href="javascript:void(0);" onclick="topicList()" class="cell_tab_current" >问题</a>
					<a href="javascript:void(0);" onclick="replyList()" class="cell_tab">回复</a>
					<a href="javascript:void(0);" onclick="topicQnaList()" class="cell_tab"></a></div>
					<div class="itemList"></div>

				</div>
			</div>
		</div>
	</div>

	</div>
	<jsp:include page="../components/foot.jsp"></jsp:include>
	<script src="/resources/js/jquery.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/goTop.js"></script>
	<script src="/resources/layui/layui.js"></script>
	<script src="/resources/layui/layui-paginate.js"></script>
	<script src="/resources/js/user/detail.js"></script>
	<script src="/resources/js/formatDate.js"></script>

</body>
</html>