<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="layout/header.jsp"%>
<!-- 内容主体区域 -->
<div class="content-wrapper" style="padding: 50px 0 40px;">
	<section class="content-header">
		<h1>
			首页 <small></small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i>
					首页</a></li>
			<li class="active"></li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-aqua">
					<div class="inner">
						<h3>${topic_count}</h3>

						<p>今天新增问题</p>
					</div>
					<div class="icon">
						<i class="ion ion-ios-list-outline"></i>
					</div>
					<a href="/admin/topic/list" class="small-box-footer">更多 <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
			<!-- ./col -->
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-yellow">
					<div class="inner">
						<h3>${comment_count}</h3>
						<p>今天新增回复数</p>
					</div>
					<div class="icon">
						<i class="ion ion-chatboxes"></i>
					</div>
					<a href="/admin/reply/list" class="small-box-footer">更多 <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-red">
					<div class="inner">
						<h3>${user_count}</h3>

						<p>今天新增用户数</p>
					</div>
					<div class="icon">
						<i class="ion ion-person-add"></i>
					</div>
					<a href="/admin/user/list" class="small-box-footer">更多 <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
		</div>
	</section>
	<script type="text/javascript">
  	$(function(){
  		$(".sidebar-menu li:eq(1)").addClass("active");
  	});
  </script>
</div>
<%@ include file="layout/footer.jsp"%>