<%@page import="java.sql.*" %>
<%
String ses=(String)session.getAttribute("uid");

String chk=(String)session.getAttribute("chk");

if(ses==null)
{
	RequestDispatcher rd=request.getRequestDispatcher("studentpanel.jsp");
	rd.include(request,response);
}
if(chk==null)
{
	response.sendRedirect("checkprofile.jsp");
}
session.removeAttribute("chk");

String sesname=(String)session.getAttribute("uname");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="../images/favicon-32x32.png" sizes="32x32" />
<link rel="icon" type="image/png" href="../images/favicon-16x16.png" sizes="16x16" />
  <title>Edit Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="../scripts/jquery-3.2.1.min.js"> </script>
 <script src="../css/jquery-3.2.1.min.js"></script>
  <link rel="stylesheet" href="../css/bootstrap.min.css">
  <script src="../css/bootstrap.min.js"></script>
  
	
  
 
  <style type="text/css">
  p{
  color:blue;
  font-size:25px;
  }
  body{
    top:0;
    left:0;
    height:100%;
    width:100%;
    min-height:640px;
    margin:0px auto;
  background-image:url('../images/bg3.jpg');
  background-repeat: no-repeat;
    background-attachment:fixed;
    background-size:cover;
  }
  .dropdown-menu{
  background-color: transparent;
        background: transparent;
        border-color: transparent;
  }
  .para{
  font-family: 'Open Sans', Arial, Helvetica, sans-serif;
  background-color:rgba(0,0,0,0.7);
  color:white;
  border-radius:10px;
  border:1px solid #696969;
  position:relative;
  top:100px;
  width:600px;
  padding:30px;
  margin:0 auto;
  
  }
  .navbar li a{
  color:black;}
  .nav{
 background-color: transparent;
   background: transparent;
   border-color: transparent;}
   .nav ul li:hover{
   background-color: transparent;
   background: transparent;
   border-color: transparent;}
   
   .t1{
   padding:10px;
   height:450px;
   width:500px;
   text-align:center;
   position:relative;
   }
   th{
   font-size:20px;
   font-weight:normal;
   }
     ul.nav >li >a:hover{
   background-color: #000000;
	color: #FFFFFF;
}
ul.dropdown-menu >li >a:hover{
   background-color: #000000;
	color: #FFFFFF;
}
#hide{
display:none;}
   
.field{
text-align:right;
}
.update:hover{
opacity:0.7;}
.update{
background-color: #ff4d4d;
border:none;
border-radius: 5px;
color: #f4f4f4;
cursor: pointer;
font-family: 'Open Sans', Arial, Helvetica, sans-serif;
height: 40px;
width:200px;
outline:none;
}
.input{
background-color: #e5e5e5;
border:none;
font-weight:normal;
border-radius: 3px;
color: black;;
font-family: 'Open Sans', Arial, Helvetica, sans-serif;
font-size: 20px;
height: 35px;
width:220px;
outline: none;
padding: 0px 10px;
}
.t2{
   text-align:center;
   position:relative;
   }
  </style>
</head>
<body>
<nav class="navbar navbar-light navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
    </div>
    <ul class="nav nav-tabs">
      <li ><a href="welcomestudent.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
      <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="menu" aria-haspopup="true" aria-expanded="false">
          <span class="glyphicon glyphicon-user"></span> Profile <span class="caret"></span></a>
      <ul class="dropdown-menu">
      <li><a href="profile.jsp"><span class="glyphicon glyphicon-list-alt"></span> View Profile</a></li>
      <li><a href="checkprofile.jsp"><span class="glyphicon glyphicon-wrench"></span>  Edit Profile</a></li>
      </ul>
      </li>
      <li><a href="exam.jsp">Exams</a></li>
      <li><a href="result.jsp">Results</a></li>
      <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="menu" aria-haspopup="true" aria-expanded="false">
         <span class="glyphicon glyphicon-cog"></span> <%out.print(sesname); %></a>
      <ul class="dropdown-menu">
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-off"></span> Logout</a></li>
      </ul>
      
    </ul>
    
  </div>
  <script>
  $('ul.nav li.dropdown').hover(function() {
	  $(this).find('.dropdown-menu').stop(true, true).slideDown(250);
	}, function() {
	  $(this).find('.dropdown-menu').stop(true, true).slideUp(250);
	});
  </script>
</nav>
<%
ServletContext ob=getServletContext();
String duser=ob.getInitParameter("duser");
String dpass=ob.getInitParameter("dpass");
String cpath=ob.getInitParameter("cpath");
String connect=ob.getInitParameter("connect");
try{
	Class.forName(cpath);
	Connection con=DriverManager.getConnection(connect,duser,dpass);
	PreparedStatement ps=con.prepareStatement("select * from student where usid=?");
	ps.setString(1,ses);
	ResultSet rs=ps.executeQuery();
	if(rs.next())
	{
		%>
		<div align="center" class="para">
		<form action="editprofileaction.jsp" method="post">
		<table class="t1">
		<tr>
		<th>Name</th>
		<th class="field"><input required name="nm" class="input" class="input" type="text" value="<%out.print(rs.getString(1));%>" ></th>
		</tr>
		<tr>
		<th>Password</th>
		<th class="field"><input required name="ps" class="input" type="password" placeholder="New Password" ></th>
		</tr>
		<tr>
		<th>Branch</th>
		<th class="field">
		<select class="input" name="br" required>
		<option selected class="default"><%out.print(rs.getString(4));%></option>
		<option value="Civil">Civil</option>
		<option value="CSE">CSE</option>
		<option value="EE">EE</option>
		<option value="ETC">ETC</option>
		<option value="IT">IT</option>
		<option value="Mech">Mech</option>
		</select>
		</th>
		</tr>
		<tr>
		<th>DOB </th>
		<th class="field"><input required name="dob" class="input" type="text" value="<%out.print(rs.getString(5)); %>" ></th>
		</tr>
		<tr>
		<th>Mobile No.</th>
		<th class="field"><input required name="phno" class="input" type="text" value="<%out.print(rs.getString(6)); %>" ></th>
		</tr>
		<tr>
		<th>Email-Id</th>
		<th class="field"><input required name="ml" class="input" type="email" value="<%out.print(rs.getString(7)); %>" ></th>
		</tr>
		<tr>
		<br>
		<th colspan="2" style="text-align:center;"><input type="submit" style="border:none;" class="update"  value="Update"></th>
		</tr>
		</table>
		</form>
		<table class="t2">
		<tr>
		<th style="text-align:center;" id="val"></th>
		</tr>
		</table>
		</div>
		<%
		}
	con.close();
}
catch(Exception e)
{
	out.print(e);
}
%>

</body>
</html>