<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="dispaly-3">배송 정보</h1>
			</div>
		</div>
		<!-- 주문번호 생성 및 사용 -->
		<%
			// 세션 아이디 가져오기
			String sessionId = session.getId();
			
			// 현재 날짜와 시간 가져오기
			// 주문 할때 여러개가 한번에 들어오면 기존에 들어온 주문정보가 덮여쓰여저서 삭제될 수 있음
			// 날짜와시간을 지정해 주문정보를 나눔
			java.text.SimpleDateFormat simpleDatFormat = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
			String currentDateTime = simpleDatFormat.format(new java.util.Date());
			
			String orderId = currentDateTime + "-" + sessionId;
			
		%>
		<div class="container">
		<form action="./processShippingInfo.jsp" method="post">
		<input type="hidden" name="orderId" value="<%=orderId %>"> <!-- 사용자의 고유 번호, 굳이 사용자에게 보여줄 필요가 없고 수정이 되면 안됨 -->
			<div class="form-group row">
				<label class="col-sm-2">주문자 이름</label>
				<div class="col-sm-3">
					<input type="text" name="orderName" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">연락처</label>
				<div class="col-sm-3">
					<input type="text" name="tel" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" id="sample6_postcode" placeholder="우편번호" name="zipCode" readonly><!-- readonly : 입력창에 사용자가 직접 입력을 못하게 함, api를 통해 값은 받을 수 있음 -->
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" ><br> 
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-3">
					<input type="text" id="sample6_address" placeholder="주소" name="address01" readonly><br>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-3">
					<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address02">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-10">
					<a href="./cart.jsp" class="btn btn-secondary" role="button">이전</a>
					<input type="submit" class="btn btn-primary" value="등록">
				</div>
			</div>
	<jsp:include page="../inc/footer.jsp"/>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>