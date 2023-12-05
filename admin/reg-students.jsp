<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%!
	public static String getDate()
    
	{
        
		DateFormat df=new SimpleDateFormat("d-MMM-yyyy");
        
		String exam_date=df.format(new Date());
         
		return exam_date;
    
	}
%>
<%
	PreparedStatement ps;
        Connection conn;
        ResultSet rs= null;
        conn=(Connection)application.getAttribute("connection");
%>


<%

if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else
{ 
	// code for block student    

	String id=request.getParameter("inid");
	if(id!=null)
	{
		int status=0;
		String sql = "update tblstudents set Status=?,UpdationDate=?  WHERE id=?";
		ps=conn.prepareStatement(sql);
		ps.setInt(1,status);
		ps.setString(2,getDate());
		ps.setInt(3,Integer.parseInt(id));
		ps.executeUpdate();
		response.sendRedirect("reg-students.jsp");
	}


	//code for active students

	id=request.getParameter("id");	
	if(id!=null)
	{
		int status=1;
		String sql = "update tblstudents set Status=?,UpdationDate=?  WHERE id=?";
		ps=conn.prepareStatement(sql);
		ps.setInt(1,status);
		ps.setString(2,getDate());
		ps.setInt(3,Integer.parseInt(id));
		ps.executeUpdate();
		response.sendRedirect("reg-students.jsp");
	}


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | Manage Reg Students</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- DATATABLE STYLE  -->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

</head>
<body>
      <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Manage Reg Students</h4>
    </div>


        </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Reg Students
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Student ID</th>
                                            <th>Student Name</th>
                                            <th>Email id </th>
                                            <th>Mobile Number</th>
                                            <th>Reg Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
String sql = "SELECT * from tblstudents";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

int cnt=1;
while(rs.next())
{
              
%>                                      
	<tr class="odd gradeX">
	<td class="center"><%=cnt%></td>
	<td class="center"><%=rs.getString("StudentId")%></td>
	<td class="center"><%=rs.getString("FullName")%></td>
	<td class="center"><%=rs.getString("EmailId")%></td>
	<td class="center"><%=rs.getString("MobileNumber")%></td>
	<td class="center"><%=rs.getString("RegDate")%></td>
	<td class="center">
<%
	 if(rs.getInt("Status")==1)
	 {
		out.println("Active");
	 } 
	 else 
	 {
		out.println("Blocked");
	 }
%>	
	</td>
	<td class="center">
<%
	if(rs.getInt("Status")==1)
 	{
%>
		<a href="reg-students.jsp?inid=<%=rs.getInt("id")%>" onclick="return confirm('Are you sure you want to block this student?');"" >  <button class="btn btn-danger"> Inactive</button>
<% 
	} 
	else 
	{
%>
		<a href="reg-students.jsp?id=<%=rs.getInt("id")%>" onclick="return confirm('Are you sure you want to active this student?');""><button class="btn btn-primary"> Active</button> 
<% 
	} 
%>
                                          
                                            </td>
                                        </tr>
<% cnt=cnt+1;
} 
%>                                      
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>


            
    </div>
    </div>

     <!-- CONTENT-WRAPPER SECTION END-->
<jsp:include page="includes/footer.jsp" />
      <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<%
} 
%>
