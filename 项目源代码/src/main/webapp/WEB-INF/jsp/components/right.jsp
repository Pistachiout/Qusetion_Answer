<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-md-3 hidden-sm hidden-xs">
  	<c:if test="${sessionScope.user != null}">
					<div class="panel panel-default" id="session">
						<div class="panel-body">
							<div class="media">
								<div class="media-left">
									<a href="/user/${sessionScope.user.userName}"> <img
										src="${sessionScope.user.avatar}" title=""
										class="user-avatar img-circle">
									</a>
								</div>
								<div class="media-body">
									<div class="media-heading">
										<strong><a href="/user/${sessionScope.user.userName}">${sessionScope.user.userName}</a></strong>
										<div style="color: #7A7A7A; font-size: 12px; margin-top: 5px;">
											<i>${sessionScope.user.signature}</i>
										</div>
									</div>
								</div>
								<div style="margin-top: 15px;">
									<a href="/topic/create?statusCd=1000" style="font-size: 14px;"><button
											class="btn btn-success">发布问题</button></a>
								</div>
							</div>
							<div class="sep10" style="height: 10px;"></div>
							<table cellpadding="0" cellspacing="0" border="0" width="100%"
								class="table_fade" style="font-size: 14px;">
								<tbody>
									<tr>
										<td width="33%" align="center"><a href="/user/topics"
											class="dark" style="display: block;"><span class="bigger">${sessionScope.countTopic}</span>
												<div class="sep3"></div> <span class="fade">我的问题</span></a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="panel-footer" style="background-color: white">
							<div class="row">
								<span class="col-md-6"><a href="/notification/list"><span
										id="n_count">${sessionScope.countNotReadNotice}</span> 条未读消息</a></span>
							</div>
						</div>
					</div>
				</c:if>
				
				<!-- 今日热议主题 -->
    <div class="panel panel-default">
      <div class="panel-heading"><span style="color: #ccc;">今日热议主题</span></div>
      <table class="table" style="font-size: 14px;">
        <tbody>
        <c:forEach var="item" items="${findHot}">
          <tr>
          <c:if test="${fn:length(item.avatar) > 0}">
          <td width="24" valign="middle" align="center">
                <%-- <a href="/user/${item.author}"> --%><img src="${item.avatar}" class="avatar img-circle" border="0" align="default" style="max-width: 24px; max-height: 24px;"><!-- </a> -->
            </td>
            </c:if>
            <td>
            	<c:choose>
                	<c:when test="${item.url != null}">
                		<a href="${item.url}">${item.title}</a>
                	</c:when>
                	<c:otherwise>
                		<a href="/topic/${item.topicId}">${item.title}</a>
                	</c:otherwise>
                </c:choose>
            </td>
          </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    <!-- 今日等待回复的主题 -->
    <div class="panel panel-default">
      <div class="panel-heading"><span style="color: #ccc;">今日等待回复主题</span></div>
      <table class="table" style="font-size: 14px;">
        <tbody>
        <c:forEach var="item" items="${findTodayNoReply}">
          <tr>
          <td width="24" valign="middle" align="center">
                <a href="/user/${item.author}"><img src="${item.avatar}" class="avatar img-circle" border="0" align="default" style="max-width: 24px; max-height: 24px;"></a>
            </td>
            <td>
            	<c:choose>
                	<c:when test="${item.url != null}">
                		<a href="${item.url}">${item.title}</a>
                	</c:when>
                	<c:otherwise>
                		<a href="/topic/${item.topicId}">${item.title}</a>
                	</c:otherwise>
                </c:choose>
            </td>
          </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    <!-- 积分榜 -->

    <!-- 社区运行状况 -->
    <div class="panel panel-default">
    <div class="panel-heading"><span style="color: #ccc;">社区运行状况</span></div>
    <div class="cell">
    	<table cellpadding="5" cellspacing="0" border="0" width="100%">
            <tbody style="font-size: 14px;">
            <tr>
                <td width="80" align="right"><span class="gray">注册用户：</span></td>
                <td width="auto" align="left"><strong>${countUserAll}</strong></td>
            </tr>
            <tr>
                <td width="80" align="right" style="font-size: 14px;"><span class="gray">问题：</span></td>
                <td width="auto" align="left"><strong>${countAllTopic}</strong></td>
            </tr>
            <tr>
                <td width="80" align="right"><span class="gray">回复：</span></td>
                <td width="auto" align="left"><strong>${countAllReply}</strong></td>
            </tr>
           </tbody>
        </table>
      </div>
  </div>
</div>