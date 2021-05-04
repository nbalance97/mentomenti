<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

						<!-- 본문 닫는 태그부터 body 닫는 태그까지 포함-->

					</div>
					<!-- /.container-fluid -->

					<!-- Footer -->
					<footer class="sticky-footer">
						<div class="container my-auto">
							<div class="copyright text-center my-auto">
								<span>Copyright © KGU capstone design Kaptain 2021</span>
							</div>
						</div>
					</footer>
					<!-- End of Footer -->

				<!-- </section> -->
				</div>


			</div>
			<!-- End of Main Content -->


		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->


	<!-- topButton 클릭 시 사이트 맨 위로 이동하는 애니메이션 -->
	<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
	<script type="text/javascript">
		jQuery(function($){
			$('#topButton').on("click",function(){
				$("html, body").animate({scrollTop:0}, '500');
				return false;
			});
		});
	</script>	
	<!-- Scroll to Top Button-->
	<div class="scroll-to-top rounded" id="topButton"> <i
		class="fas fa-angle-up"></i>
	</div>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">로그아웃 하시겠습니까?</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<a class="btn btn-primary" href="processLogout">로그아웃</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 프로필 이미지 크기 조절 -->
	<%@include file="process/imgResizing.jsp" %>

	<!-- Bootstrap core JavaScript-->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<script src="resources/js/sb-admin-2.js"></script>
	<script src="resources/js/sb-admin-2.min.js"></script> 

</body>