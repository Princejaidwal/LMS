<%@page import="in.pandit.model.Lead"%>
<%@page import="in.pandit.dao.CompanyDao"%>
<%@page import="in.pandit.dao.LeadDao"%>
<%@page import="in.pandit.helper.CookiesHelper"%>
<%@page import="in.pandit.model.User"%>
<%@page import="in.pandit.dao.UserDao"%>
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


%>
<%
LeadDao leadDao = new LeadDao();
UserDao userDao = new UserDao();
CompanyDao companyDao = new CompanyDao();

User userCookie = CookiesHelper.getUserCookies(request, "user");
int companyCount = companyDao.getAllCompanyCount();
int userCount = userDao.getUserCount("User");
int adminCount = userDao.getUserCount("Admin");
int totalLeadCount = leadDao.getTotalLeadsCount();
int leadid = Integer.parseInt(request.getParameter("leadid"));
Lead lead = leadDao.getLeadById(leadid);
%>
<html>
	<head>
		<title>User Dashboard</title>
		<%@include file="./common/jsp/superadminhead.jsp" %>
</head>
<body>
	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // Preventing from back after logout.
		if(session.getAttribute("email") == null){%>
		<script type="text/javascript">
			alert('You are no longer logged in');
		</script>
	<%}%>
	<%if (request.getAttribute("messages") != null) {%>
		<script>swal('Thank You!', 'We will get in touch soon!', 'success')</script>
	<%}%>
	
	<%@include file="./common/jsp/superadminsidebar.jsp" %>
	<div id="main">
		<%@include file="./common/jsp/superadminnavbar.jsp" %>
		<%@include file="./common/jsp/superadmin-count-card.jsp" %>
		<hr class="divide">
		<div class="pe-2 ps-2">
			<p class="fs-2 text-white box-heading ">Add Comment</p>
		</div>
		<hr class="divide">
		<div class="main-container">
			<div class="p-2">
				<%try{
			String comment = (String)session.getAttribute("comment");
			if(comment != null){ %>
					<div class='alert alert-success alert-dismissible fade show'>
						<%= comment %>
					</div>
			<% 
				session.removeAttribute("comment");
				}
			}catch(Exception e){
				e.printStackTrace();
			} %>
			</div>
			<form action ="AddSuperAdminComment" method="post" class="form-container">
			    <div class="form-inner-container"  hidden="true">
		    	<label  hidden="true">Lead Id</label>
		    	<input  hidden="true" type="text" name="leadid" value="<%= request.getParameter("leadid") %>" required="required"/>
		    </div>
		    <div class="form-inner-container">
		    	<label>Comment</label>
		    	<textarea rows="5" class="form-control" name="comment" placeholder="Enter Your Comment" required="required"></textarea>
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
	<%@include file="./common/jsp/superadminfooter.jsp" %>
</body>
</html>