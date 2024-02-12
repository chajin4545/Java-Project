<!-- 
	GROUP 3
	DIT/2A/01
	HA JIN 		P2100030
	ISAAC		P2107251
	GEORGE		P2143990
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;" />
<link href="https://unpkg.com/cirrus-ui" type="text/css"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/carousel.css">

</head>
<body>

	<%@ page import="model.User, model.UserManager, java.util.*" %>
	<%@ include file="admin_header.jsp" %>
	
	<%	
	
	%>
		
	<%--space --%>
	<div class="space space--xl ..."></div>
	<div class="space space ..."></div>

	<%--title --%>
	<div style="text-align: center">
		<h1>Users</h1>
	</div>
	
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10">
			<table class="table bordered">
					<%
					List<User> result = new ArrayList<User>();
					// user management results
					List<User> displayUsers = new ArrayList<User>();
					try { 
						result = (List<User>) request.getAttribute("reqUsers");
						displayUsers=(ArrayList<User>) request.getAttribute("mgmtUsers"); 
						if(displayUsers == null){
					%>	
<%-- ------------------------------------------- SHOW ALL USERS(NO FILTER APPLIED) ------------------------------------------- --%>				
					
					<thead>
					<tr>
						<th>User ID</th>
						<th>User Name</th>
						<th>Contact</th>
						<th>Email</th>
						<th>Role</th>
						<th><a href="#filter-modal"><button class="btn-link">Filter</button></a></th>
					</tr>
					</thead>
					<tbody>
						<% try { %>
						<% for (User i : result){  %>
							<tr>
								<% int uid = i.getUserid(); %>
								<% String uName = i.getUsername(); %>
								<% String uContact = i.getContact(); %>
								<% String uEmail = i.getEmail(); %>
								<% String uRole = i.getRole(); %>
								
								<td><%=uid %></td>
								<td><%=uName %></td>
								<td><%=uContact %></td>
								<td><%=uEmail %></td>
								<td><%=uRole %></td>
								<td><a href="#delete-<%=uid %>-modal"><button class="btn-danger">Delete User</button></a></td>
							
							</tr>
							
							<div class="modal" id="delete-<%=uid %>-modal">
								<a href="#searchModalDialog" class="modal-overlay close-btn"
									aria-label="Close"></a>
								<div class="modal-content" role="document">
									<div class="modal-header">
										<a href="#components" class="u-pull-right" aria-label="Close"><span
											class="icon"><svg aria-hidden="true" focusable="false"
													data-prefix="fas" data-icon="times"
													class="svg-inline--fa fa-times fa-w-11 fa-wrapper" role="img"
													xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512">
													<path fill="currentColor"
														d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg></span></a>
										<div class="modal-title">Delete User</div>
									</div>
									<div class="modal-body">
										<div>
											<p>Delete <%=uName %>?</p>
										</div>
						
									</div>
									<div class="modal-footer u-text-right">
										<a href="#components" class="u-inline-block">
											<button class="btn--sm">Cancel</button>
										</a> <a class="u-inline-block">
											<form action="/assignment2_jad_client/UserDeleteController" method="post">
												<button class="btn--sm btn-danger" type="submit" name="delete_user" value=<%=uid %>>Delete</button>
											</form>
										</a>
									</div>
								</div>
							</div>
							<% } %>
						<% } catch (Exception ex) {

							}
						} else{
						%>
<%--------------------------------------------- SHOW FILTERED USERS ------------------------------------------- --%>				

						<thead>
						<tr>
						<th>User ID</th>
						<th>User Name</th>
						<th>Contact</th>
						<th>Role</th>
						<th>Last logged in</th>
						<th><a href="#filter-modal"><button class="btn-link">Filter</button></a></th>
					</tr>
					</thead>
					<tbody>
						<% for (User i : displayUsers){  %>
							<tr>
								<% int uid = i.getUserid(); %>
								<% String uName = i.getUsername(); %>
								<% String uContact = i.getContact(); %>
								<% String uAdd = i.getAddress(); %>
								<% String uRole = i.getRole(); %>
								
								<td><%=uid %></td>
                                <td><%=uName %></td>
                                <td><%=uContact %></td>
                                <td><%=uAdd %></td>
                                <td><%=i.getLast_logged_in() %></td>
								<td><a href="#delete-<%=uid %>-modal"><button class="btn-danger">Delete User</button></a></td>
							
							</tr>
							
							<div class="modal" id="delete-<%=uid %>-modal">
								<a href="#searchModalDialog" class="modal-overlay close-btn"
									aria-label="Close"></a>
								<div class="modal-content" role="document">
									<div class="modal-header">
										<a href="#components" class="u-pull-right" aria-label="Close"><span
											class="icon"><svg aria-hidden="true" focusable="false"
													data-prefix="fas" data-icon="times"
													class="svg-inline--fa fa-times fa-w-11 fa-wrapper" role="img"
													xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512">
													<path fill="currentColor"
														d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg></span></a>
										<div class="modal-title">Delete User</div>
									</div>
									<div class="modal-body">
										<div>
											<p>Delete <%=uName %>?</p>
										</div>
						
									</div>
									<div class="modal-footer u-text-right">
										<a href="#components" class="u-inline-block">
											<button class="btn--sm">Cancel</button>
										</a> <a class="u-inline-block">
											<form action="/assignment2_jad_client/UserDeleteController" method="post">
												<button class="btn--sm btn-danger" type="submit" name="delete_user" value=<%=uid %>>Delete</button>
											</form>
										</a>
									</div>
								</div>
							</div>
						
						
						<%
							}
						} 
					}
						catch (Exception ex) { %>
						<% response.sendRedirect("admin_user");%>
					<% } %>
					
				</tbody>
				
				
					
				
			</table>
			
			
