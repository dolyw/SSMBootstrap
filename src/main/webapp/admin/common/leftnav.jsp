<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="${ctx}/index/index"  class=""><i class="lnr lnr-home"></i><span>主页</span></a></li>
						
						<li>
							<a href="#userPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i><span>用户管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="userPages" class="collapse ">
								<ul class="nav">
									<li><a href="${ctx}/user/userList"  class="">用户列表</a></li>
									<li><a href="${ctx}/user/userEdit"  class="">用户添加</a></li>
								</ul>
							</div>
						</li>
						
						<li>
							<a href="#itemPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-heart"></i><span>商品管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="itemPages" class="collapse ">
								<ul class="nav">
									<li><a href="#"  class="">商品列表</a></li>
									<li><a href="#"  class="">商品添加</a></li>
								</ul>
							</div>
						</li>
						
						<li>
							<a href="#orderPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-bookmark"></i><span>订单管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="orderPages" class="collapse ">
								<ul class="nav">
									<li><a href="#"  class="">订单列表</a></li>
								</ul>
							</div>
						</li>
						<li><a href="#"  class=""><i class="lnr lnr-dice"></i><span>关于</span></a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->