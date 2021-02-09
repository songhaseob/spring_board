<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>회원 수정 페이지</title>


<!-- Font Awesome Icons -->
<link rel="stylesheet" href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	// 주소검색 버튼이 클릭 되었을 때 다음 주소 api 팝업을 실행
	$('#addrbtn').on("click",function(){
		
    new daum.Postcode({
        oncomplete: function(data) {
        	
            $('#addr1').val(data.roadAddress); // 도로주소
            $('#zipcode').val(data.zonecode);    // 우편번호 
            
            // 사용자 편의성을 위해 상세주소 입력 input 태그로 focus 설정
            $('#addr2').focus();
            
        }
    }).open();
	})
	
	$('#updatebtn').on("click",function(){
		
			$('#frm').attr("method","post");
			$('#frm').attr("action","/spring/realupdateuser");
			$('#frm').submit();
			
		})

})

</script>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		 <%@ include file="../common/nav.jsp" %> 

		<!-- Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo -->
			<a href="/" class="brand-link">
				<img src="/resources/images/line.png" class="brand-image img-circle elevation-3" style="opacity: .8">
				<span class="brand-text font-weight-light">회원 관리</span>
			</a>

			<!-- Sidebar -->
			<div class="sidebar">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel mt-3 pb-3 mb-3 d-flex">
					<div class="image">
						<img src="${cp }/profile/sally.png" class="img-circle elevation-2" alt="User Image">
					</div>
					<div class="info">
						<div class="row">
							<a class="col-md-8" href="#" class="d-block">sally(병아리)</a>
						</div>
					</div>
				</div>

				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column subMenuList" data-widget="treeview" data-accordion="false">

					</ul>
				</nav>
				<!-- /.sidebar-menu -->
			</div>

			<!-- /.sidebar -->
		</aside>


		<div id="if_list_div" style="position: relative; padding: 0; overflow: hidden;">
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">

				<!-- Main content -->
				<section class="content register-page" style="height:100%;">
					<div class="container-fluid">
						<div class="login-logo">
							<b>회원 수정 페이지</b>
						</div>
						<!-- form start -->
						<div class="card">
							<div class="register-card-body">
<!-- 								<form id="frm" role="form" class="form-horizontal" enctype="multipart/form-data" > -->
								<form id="frm" role="form" class="form-horizontal" enctype="multipart/form-data" action="/spring/profile" method="get">
									<div class="input-group mb-3">
										<div class="mailbox-attachments clearfix" style="text-align: center; width:100%;">
											<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
												<a href="/spring/profileDownload?userid=${modifylist.userid }">
                                       <img id="pictureViewImg" style="width:100%; height:100%;" src="/spring/profile?userid=${modifylist.userid }"/>
                                    </a>
											</div>
											<div class="mailbox-attachment-info">
												<div class="input-group input-group-sm">
													<input id="picture" class="form-control"
														   type="file" name="file" accept=".gif, .jpg, .png" style="height:37px;"/>
												</div>
											</div>
										</div>
										<br />
									</div>
									
									<div class="form-group row">
										<label for="userid" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>아이디
										</label>
										<div class="col-sm-9 input-group-sm">
											<input type="hidden" name="userid" value="${modifylist.userid }"/>
											<span class="input-group-append-sm">${modifylist.userid }</span>
										</div>
									</div>
									
										
									
									<div class="form-group row">
										<label for="pass" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>패스워드</label>
										<div class="col-sm-9 input-group-sm">
										<input class="form-control" name="pass" type="password" id="pass" placeholder="비밀번호" value="${modifylist.pass }"/>
										</div>
									</div>
									
									<div class="form-group row">
										<label for="name" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>이 름
										</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="usernm" type="text" id="usernm" placeholder="이름" value="${modifylist.usernm }"/>
										</div>

									</div>
									<div class="form-group row">
										<label for="alias" class="col-sm-3" style="font-size: 0.9em;">별명</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="alias" type="text" id="alias" placeholder="별명" value="${modifylist.alias }">
										</div>
									</div>
									<div class="form-group row">
										<label for="addr1" class="col-sm-3 control-label">주소</label>
										<div class="col-sm-3 input-group-sm">
											<input name="addr1" type="text" class="form-control" id="addr1" placeholder="주소" value="${modifylist.addr1 }" readonly>
										</div>
										<div class="col-sm-3 input-group-sm">
											<input name="addr2" type="text" class="form-control" id="addr2" placeholder="상세주소" value="${modifylist.addr2 }">	
										</div>
										
										<div class="col-sm-2 input-group-sm">
											<input name="zipcode" type="text" class="form-control" id="zipcode" placeholder="우편번호" value="${modifylist.zipcode }" readonly>
										</div>
										<div class="col-sm-1 input-group-sm">
											<span class="input-group-append-sm">
												<button type="button" id="addrbtn" class="btn btn-info btn-sm btn-append">주소검색</button>
											</span>
										</div>
									</div>
									
									<div class="card-footer">
										<div class="row">
											<div class="col-sm-6">
												<button type="button" id="updatebtn" class="btn btn-info">수정</button>
											</div>

											<div class="col-sm-6">
												<button type="reset" id="cancelBtn"  class="btn btn-default float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
											</div>

										</div>
									</div>
								</form>
							</div>
							<!-- register-card-body -->
						</div>
					</div>
				</section>
				<!-- /.content -->
			</div>
			<!-- /.content-wrapper -->
		</div>
	</div>

	<%@ include file="../common/footer.jsp"%>
	
	
	<script>
		$(document).ready(function(){
			// picture input의 파일 변경시 이벤트 
			$("#picture").change(function(){
			   readURL(this);
			});
			
		});
		
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
			  
				reader.onload = function (e) {
					$('#pictureViewImg').attr('src', e.target.result);  
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
			 
		
	</script>
</body>
</html>







