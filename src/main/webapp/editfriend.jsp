<%@ page import="com.dailyexpence.action.AddFriendAction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
 

    String friendName = request.getParameter("friendName");
    AddFriendAction dao = new AddFriendAction();
    String[] friend = dao.getFriendByName(friendName);

    if (friend == null) {
        response.sendRedirect("DashboardServlet");
        return;
    }
%>

<html>
<head>
    <title>Edit Friend</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial;
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
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 16px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #0d47a1;
        }

        .submit-btn {
            width: 100%;
            padding: 18px;
            background: #1565c0;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background: #0d47a1;
        }

        .delete-btn {
            width: 100%;
            padding: 18px;
            background: #e91e63;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 15px;
        }

        .delete-btn:hover {
            background: #c2185b;
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
    <button class="back-btn"
            onclick="window.location.href='FriendDetailsServlet?friendName=<%= friend[0] %>'">←</button>
    Edit Friend
</div>

<div class="form-container">

    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error-msg">Failed to update. Please try again!</div>
    <%
        }
    %>

    <form action="EditFriendServlet" method="post">
        <input type="hidden" name="oldName" value="<%= friend[0] %>">

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="name"
                   value="<%= friend[0] %>"
                   placeholder="Enter name" required>
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address"
                   value="<%= friend[1] != null ? friend[1] : "" %>"
                   placeholder="Enter address">
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone"
                   value="<%= friend[2] != null ? friend[2] : "" %>"
                   placeholder="Enter phone number"
                   maxlength="15">
        </div>

        <button type="submit" class="submit-btn">Update Friend</button>
    </form>

    <button class="delete-btn" onclick="confirmDelete()">Delete Friend</button>

</div>

<script>
function confirmDelete() {
    if (confirm('Are you sure? All expenses of this friend will also be deleted!')) {
        window.location.href = 'DeleteFriendServlet?friendName=<%= friend[0] %>';
    }
}
</script>

</body>
</html>