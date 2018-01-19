<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<title>TechFanHub</title>
		<link href="/stylesheets/loginStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/mainStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/sideBarStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/headerStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/optionBarStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/footerStylesheet.css" rel="stylesheet" type="text/css"/>
		<link href="/stylesheets/HRSelectionStylesheet.css" rel="stylesheet" type="text/css"/>
		<script type="text/JavaScript" src="/javascript/sideBarOptionBar.js"></script>
		<script type="text/JavaScript" src="/javascript/visibilityToggle.js"></script>
		<script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		  ga('create', 'UA-63721022-1', 'auto');
		  ga('send', 'pageview');
		</script>
	</head>


	<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user != null){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key userKey = KeyFactory.createKey("Employee", "default");
		Filter empEmailFilter = new FilterPredicate("Login Email", Query.FilterOperator.EQUAL, user.getEmail().toLowerCase());
		Query loggedEmpQuery = new Query("Employee", userKey).setFilter(empEmailFilter);
		Entity loggedUser = datastore.prepare(loggedEmpQuery).asSingleEntity();
		if (loggedUser != null) {
			pageContext.setAttribute("nickname", loggedUser.getProperty("Nickname"));
			Filter empStatusFilter = new FilterPredicate("Status", FilterOperator.EQUAL, "Current");
			Query empQuery = new Query("Employee", userKey).setFilter(empStatusFilter).addSort("First Name", Query.SortDirection.ASCENDING);
			List<Entity> employees = datastore.prepare(empQuery).asList(FetchOptions.Builder.withDefaults());
	%>
	<body>
		<div class="mainInterface">
			<table class="header" id="HRHeader">
				<tr>
					<td class="headerItem" id="sidebarButton"><img src="/images/Sidebar_HR.png" id="SideBarButtonImg" onclick="toggleSideBar()"/></td>
					<td class="headerItem" id="logoButton"><a href="/Home.jsp"><img src="/images/Technos_Logo_HR.png" id="LogoButtonImg"/></a></td>
					<td class="headerItem" id="searchArea">
						<div class="headerCenterBar"></div>
					</td>
	<%
			String userStatus = (String) loggedUser.getProperty("Status");
			if(userStatus.equals("Workstation")){
	%>
					<td class="headerItem" id="userProfile">Welcome, ${fn:escapeXml(nickname)}!</td>
	<%
			}else{
	%>
					<td class="headerItem" id="userProfile"><a id="userProfileLink" href="/EditProfileForm.jsp">Welcome, ${fn:escapeXml(nickname)}!</a></td>
	<%
			}
	%>
					<td class="headerItem" id="optionButton" onclick="toggleOptionBar()">Options</td>
				</tr>
			</table>
			<div class="sideBar" id="sideBar">
				<div class="sidebarHeader" id="HomeLabel"><a id="HomeLink" href="Home.jsp"><img src="/images/Home_Icon.png" class="HomeIcon"/>HOME</a></div>
				<%
				if ((Boolean) loggedUser.getProperty("Management Tools Access")){
				%>
				<div class="sidebarHeader" id="ToolsLabel">Management Tools</div>
				<a class="sidebarOption" href="UploadMasterList.jsp">Upload Master List</a>
				<a class="sidebarOption" href="JobStatus.jsp">Job Status</a>
				<a class="sidebarOption" href="StatusbyPosition.jsp">Status by Position</a>
				<a class="sidebarOption" href="EmployeeScheduleTasks.jsp">Employee Schedules</a>
				<a class="sidebarOption" href="JobScheduleTasks.jsp">Job Timelines</a>
				<%
				}
				if ((Boolean) loggedUser.getProperty("Shop Job Access")){
				%>
				<div class="sidebarHeader" id="ShopLabel">Shop</div>
				<a class="sidebarOption" href="ShopJobSelection.jsp">Jobs</a>
				<a class="sidebarOption" href="ShopJobCalendar.jsp">Calendar</a>
				<%
				}
				if ((Boolean) loggedUser.getProperty("Field Job Access")){
				%>
				<div class="sidebarHeader" id="FieldLabel">Field</div>
				<a class="sidebarOption" href="FieldJobSelection.jsp">Jobs</a>
				<a class="sidebarOption" href="FieldJobCalendar.jsp">Calendar</a>
				<%
				if ((Boolean) loggedUser.getProperty("Site Specific Access")){
				%>
				<a class="sidebarOption" href="SiteSpecific.jsp">Site Specific</a>
				<%
				}}
				%>
				<div class="sidebarHeader" id="HRLabel">Human Resources</div>
				<a class="sidebarOption" href="HumanResourcesSelection.jsp">Employees</a>
				<a class="sidebarOption" href="HumanResourcesCalendar.jsp">Calendar</a>
				<%
				if ((Boolean) loggedUser.getProperty("Admin Timeclock Access")){
				%>
				<a class="sidebarOption" href="AdminTimeclock.jsp">Admin Timeclock</a>
				<%
				}
				%>
				<a class="sidebarOption" href="HumanResourcesTimeOffRequest.jsp">Request Time Off</a>
				<%
				if ((Boolean) loggedUser.getProperty("Time Approval Access")){
				%>
				<a class="sidebarOption" href="TimeApprovals.jsp">Time Approvals</a>
				<%
				}
				if ((Boolean) loggedUser.getProperty("Payroll Access")){
				%>
				<a class="sidebarOption" href="PayrollOverview.jsp">Payroll Overview</a>
				<%
				}
				if ((Boolean) loggedUser.getProperty("Individual Time Access")){
				%>
				<a class="sidebarOption" href="IndividualTime.jsp">Individual Time</a>
				<%
				}
				%>
				<div class="sidebarHeader" id="KBLabel">Knowledge Base</div>
				<a class="sidebarOption" href="Reference.jsp">Documents</a>
				<a class="sidebarOption" href="ReferenceVideos.jsp">Videos</a>
				<a class="sidebarOption" href="Contact.jsp">Contact</a>
			</div>
			<div class="mainArea" id="mainArea">
				<div class="SelectionArea" id="JobSelectionArea">
				<%
					if (employees.isEmpty()) {
				%>
					<div style="width:100%;font-size:5vmin;text-align:center;padding-top:20px;">There are no current employees to display at this time</div>
				<%
					} else {
					for (Entity employee : employees) {
						pageContext.setAttribute("emp_firstName", employee.getProperty("First Name"));
						pageContext.setAttribute("emp_lastName", employee.getProperty("Last Name"));
						String location = (String) employee.getProperty("Location");
						String classList = "SelectionItem Manufacturing";
						if(location.contains("Office")){
							classList = "SelectionItem Administration";
						}
						if(location.contains("Field")){
							classList = "SelectionItem Service";
						}
						pageContext.setAttribute("classList", classList);
						Long empID = (Long) employee.getProperty("Number");
						pageContext.setAttribute("emp_ID", empID);
						String empLink = "HumanResourcesDetails.jsp?Number=" + empID;
						pageContext.setAttribute("emp_link", empLink);
				%>
						<a class="${classList}" href=${fn:escapeXml(emp_link)}>${fn:escapeXml(emp_firstName)} ${fn:escapeXml(emp_lastName)} - ${fn:escapeXml(emp_ID)}</a>
				<%
					}}
				%>
				</div>
			</div>
			<div class="optionBar" id="optionBar">
				<div class="optionHeader">Options</div>
				<%
				if ((Boolean) loggedUser.getProperty("Human Resources Access")) {
				%>
				<a class="optionItem" href="AddEmployee.jsp">Add Employee</a>
				<%
				}
				if ((Boolean) loggedUser.getProperty("Safety Training Access")) {
				%>
				<a class="optionItem" href="SafetyTrainingForm.jsp">Add Safety Training</a>
				<a class="optionItem" href="TrainingSearch.jsp">Safety Training Search</a>
				<%
				}
				%>
				<a class="optionItem" href="HumanResourcesPrintableList.jsp" target="_blank">Print List</a>
				<div id="google_translate_element"></div>
				<script type="text/javascript">
					function googleTranslateElementInit() {
					  new google.translate.TranslateElement({pageLanguage: 'en', includedLanguages: 'es', layout: google.translate.TranslateElement.FloatPosition.TOP_LEFT}, 'google_translate_element');
					}
				</script>
				<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
			</div>
			<div class="footer" id="HRFooter">
				<div id="LegendSpacer"></div>
				<table id="LegendBackground">
					<tr>
						<td class="CalendarLabel" id="Manufacturing" onclick="toggle_hr_visibility(['Service','Administration']);">Manufacturing</td>
						<td class="CalendarLabel" id="Service" onclick="toggle_hr_visibility(['Manufacturing','Administration']);">Service</td>
						<td class="CalendarLabel" id="Administration" onclick="toggle_hr_visibility(['Service','Manufacturing']);">Administration</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<%
		}else{
			%>
				<div style="width: 100%; text-align: center; font-size: 300%; font-weight: bold; margin-top: 50px;">You have not been granted access to TechFanHub. Please contact the IT Department of Technos, Inc. for help.<br><br>
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Click here to Sign Out</a>
				</div>
			<%
		}
	} else {
	%>
	<body id="loginBody">
		<img src="/images/TechFanHub_Login.png" id="TechFahHubLoginImg"/>
		<div id="loginBar">
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>" id="loginLink">SIGN IN</a>
		</div>
	</body>
	<%
	}
	%>
</html>