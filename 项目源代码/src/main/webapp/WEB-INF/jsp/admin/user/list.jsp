<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../layout/header.jsp"%>
<!-- 内容主体区域 -->
<div class="content-wrapper" style="padding: 50px 0 40px;">
  <section class="content-header">
    <h1>
      用户
      <small>列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li><a href="/admin/user/list">用户</a></li>
      <li class="active">列表</li>
    </ol>
  </section>
  <section class="content">
    <div class="box box-info">
      <div class="box-header with-border">
        <h3 class="box-title">用户列表</h3>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <form action="/admin/user/list" method="get" class="form-inline">
          <div class="form-group" style="margin-bottom: 10px;">
            <input type="text" name="username" value="${username}" class="form-control" placeholder="用户名">
            <input type="text" name="email" value="${email}" class="form-control" placeholder="邮箱">
            <button type="submit" class="btn btn-primary btn-sm">搜索</button>
          </div>
        </form>
        <table class="table table-bordered">
          <thead>
          <tr>
            <th>ID</th>
            <th>用户名</th>
            <th>邮箱</th>
            <th>时间</th>
            <th>同意注册</th>
            <th>拉黑</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="user" items="${page.list}">
            <tr>
              <td>${user.userId}</td>
              <td><a href="/user/${user.userName}" target="_blank">${user.userName}</a></td>
              <td>${user.email}</td>
              <td><fmt:formatDate type="both" value="${user.createDate}" /></td>
              <td>
                <shiro:hasPermission name="user:edit">
                  <c:choose>
                    <c:when test="${user.userType == '3'}">
                      <button onclick="actionBtn('${user.userId}')" class="btn btn-xs btn-primary">同意注册</button>
                    </c:when>
                    <c:otherwise>
                       <span>已同意注册</span>
                     </c:otherwise>
                  </c:choose>
                </shiro:hasPermission>


              </td>
              <c:choose>
                <c:when test="${user.isBlock == true}">
                  <td><input name="userBlock" type="checkbox" value="${user.userId}" checked="checked"></td>
                </c:when>

                <c:otherwise>
                  <td><input name="userBlock" type="checkbox" value="${user.userId}"></td>
                </c:otherwise>
              </c:choose>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="panel-footer" id="paginate"></div>
    </div>
  </section>
  <script type="text/javascript">
    $(function(){
      $(".sidebar-menu li:eq(5)").addClass("active");
      var username = '${username}';
      var email = '${email}';
      var p = '${p}';//当前页数
      var count = ${page.totalRow};//数据总量
      var limit = ${page.pageSize};//每页显示的条数
      var url = "?username="+username+"&email="+email+"&p=";//url
      paginate(count,limit,p,url);

      $('[name="userBlock"]').bootstrapSwitch({
        onColor:"success",
        offColor:"danger",
        onSwitchChange:function(event,status){
          var id = $(this).val();
          $.get("/admin/user/block?id=" + id + "&status=" + status, function(data){
            if(data.success === true){
              toast(data.error, "success");
            }else{
              toast(data.error);
            }
          })
        }
      });
    });

    function actionBtn(id){
      if(confirm("确定要同意该用户注册吗？")){
        $.get("/admin/user/delete?id=" + id,function(data){
          if(data.success === true){
            toast(data.error, "success");
            setTimeout(function(){
              window.location.reload();
            },700);
          }else{
            toast(data.error);
          }
        })
      }
    }
  </script>
</div>
<%@ include file="../layout/footer.jsp"%>