<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Roothub-${nodeName}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="/resources/css/app.css" rel="stylesheet" type="text/css">
  <link rel="shortcut icon" href="/resources/images/favicon.ico">
  <link rel="stylesheet" href="/resources/layui/css/layui.css" media="all">
</head>
<body>
 <div class="wrapper">
  <jsp:include page="components/head.jsp"></jsp:include>
    <div class="row">
      <div class="col-md-9">
        <div class="box box-primary">
        	<div class="box-header with-border">
	        	<ul class="nav nav-pills" id="tab">
		        	<li class="${tab eq 'all' ? 'all active' : 'all'}"><a href="/?tab=all&node=${nodeName}">全部</a></li>
		        	<li class="${tab eq 'hot' ? 'hot active' : 'hot'}"><a href="/?tab=hot&node=${nodeName}">最热</a></li>
		        	<li class="${tab eq 'new' ? 'new active' : 'new'}"><a href="/?tab=new&node=${nodeName}">最新</a></li>
		        	<li class="${tab eq 'lonely' ? 'lonely active' : 'lonely'}"><a href="/?tab=lonely&node=${nodeName}">无人问津</a></li>
	        	</ul>
    		</div>
	        <div class="box-body">
	          <c:forEach var="item" items="${page.list}" varStatus="status">
		          <div class="media">
			          <c:if test="${fn:length(item.avatar) > 0}">
			            <div class="media-left">
			              <img src="${item.avatar}" class="avatar img-circle" alt="">
			            </div>
			           </c:if>
		            <div class="media-body">
		              <div class="title">
		                <c:choose>
		                	<c:when test="${item.url != null}">
		                		<a href="${item.url}" target="_blank">${item.title}</a>
		                	</c:when>
		                	<c:otherwise>
		                		<a href="/topic/${item.topicId}">${item.title}</a>
		                	</c:otherwise>
		                </c:choose>
		              </div>
		              <div class="tip">
		              <p class="gray">

					    
		                <a href="/user/${item.author}">${item.author}</a>
		                <c:if test="${item.viewCount > 0}">
		                	<span class="hidden-sm hidden-xs">•</span>
		                	<span class="hidden-sm hidden-xs">${item.viewCount}次点击</span>
		                </c:if>
		                
		                <!-- 评论数量 -->
		                <c:if test="${item.replyCount > 0}">
		                	<span class="hidden-sm hidden-xs">•</span>
		                	<span class="hidden-sm hidden-xs"><a href="/topic/${item.topicId}">${item.replyCount}个评论</a></span>
		                </c:if>
		                
		                <span>•</span>
		                <span><fmt:formatDate type="date" value="${item.createDate}" /></span>
		                </p>
		                </div>
		              </div>
		            <div class="media-right"><span class="badge badge-default"><a href="/topic/${item.topicId}">${item.replyCount}</a></span></div>
		            <c:if test="${!status.last}">
		            	<div class="divide mar-top-5"></div>
		            </c:if>
		          </div>
	          </c:forEach>
	      </div>
      	    <div class="box-footer panel-footer" id="paginate"></div>
        </div>
      </div>
<div id="back2Top" class="backTop___6Q-ki" style="display:none">
	<div class="line___F1WY0"></div>
	<div class="arrow___3UCwo"></div>
</div>
<jsp:include page="components/foot.jsp"></jsp:include>
<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/index.js"></script>
<script src="/resources/layui/layui.js"></script>
<script src="/resources/layui/layui-paginate.js"></script>
<!-- <script src="/resources/js/login_info.js"></script> -->
<script src="/resources/js/formatDate.js"></script>
<script type="text/javascript">
//var tab = "${tab}";//板块
var tab = "${tab}";//父板块
var nodeName = "${nodeName}";
//var url = "/?tab="+tab+"&ptab="+ptab+"&"
//$(".pagination2").pagination("${page.pageNumber}","${page.totalPage}",10);
 var count = ${page.totalRow};//数据总量
 var limit = ${page.pageSize};//每页显示的条数
 var url = "?node="+nodeName+"&tab="+tab+"&p=";//url
 function page(){
     var page = location.search.match(/p=(\d+)/);  
     return page ? page[1] : 1;  
 }
 var p = page();//当前页数
 //console.log("p:"+p);
 //console.log(count);
 //console.log(url);
 paginate(count,limit,p,url);
</script>
</body>
</html>