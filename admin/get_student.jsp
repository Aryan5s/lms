<%@page import="java.sql.*"%>
<%
	PreparedStatement ps;
        Connection conn;
        ResultSet rs= null;
        conn=(Connection)application.getAttribute("connection");
%>

<%
String studentid=request.getParameter("studentid");

if(studentid!=null)
{
	studentid=studentid.toUpperCase();
 
	String sql ="SELECT FullName,Status FROM tblstudents WHERE StudentId=?";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setString(1,studentid);
	rs=ps.executeQuery();

	if(rs.next())
	{
		if(Integer.parseInt(rs.getString("Status"))==0)
		{
			out.println("<span style='color:red'> Student ID Blocked </span> .<br />");
			out.println("<b>Student Name-</b> "+rs.getString("FullName"));	
			out.println("<script>$('#submit').prop('disabled',true);</script>");
		}
		else 
		{
  
			out.println("<span style='color:green'>"+rs.getString("FullName")+"</span>");
			out.println("<script>$('#submit').prop('disabled',false);</script>");

		}
	}
	else
	{
  
		out.println("<span style='color:red'> Invaid Student Id. Please Enter Valid Student id .</span>");
		out.println("<script>$('#submit').prop('disabled',true);</script>");
	}
}

%>
