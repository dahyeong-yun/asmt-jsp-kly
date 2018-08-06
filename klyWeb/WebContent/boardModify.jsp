<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body>

	<!-- 상단바(footer) -->
	<%@include file="./navbarTemplate.jsp" %>

	<!-- 본문 내용 -->
	<div class="container">
		<h2>Fading Modal</h2>
		<p>Add the "fade" class to the modal container if you want the modal to fade in on open and fade out on close.</p>

		<!-- Button to Open the Modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#board">
			Open modal
		</button>

        <!-- The Modal -->
        <form action="./boardWrite.kly" method="get" enctype="multipart/form-data" id="boardWrite" onsubmit="return alertSelectCategory()">
            <div class="modal fade" id="board">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">게시물 등록</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
							<div class="form-group" id="category">
 								<label for="category" style="display:inline;">게시판</label>
								<select class="form-control" name="category" id="selectedCategory">
									<option value = "select" selected="selected">게시판을 선택하세요</option><!-- '게시판을 선택하세요'입력하면 alert : '게시판을 선택하세요' --> 
									<option value = "free" >자유</option>
									<option value = "pubg">배그</option>
									<option value = "lol">롤</option>
									<option value = "animal">동물</option>
								</select>
                            </div>
						
							<input type = hidden name = "ID" value = "${loginInfo.getMEMBER_ID()}">
                        
                            <div id="subject">
                                <label for="subject" style="display:inline;">제목</label>
                                <input type="text" class="form-control" name="subject" placeholder="게시글 제목을 입력하세요" required>
                            </div>

                           <div id="video">
							<label for="video_upload">동영상 링크</label><!-- <input type="radio"
								id="video_upload" name="videoFile" value="upload"
								onclick="switchDisplay('input_upload');"> <label
								for="video">URL</label> <input type="radio" id="video_URL"
								name="videoURL" value="url"
								onclick="switchDisplay('input_url');">

							<div id="input_upload" style="display: none">
								<input type="file" name="file">
							</div> -->

							<div id="input_url">
								<input type="url" class="form-control" name="video_URL"
									value="http://">
							</div>
						</div>


                            <div id="tag">
                                <label for="tag">태그</label>
                                <input type="text"  class="form-control" name="tag" placeholder="태그와 태그는 해쉬태그로 구분하며, 10개까지 입력하실 수 있습니다.">
                                <!-- <input type="text" name="tagnames" id="tagnames" class="box_input _click(TagValidator|TagNames) _keyup(TagValidator|ValidateTagNames) _blur(TagValidator|ValidateTagNames)"> -->
                            </div>

                        </div>

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">등록</button><!-- data-dismiss="modal" -->
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>


</body>

<script>
	function alertSelectCategory() {
		var whatCategory = document.getElementById("selectedCategory");
		if (whatCategory.value == "select") {
			alert('게시판을 선택하세요.');
			document.getElementById("category").focus();
			return false;
		} else {
			return true;
		}
	}

    /*동영상 첨부 방식선택*/
    /* function switchDisplay(select) {
        if (select == "input_upload") {
            document.getElementById("input_upload").style.display = "";
            document.getElementById("input_url").style.display = 'none';
        } else {
             document.getElementById("input_upload").style.display = 'none';
            document.getElementById("input_url").style.display = "";
        }
    } */

</script>

</html>