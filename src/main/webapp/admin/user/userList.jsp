<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jspf"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title>用户管理</title>
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

	<style>
		.table{
			table-layout: fixed;
		}
	</style>

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
							<h3 class="panel-title" <%-- align="center" --%>>用户列表</h3>
						</div>
						<div id="toolbar" class="btn-group">
							<a href="${ctx}/user/userEdit"><button id="btn_add" type="button" class="btn btn-default">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
							</button></a>
							<%--<button id="btn_edit" type="button" class="btn btn-default">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                            </button>
                            <button id="btn_delete" type="button" class="btn btn-default">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                            </button>--%>
						</div>
						<div class="panel-body">
							<table id="table"></table>
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

	<script >
		/*bootstrap table*/
		$('#table').bootstrapTable({
		    url: '${ctx}/user/getUserList',
            method: 'post',
            toolbar: '#toolbar', // 工具按钮用哪个容器
            //showHeader : true,
            showColumns : true, // 筛选
            contentType: "application/x-www-form-urlencoded", //  必须要有！因为bootstap table使用的是ajax方式获取数据，这时会将请求的content type默认设置为 text/plain，这样在服务端直接通过 @RequestParam参数映射是获取不到的。
            dataField: "data", // 这是返回的json数组的key.默认好像是"rows".这里只有前后端约定好就行
            pagination: true, // 分页
            pageNumber:	1, // 初始化加载第一页，默认第一页
            pageSize: 10, // 每页的记录行数（*）
            pageList: [1, 10, 15, 30], // 分页步进值
            striped: true, // 是否显示行间隔色
            queryParams:queryParams, // 请求服务器时所传的参数
            sidePagination:'server', // 指定服务器端分页
            //clickToSelect : true,  // 点击表格项即可选择
            cache : false, // 是否使用缓存
            height : "624",
            //sortable: true, // 是否启用排序
            //showToggle:true, // 是否显示详细视图和列表视图的切换按钮
            //showPaginationSwitch: true, // 是否显示切换分页按钮
            //showFullscreen: true, // 是否显示全屏按钮
            //uniqueId: "id", // 每一行的唯一标识，一般为主键列
            columns: [{
                align: 'center',
                valign : 'middle',
                width : '50',
                formatter: function (value, row, index) {
                    var pageSize = $('#table').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#table').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'username',
                title: '昵称',
                align: 'center',
                valign : 'middle'
            }, {
                field: 'account',
                title: '帐号',
                align: 'center',
                valign : 'middle'
            },{
                field: 'password',
                title: '密码',
                align: 'center',
                valign : 'middle'
            },  {
                field: 'regtime',
                title: '注册时间',
                align: 'center',
                valign : 'middle',
                formatter: function (value, row, index) {
                    return changeDateFormat(value)
                }
            }, {
		        title: '操作',
		        align: 'center',
	            formatter: operateFormatter,
	            events: window.operateEvents = {
	                    'click .RoleOfdelete': function (e, value, row, index) {
	                    	swal({
	            	  	 		title: '你确定删除吗?',
	            	  	 		text: "删除后不可恢复!",
	            	  	 		type: 'warning',
	            	  	 		showCancelButton: true,
	            	  	 		confirmButtonColor: '#d33',
	            	  	 		cancelButtonColor: '#64C9C1',
	            	  	 		confirmButtonText: '删除',
	            	  	 		cancelButtonText: '取消'
	            	  		}).then(function () {
	            	  			$.ajax({
	            		            type: 'POST',
	            		            url: '${ctx}/user/userDelete',
	            		            data: {
	            		                id: row.id
	            		            },
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
	            	  		})
	                 },
	                    'click .RoleOfedit': function (e, value, row, index) {
	                    	if (row.id == undefined || row.id == null || row.id == '') {
	            	            window.location.href = '${ctx}/user/userEdit';
	            	        } else {
	            	            window.location.href = '${ctx}/user/userEdit?id=' + row.id;
	            	        }
	                 }
	            }
		    },]
		});

        // 请求服务数据时所传参数
        function queryParams(params){
            return {
                pageSize : params.limit, //每一页的数据行数，默认是上面设置的10(pageSize)
                pageNumber : params.offset/params.limit+1, //当前页面,默认是上面设置的1(pageNumber)
                //param : "Your Param" //这里是其他的参数，根据自己的需求定义，可以是多个
            }
        }

        // 操作按钮
        function operateFormatter(value, row, index) {
            return [
                '<button type="button" class="RoleOfdelete btn btn-danger  btn-xs" >删除</button>|',
                '<button type="button" class="RoleOfedit btn btn-primary  btn-xs" >修改</button>'
            ].join('');
        }

        // 转换时间格式
        function changeDateFormat(cellval) {
            var dateVal = cellval + "";
            if (cellval != null) {
                var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

                var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

                return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
            }
        }

	</script>

</body>

</html>
