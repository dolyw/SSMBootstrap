<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jspf"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title>用户添加</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="${ctxstatic}/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctxstatic}/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${ctxstatic}/vendor/linearicons/style.css">
	<link rel="stylesheet" href="${ctxstatic}/vendor/toastr/toastr.min.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="${ctxstatic}/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="${ctxstatic}/css/demo.css">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="${ctxstatic}/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="${ctxstatic}/img/favicon.png">
	
	<%@include file="/common/css.jspf"%>
	
</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<%@ include file="/admin/common/navbar.jsp" %>
		
		<%@ include file="/admin/common/leftnav.jsp" %>
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					
					<div id="toastr-demo" class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">用户增改</h3>
						</div>
						<div class="panel-body">
						<form id="form" role="form">
				                <input id="id" name="id" value="${user.id}" type="hidden" />
				                <div class="form-group">
								    <label for="name">帐号</label>
								    <input type="text" class="form-control" id="account" name="account" value="${user.account}" placeholder="请输入帐号">
								</div>
								<div class="form-group">
								    <label for="name">密码</label>
								    <input type="password" class="form-control" id="password" name="password" value="${user.password}" placeholder="请输入密码">
								</div>
								<div class="form-group">
								    <label for="name">昵称</label>
								    <input type="text" class="form-control" id="username" name="username" value="${user.username}" placeholder="请输入昵称">
								</div>
								
				                <button type="button" onclick="save()" class="btn btn-default">保存</button>
				                <button type="reset" class="btn btn-default">取消</button>
				        </form>
				        </div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="${ctxstatic}/vendor/jquery/jquery.min.js"></script>
	<script src="${ctxstatic}/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctxstatic}/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="${ctxstatic}/scripts/klorofil-common.js"></script>
	
	<%@include file="/common/js.jspf"%>
	
	<script>
	function save() {
        $.ajax({
            type: 'POST',
            url: '${ctx}/user/userSave',
            data: $('#form').serialize(),
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                	swal(
			               	{   
	               		      title: "提示信息",   
	               		      text: data.msg,  
	               		      type: "info",
	               		      allowOutsideClick: false,
	               		      background: '#FFF',
	               		      confirmButtonColor: '#64C9C1',
	               		      confirmButtonText: "确定"
		               		  }).then(
		               		      function () {
		               		      	location.href='${ctx}/user/userList';
		               		      }
		             		)
                }
            },
            error: function () {
            	swal(
	               		  {   
	               		      title: "提示信息",   
	               		      text: "出错了,请重试!",  
	               		      type: "info",
	               		      allowOutsideClick: false,
	               		      background: '#FFF',
	               		      confirmButtonColor: '#64C9C1',
	               		      confirmButtonText: "确定"
	               		  }).then(
	               		      function () {
	               		      	location.href='${ctx}/user/userList';
	               		      }
           		    )
            }
        });
    }

	</script>
</body>

</html>
