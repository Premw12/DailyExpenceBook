<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html>
<head>
    <title>Add Friend</title>
    <style>
        body {
            font-family: Arial;
            margin: 0;
            background: #f5f5f5;
        }

        .header {
            background: #0d47a1;
            color: white;
            padding: 15px;
            font-size: 20px;
            display: flex;
            align-items: center;
        }

        .back-btn {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            margin-right: 10px;
        }

        .form-container {
            background: white;
            margin: 20px;
            padding: 20px;
            border-radius: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: #e91e63;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background: #c2185b;
        }

        .success-msg {
            background: #efe;
            color: #070;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .error-msg {
            background: #fee;
            color: #c00;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="header">
    <button class="back-btn" onclick="window.location.href='DashboardServlet'">←</button>
    Add Friend
</div>

<div class="form-container">
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        
        if (success != null) {
    %>
        <div class="success-msg">Friend added successfully!</div>
    <%
        }
        
        if (error != null) {
    %>
        <div class="error-msg">Failed to add friend. Please try again.</div>
    <%
        }
    %>

    <form action="AddFriendServlet" method="post">
        <div class="form-group">
            <label>Name</label>
            <input type="text" name="name" placeholder="Enter friend name" required>
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" placeholder="Enter address" required>
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" placeholder="Enter phone number" required maxlength="15">
        </div>

        <button type="submit" class="submit-btn">Add Friend</button>
    </form>
</div>

</body>
</html>