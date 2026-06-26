<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="RegisterServlet">
Name:<input type="text" name="name"/><br><br>

Contact:<input type="text" name="phoneno"/><br><br>

Email:<input type="email" name="email"/><br><br>
New Password:<input type="password" name="newpassword"/><br><br>
Confirm Password:<input type="password" name="confirmpassword"/><br><br>
<input type="submit" value="Register" name="register">

</form>
</body>
</html>