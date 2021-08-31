<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 보기</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">내용</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			
			<div class="form-group">
						<label>#번호</label> <input class="form-control" name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
			</div>
			<div class="form-group">
						<label>제목</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly="readonly">
			</div>
			<div class="form-group">
						<label>내용</label> <input class="form-control" rows="3" name='content'
						value='<c:out value="${board.content }"/>' readonly="readonly">
			</div>
			<div class="form-group">
						<label>작성자</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly="readonly">
			</div>				

			<form id='operForm' action="/board/list" method="get">
				<input type="hidden" id="bno" name="bno" value = "${board.bno}">
				<input type="hidden" name="pageNum" value = "${cri.pageNum}">
				<input type="hidden" name="amount" value = "${cri.amount}">
				<input type="hidden" name="keyword" value = "${cri.keyword}">
				<input type="hidden" name="type" value = "${cri.type}">
			</form>


					<button type="button" class="btn btn-default modBtn">
					<a href="/board/modify?bno=<c:out value="${board.bno }"/>">수정</a>
					</button>

					<button type="button" class="btn btn-default listBtn">
					<a href="/board/list">목록으로</a>
					</button>

					<script type="text/javascript">
					
					$(document).ready(function () {
		
					//리스트 버튼
					var operForm = $("#operForm");
					
					$(".modBtn").on("click", function(e) {
						
						e.preventDefault();
						operForm.attr("action","modify");
						operForm.submit();
					});		
					
					
					$(".listBtn").on("click", function(e) {

						e.preventDefault();
						operForm.find("input[name='bno']").remove();
						operForm.submit();

						});		
					
					});
					</script>
					
			</div>
			<!-- end panel - body -->
		</div>
		<!-- end - panel - body -->
	</div>
	<!-- end panel  -->
</div>
<!-- /.row -->

<%@include file="../includes/footer.jsp"%>
