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
	String create=request.getParameter("create");
if(create!=null)
{
	String category=request.getParameter("category");
	String status=request.getParameter("status");
	String sql="INSERT INTO  tblcategory(CategoryName,Status,CreationDate) VALUES(?,?,?)";
	ps=conn.prepareStatement(sql);
	ps.setString(1,category);
	ps.setInt(2,Integer.parseInt(status));
	ps.setString(3,getDate());
	int i=ps.executeUpdate();


	if(i==0)
	{
		session.setAttribute("error","Something went wrong. Please try again");
		response.sendRedirect("manage-categories.jsp");
	}
	else 
	{
		session.setAttribute("msg","Brand Listed successfully");
		response.sendRedirect("manage-categories.jsp");
	}
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | Add Categories</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

</head>
<body>
      <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
    <div class="content-wra
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Add category</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3"">
<div class="panel panel-info">
<div class="panel-heading">
Category Info
</div>
<div class="panel-body">
<form role="form" method="post">
<div class="form-group">
<label>Category Name</label>
<input class="form-control" type="text" name="category" autocomplete="off" required />
</div>
<div class="form-group">
<label>Status</label>
 <div class="radio">
<label>
<input type="radio" name="status" id="status" value="1" checked="checked">Active
</label>
</div>
<div class="radio">
<label>
<input type="radio" name="status" id="status" value="0">Inactive
</label>
</div>

</div>
<button type="submit" name="create" value="create" class="btn btn-info">Create </button>

                                    </form>
                            </div>
                        </div>
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
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% } %>
