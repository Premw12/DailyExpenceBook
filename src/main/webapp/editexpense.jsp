<%@ page import="com.dailyexpence.action.ExpenseAction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  
    String id = request.getParameter("id");
    ExpenseAction dao = new ExpenseAction();
    String[] expense = dao.getExpenseById(id);

    if (expense == null) {
        response.sendRedirect("DashboardServlet");
        return;
    }
%>

<html>
<head>
    <title>Edit Expense</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 16px;
        }

        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="number"]:focus,
        textarea:focus {
            outline: none;
            border-color: #0d47a1;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .radio-group {
            display: flex;
            gap: 30px;
            margin-top: 10px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .radio-option input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #0d47a1;
        }

        .radio-option label {
            margin: 0;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
        }

        .get-label {
            color: red;
        }

        .gave-label {
            color: green;
        }

        /* Update button - same blue as screenshot */
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

        /* Delete button - same pink as screenshot */
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

        .friend-label {
            color: #0d47a1;
            font-size: 15px;
            margin-bottom: 20px;
            padding: 10px;
            background: #e8eaf6;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="header">
    <button class="back-btn"
            onclick="window.location.href='FriendDetailsServlet?friendName=<%= expense[1] %>'">←</button>
    Edit Expense
</div>

<div class="form-container">

    <div class="friend-label">
        👤 Friend: <strong><%= expense[1] %></strong>
    </div>

    <form action="EditExpenseServlet" method="post">
        <input type="hidden" name="id"         value="<%= expense[0] %>">
        <input type="hidden" name="friendName" value="<%= expense[1] %>">

        <!-- Type -->
        <div class="form-group">
            <label>Type</label>
            <div class="radio-group">
                <div class="radio-option">
                    <input type="radio" id="get" name="type" value="get"
                           <%= expense[4].equals("get") ? "checked" : "" %> required>
                    <label for="get" class="get-label">You will GET</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="gave" name="type" value="gave"
                           <%= expense[4].equals("gave") ? "checked" : "" %> required>
                    <label for="gave" class="gave-label">You GAVE</label>
                </div>
            </div>
        </div>

        <!-- Amount -->
        <div class="form-group">
            <label>Amount (₹)</label>
            <input type="number" name="amount"
                   value="<%= expense[2] %>"
                   required step="0.01" min="0"
                   placeholder="Enter amount">
        </div>

        <!-- Note -->
        <div class="form-group">
            <label>Note</label>
            <textarea name="note"
                      placeholder="Add note (optional)"><%= expense[3].equals("No note") ? "" : expense[3] %></textarea>
        </div>

        <!-- Update Button -->
        <button type="submit" class="submit-btn">Update Expense</button>
    </form>

    <!-- Delete Button -->
    <button class="delete-btn" onclick="confirmDelete()">Delete Expense</button>

</div>

<script>
function confirmDelete() {
    if (confirm('Are you sure you want to delete this expense?')) {
        window.location.href = 'DeleteExpenseServlet?id=<%= expense[0] %>&friendName=<%= expense[1] %>';
    }
}
</script>

</body>
</html>