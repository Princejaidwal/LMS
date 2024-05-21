<%@page import="in.pandit.model.Lead"%>
<%@page import="in.pandit.dao.LeadDao"%>
<%@page import="in.pandit.helper.CookiesHelper"%>
<%@page import="in.pandit.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import = "in.pandit.persistance.DatabaseConnection" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%@page import = "java.util.Date" %>
<%
String namedb = null;
String emaildb = null;
String commentId = request.getParameter("comment-id");
String userId = request.getParameter("user-id");
int leadId = Integer.parseInt(request.getParameter("lead-id"));
String userEmail = request.getParameter("user-email");
String comment = request.getParameter("comment");
String email = (String)session.getAttribute("email");
if(!userEmail.equals(email)) {
	response.sendRedirect("allLeadsSuperAdmin.jsp");
}

%>
<%
User userCookie = CookiesHelper.getUserCookies(request, "user");
LeadDao leadDao = new LeadDao();
int companyId = userCookie.getCompanyId();
int totalLeadCount = leadDao.getTotalLeadsCountByCompanyId(companyId);
int totalLeadCountBySource = leadDao.getLeadsCountUsingSourceFacebookOrGoogleAndCompanyId(companyId);
int totalLeadCountNewLeads = leadDao.getLeadsCountNewLeadsByCompanyId(companyId);
int totalLeadCountByStatusFinished = leadDao.getLeadsCountUsingCompanyIdAndStatus(companyId, "Already Enrolled");
Connection connect = DatabaseConnection.getConnection();
Lead lead = leadDao.getLeadById(leadId);
%>
<html>
	<head>
		<title>User Dashboard</title>
		<%@include file="./common/jsp/head.jsp" %>
</head>
<body>
	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // Preventing from back after logout.
		if(session.getAttribute("email") == null){%>
		<script type="text/javascript">
			alert('You are no longer logged in');
		</script>
	<%response.sendRedirect("index.jsp");}%>
	<%if (request.getAttribute("messages") != null) {%>
	<script>swal('Thank You!', 'We will get in touch soon!', 'success')</script>
	<%}%>
	
	<%@include file="./common/jsp/sidebar.jsp" %>
	<div id="main">
		<%@include file="./common/jsp/navbar.jsp" %>
		<%@include file="./common/jsp/count-card.jsp" %>
		<div class="pe-2 ps-2">
			<p class="fs-2 text-white box-heading">Update Comment</p>
		</div>
		<hr class="divide">
		<div class="main-container">
			<form action ="UpdateUserComment" method="post" class="form-container">
			    <div class="form-inner-container" hidden="true">
			    	<input  hidden="true" type="text" name="comment-id" value="<%= commentId %>"  required="required" />
			    </div>
			    <div class="form-inner-container">
			    	<label>Comment</label>
			    	<textarea rows="5" class="form-control" name="comment" required="required"><%= comment  %></textarea>
			    </div>
			    <div class="form-inner-container">
			    	<label class="fs-5 mb-2 mt-2">Lead Status</label>
					<select name = "status" class="form-control" required>
						<option selected ><%= lead.getStatus()%></option>
						<%if(!lead.getStatus().equals("New")){ %><option value="New">New</option><%} %>
						<%if(!lead.getStatus().equals("Not Interested")){ %><option value="Not Interested">Not Interested</option><%} %>
						<%if(!lead.getStatus().equals("In Conversation")){ %><option value="In Conversation">In Conversation</option><%} %>
						<%if(!lead.getStatus().equals("Follow Up")){ %><option value="Follow Up">Follow Up</option><%} %>
						<%if(!lead.getStatus().equals("DNP")){ %><option value="DNP">DNP</option><%} %>
						<%if(!lead.getStatus().equals("Not Reachable")){ %><option value="Not Reachable">Not Reachable</option><%} %>
						<%if(!lead.getStatus().equals("Mobile Switched Off")){ %><option value="Mobile Switched Off">Mobile Switched Off</option><%} %>
						<%if(!lead.getStatus().equals("Not Working")){ %><option value="Not Working">Not Working</option><%} %>
						<%if(!lead.getStatus().equals("Already Enrolled")){ %><option value="Already Enrolled">Already Enrolled</option><%} %>
					</select>
			    </div>
			    <div class="btn-container">
					<input type="submit" class="submit-btn" value="Submit"/>
			    </div>
			</form>
		</div>
	</div>	
<%@include file="./common/jsp/footer.jsp" %>
</body>
</html>