<%-----------------------------------------Filter modal START ------------------------------------------%>
							<div class="modal modal-large" id="filter-modal">
								<a href="#searchModalDialog" class="modal-overlay close-btn"
									aria-label="Close"></a>
								<div class="modal-content" role="document">
									<div class="modal-header">
										<a href="#components" class="u-pull-right" aria-label="Close"><span
											class="icon"><svg aria-hidden="true" focusable="false"
													data-prefix="fas" data-icon="times"
													class="svg-inline--fa fa-times fa-w-11 fa-wrapper" role="img"
													xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512">
													<path fill="currentColor"
														d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg></span></a>
										<div class="modal-title">User Filter</div>
									</div>
										<div class="modal-body" style="width:850px;">
										
											 <h6>ADDRESS / INACTIVE</h6>
											 <form action="/assignment2_jad_client/admin_user_filter" method="get">
											 <div class="form-group">
											 	<select class="form-group-input" id="category" name="userfilter" placeholder="Choose one">
											 	<option value="address">address</option>
											 	<option value="inactive">inactive</option>
											 	</select>
											 	<button class="form-group-btn btn-info" type="submit">APPLY</button>
											 </div>
											 </form>
											 <br>
											 
											 
											 <h6>User by name</h6>
											 <form action="/assignment2_jad_client/admin_user_filter" method="get">
											 	<div class="form-group">
											 	<label class="form-group-label" >NAME</label>
											 	<input type="text" class="form-group-input" name="userFilterName">
											 	<button class="form-group-btn btn-info" type="submit">APPLY</button>
											 	</div>
											 </form>
											 <br>
											 
											 
											 <h6>User by number</h6>
											 <form action="/assignment2_jad_client/admin_user_filter" method="get">
											 	<div class="form-group">
											 	<label class="form-group-label" >NUMBER</label>
											 	<input type="text" class="form-group-input" name="userFilterNumber">
											 	<button class="form-group-btn btn-info" type="submit">APPLY</button>
											 	</div>
											 </form>
											 <br>
											 
											 
											 <h6>BOOK FOR USER</h6>
											 <form action="/assignment2_jad_client/admin_book" method="POST">
                                                 <div class="form-group">
                                                 <label class="form-group-label">USERID</label>
                                                 <input type="text" class="form-group-input" name="adminbook_userid">
                                                 <label class="form-group-label">TOURID</label>
                                                 <input type="text" class="form-group-input" name="adminbook_tourid">
                                                 <label class="form-group-label">QUANTITY</label>
                                                 <input type="text" class="form-group-input" name="adminbook_quantity">
                                                 <button class="form-group-btn btn-info" type="submit">APPLY</button>
                                                 </div>
                                             </form>
										</div>
										 
										<div class="modal-footer u-text-right">
										</div>
									
								</div>
							</div>
		</div>
		<div class="col-1"></div>
	</div>
	
	<%@ include file="footer.html"%>
</body>
</html>