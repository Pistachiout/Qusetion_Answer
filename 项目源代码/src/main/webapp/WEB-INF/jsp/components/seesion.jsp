<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<c:if test="${sessionScope.user != null}">
	<div class="box box-primary" id="session">
		<div class="box-body">
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
					<a href="/topic/create" style="font-size: 14px;">
						<button class="btn btn-primary">发布帖子</button>
					</a>
				</div>
			</div>
			<div class="sep10" style="height: 10px;"></div>
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				class="table_fade" style="font-size: 14px;">
				<tbody>
					<tr>
						<td width="33%" align="center"><a href="/user/topics"
							class="dark" style="display: block;"><span class="bigger">${countTopic}</span>
								<div class="sep3"></div> <span class="fade">我的问题</span></a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="panel-footer" style="background-color: white">
			<div class="row">
				<span class="col-md-6"><a href="/notification/list"><span
						id="n_count">${countNotReadNotice}</span> 条未读消息</a></span> <span

			</div>
		</div>
	</div>
</c:if>