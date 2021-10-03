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
						<label>내용</label> <input class="form-control" rows="3"
							name='content' value='<c:out value="${board.content }"/>'
							readonly="readonly">
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name='writer'
							value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>
	
					<button type="button" class="btn btn-default modBtn">
						<a href="/board/modify?bno=<c:out value="${board.bno }"/>">수정</a>
					</button>
	
					<button type="button" class="btn btn-default listBtn">
						<a href="/board/list">목록으로</a>
					</button>

					<form id='operForm' action="/board/list" method="get">
						<input type="hidden" id="bno" name="bno" value="${board.bno}">
						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}"> <input
							type="hidden" name="keyword" value="${cri.keyword}"> <input
							type="hidden" name="type" value="${cri.type}">
					</form>
	
	
				</div>
			<!-- end panel - body -->
		</div>
		<!-- end - panel - body -->
	</div>
	<!-- end panel  -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>댓글
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">
					댓글 쓰기</button>
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<ul class="chat">
				
					<!-- start reply  -->
					
					<!-- end reply -->
				</ul>
				
				<!-- ./end ul -->
			</div>
			<!-- /.panel .chat-panel -->
			
			<div class="panel-footer"></div>
			
		</div>
	</div>
	<!-- ./ end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글 제목</label>
					<input class="form-control" name="reply" value="New Reply!!">
				</div>
				
				<div class="form-group">
					<label>댓글 작성자</label>
					<input class="form-control" name="replyer" value="replyer">
				</div>
				
				<div class="form-group">
					<label>댓글 작성 날짜</label>
					<input class="form-control" name="replyDate" value="2018-01-01 13:13">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">댓글 수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">댓글 삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">댓글 저장</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">취소</button>
				
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
					
	$(document).ready(function () {
		
		console.log(replyService);

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


<script type="text/javascript">

$(document).ready(function () {
	
	var bnoValue = '<c:out value = "${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		
		console.log("show list " + page);
		
		replyService.getList({
			bno : bnoValue, page: page || 1},
			
		function(replyCnt, list){
			
			console.log("replyCnt : "+ JSON.stringify(replyCnt));
			console.log("list : "+ JSON.stringify(list));
			console.log(JSON.stringify(list));
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			
			if(list == null || list.length == 0){
				
				return;
			}
			for(var i = 0, len = list.length || 0; i < len; i++){
				
				str += "<li class = 'left clearfix' data-rno='"+list[i].rno+"'>";
				str += "	<div><div class = 'header'><strong class = 'primary-font'>["
					+list[i].rno+"] "+list[i].replyer+"</strong>";
				str += "	<small class = 'pull-right text-muted'>"
					+ replyService.displayTime(list[i].replyDate)+"</small></div>";
				str += "	<p>"+list[i].reply+"</p></div></li>";
			}
			
			replyUL.html(str);
			
			showReplyPage(replyCnt);
		});//end function
			
	}//end showList
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt / 10.0);
		}

		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class = 'pagination pull-right'>";
		
		if(prev){
			
			str += "<li class = 'page-item'><a class = 'page-link' href = '" + (startNum - 1)+"'>이전</a></li>";
		}
		
		for(var i = startNum; i <= endNum; i++){
		
			var active = pageNum == i? "active" : "";
			
			str += "<li class = 'page-item "+active+" '><a class = 'page-link' href= '"+i+"'>"+i+"</a></li>";
		
		}
		
		if(next){
			str += "<li class = 'page-item'><a class = 'page-link' href= '"+(endNum+1)+"'>다음</a></li>";
	}
	
	str += "</ul></div>";
	
	console.log(str);
	
	replyPageFooter.html(str);	
			
		

}
	replyPageFooter.on("click", "li a", function(e) {
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum : "+ targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	})
	
	
	//모달
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name = 'reply']");
	var modalInputReplyer = modal.find("input[name = 'replyer']");
	var modalInputReplyDate = modal.find("input[name = 'replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	//닫기 버튼
	$("#modalCloseBtn").on("click", function(e){
		
		modal.modal("hide");
		
	});
	

	//등록 버튼
	$("#addReplyBtn").on("click", function(e){
		
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
		
	});
	
	
	modalRegisterBtn.on("click", function(e) {
		
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		
		replyService.add(reply, function(result) {
			
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(-1);
		});
		
	});
	
	//댓글 조회 클릭 이벤트 처리
	$(".chat").on("click", "li", function(e){
		
		var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply) {
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
			.attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
			
		});
		
		console.log(rno);

	});
	
	//수정처리
	modalModBtn.on("click", function (e){
	
		var reply = {rno : modal.data("rno"), reply : modalInputReply.val()};
		
		replyService.update(reply, function (result) {
			
			alert(result);
			modal.modal("hide");
			showList(1);
			
		});
	});

	//삭제처리
	modalRemoveBtn.on("click", function (e){
	
		var rno = modal.data("rno");
		
		replyService.remove(rno, function (result) {
			
			alert(result);
			modal.modal("hide");
			showList(1);
			
		});
	});
	
	
	
});

</script>




