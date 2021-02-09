<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>회원 리스트</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
// 문서 로딩이 완료되고 나서 실행되는 영역
$(function(){
	$('.user').on("click",function(){
		// this : 클릭 이벤트가 발생 한 element
		// data - 속성명 data-userid, 속성명은 대소문자 무시하고 소문자로 인식
		// data-userId ==> data-userid
		var userid = $(this).data("userid");
		$('#userid').val(userid);
		$('#frm').attr("action","/spring/detailuser");
		$('#frm').submit();
	});
	
 	$("#count").on("change",function(){
 		
 		var vl = $(this).val();
 		
 		$('#ct').val(vl);
 		$('#frm').attr("action","/spring/paging");
 		$('#frm').submit();
		
		
 	})

 	$('#count').val('${pageVo.pageSize}');
	
//      ${'#searchType'}.on("change",function(){
//     	 var test = $(this).val();
//  		$('#sh').val(test);
//  		$('#frm').attr("action","${cp}/paging");
//  		$('#frm').submit();
//     })
     
     
});
</script>


</head>
<body class="hold-transition sidebar-mini">
	<form id="frm"  >
		<input type="hidden" id="userid" name="userid" value="">
		<input type="hidden" id="ct" name="pageSize" value="">
<!-- 		<input type="hidden" id="searchType" name="searchType" value=""> -->
<!-- 		<input type="hidden" id="keyword" name="keyword" value=""> -->
	</form>
	<div class="wrapper">

		<%@ include file="../common/nav.jsp" %>

		<div id="if_list_div" style="position: relative; padding: 0; overflow: hidden; height: 750px;">
			<div class="content-wrapper" style="min-height: 584px;">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="container-fluid">
						<div class="row md-2">
							<div class="col-sm-6">
								<h1>회원리스트</h1>
							</div>
							<div class="col-sm-6">
								<ol class="breadcrumb float-sm-right">
									<li class="breadcrumb-item">회원리스트</li>
									<li class="breadcrumb-item">목록</li>
								</ol>
							</div>
						</div>
					</div>
				</section>
				<!-- Main content -->
				<section class="content">
					<div class="card">
					
						<div class="card-header with-border">
						
							<a class="btn btn-primary" href="/spring/insertview">회원 등록</a>
							<div id="keyword" class="card-tools" style="width: 550px;">
								<div class="input-group row">
									<!-- sort num -->
									
									<select class="form-control col-md-3" name="count" id="count">
										<option value="">정렬개수</option>
										<option value="3">3개씩</option>
										<option value="5">5개씩</option>
										<option value="7">7개씩</option>
									</select>
									
									<!-- search bar -->
									<select class="form-control col-md-3" name="searchType" id="searchType">
										<option value="">검색구분</option>
										<option value="i">아이디</option>
										<option value="n">이름</option>
										<option value="a">별명</option>
									</select> 
									<input class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value=""> <span class="input-group-append">
										<button class="btn btn-primary" type="button" id="searchBtn" data-card-widget="search" onclick="searchList_go(1);">
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
									<!-- end : search bar -->
								</div>
							</div>
						</div>
						
						<div class="card-body" style="text-align: center;">
							<div class="row">
								<div class="col-sm-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th>아이디</th>
												<th>이름</th>
												<th>별명</th>
												<th>도로주소</th>
												<th>등록날짜</th>
												<!-- yyyy-MM-dd  -->
											</tr>
											<c:forEach items="${userList}" var="user">
											<tr class="user" data-userid="${user.userid}">
												<td>${user.userid}</td>
												<td>${user.usernm}</td>
												<td>${user.alias}</td>
												<td>${user.addr1}</td>
												<td><fmt:formatDate value="${user.reg_dt }" pattern="yyyy-MM-dd"/></td>
											</tr>
											</c:forEach>	
										</tbody>
									</table>
								</div>
								<!-- col-sm-12 -->
							</div>
							<!-- row -->
						</div>
						<!-- card-body -->
						
					 <div class="card-footer">
							<nav aria-label="member list Navigation">
								<ul class="pagination justify-content-center m-0">
									<li class="page-item"><a class="page-link" href="/spring/paging?page=1&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-double-left"></i></a></li>
									<c:choose>
										<c:when test="${pageVo.getPage()-1 <= 1 }">
									<li class="page-item"><a class="page-link" href="/spring/paging?page=1&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-left"></i></a></li>
										</c:when>
										<c:otherwise>
									<li class="page-item"><a class="page-link" href="/spring/paging?page=${pageVo.getPage()-1}&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-left"></i></a></li>
										</c:otherwise>
									</c:choose>
									<c:forEach begin="1" end="${pagination}" var="i">
									<c:choose>
										<c:when test="${pageVo.getPage() == i }">
									<li class="page-item active"><a class="page-link" href="/spring/paging?page=${i }&pageSize=${pageVo.getPageSize()}">${i}</a></li>
									</c:when>
										<c:otherwise>
									<li class="page-item"><a class="page-link" href="/spring/paging?page=${i }&pageSize=${pageVo.getPageSize()}">${i}</a></li>
									</c:otherwise>
									</c:choose>
									</c:forEach>
									<c:choose>
										<c:when test="${pageVo.getPage() == pagination }">
											<li class="page-item"><a class="page-link" href="/spring/paging?page=${pagination }&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-right"></i></a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="/spring/paging?page=${pageVo.getPage()+1}&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-right"></i></a></li>
										</c:otherwise>
										
									</c:choose>
									<li class="page-item"><a class="page-link" href="/spring/paging?page=${pagination}&pageSize=${pageVo.getPageSize()}"><i class="fas fa-angle-double-right"></i></a></li>
								</ul>
							</nav>

					</div>
						<!-- card-footer -->
					</div>
					<!-- card  -->
				</section>
			</div>
		</div>
	</div>

	<%@ include file="../common/footer.jsp"%>
	

</body>
</html>







