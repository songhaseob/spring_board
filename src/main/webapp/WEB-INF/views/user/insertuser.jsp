<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>회원 등록</title>


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
	
// 	$('#registBtn').on("click",function(){
// 			$('#frm').attr("method","post");
// 			$('#frm').attr("action","/spring/insertUser");
// 			$('#frm').submit();
			
// 		})
	var status = 1
            
         $('#userid').keydown(function(){
            if( $('#userid').val() == "" ){
               status = 1
            }
         })
         
         $('#pass').keydown(function(){
            if( $('#pass').val() == "" ){
               status = 1
            }
         })
         
         $('#usernm').keydown(function(){
            if( $('#usernm').val() == "" ){
               status = 1
            }
         })
         
         $('#registBtn').on('click',function(){
            if( $('#userid').val() != "" && $('#pass').val() != "" && $('#usernm').val() != "" ){
               status = 0;      
            }
            if(status == 1){
               alert('필수항목 *에 대해 입력해주세요');
            }else{
               $('#frm').attr("method", "post");
               $('#frm').attr("action", "/spring/insertUser");
               $('#frm').submit();
            }
      
         })

})

</script>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<%@ include file="../common/nav.jsp" %>


		<div id="if_list_div" style="position: relative; padding: 0; overflow: hidden;">
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">

				<!-- Main content -->
				<section class="content register-page" style="height:100%;">
					<div class="container-fluid">
						<div class="login-logo">
							<b>회원 등록</b>
						</div>
						<!-- form start -->
						<div class="card">
							<div class="register-card-body">
								<form id="frm" role="form" class="form-horizontal" enctype="multipart/form-data" >
									<div class="input-group mb-3">
										<div class="mailbox-attachments clearfix" style="text-align: center; width:100%;">
											<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
												<img id="pictureViewImg" style="width:100%; height:100%;"/>
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
										<label for="id" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>아이디
										</label>
										<div class="col-sm-9 input-group-sm">
											<input name="userid" type="text" class="form-control" id="userid" placeholder="회원 id">
										</div>
									</div>
									
										
									
									<div class="form-group row">
										<label for="pwd" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>패스워드</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="pass" type="password" class="form-control" id="pass" placeholder="비밀번호" />
										</div>
									</div>
									
									<div class="form-group row">
										<label for="name" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>이 름
										</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="usernm" type="text" id="usernm" placeholder="이름" />
										</div>

									</div>
									<div class="form-group row">
										<label for="alias" class="col-sm-3" style="font-size: 0.9em;">별명</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="alias" type="text" id="alias" placeholder="별명">
										</div>
									</div>
									<div class="form-group row">
										<label for="addr1" class="col-sm-3 control-label">주소</label>
										<div class="col-sm-3 input-group-sm">
											<input name="addr1" type="text" class="form-control" id="addr1" placeholder="주소" readonly>
										</div>
										<div class="col-sm-3 input-group-sm">
											<input name="addr2" type="text" class="form-control" id="addr2" placeholder="상세주소">	
										</div>
										
										<div class="col-sm-2 input-group-sm">
											<input name="zipcode" type="text" class="form-control" id="zipcode" placeholder="우편번호" readonly>
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
												<button type="button" id="registBtn" class="btn btn-info">등록</button>
											</div>

											<div class="col-sm-6">
												<button type="reset" id="cancelBtn" onclick="CloseWindow();" class="btn btn-default float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
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
			$('#addrBtn').on("click",function(){
				
			    new daum.Postcode({
			        oncomplete: function(data) {
			        	
			            $('#addr1').val(data.roadAddress); // 도로주소
			            $('#zipcode').val(data.zonecode);    // 우편번호 
			            
			            // 사용자 편의성을 위해 상세주소 입력 input 태그로 focus 설정
			            $('#addr2').focus();
			            
			        }
			    }).open();
				})
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







