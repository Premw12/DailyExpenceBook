<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Expense</title>
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

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .radio-option input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .radio-option label {
            margin: 0;
            font-weight: normal;
            cursor: pointer;
        }

        .get-label {
            color: red;
        }

        .gave-label {
            color: green;
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

        .friend-name {
            color: #0d47a1;
            font-size: 18px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="header">
    <button class="back-btn" onclick="window.location.href='DashboardServlet'">←</button>
    Add Expense
</div>

<div class="form-container">
    <div class="friend-name">
        Friend: <strong><%= request.getParameter("friendName") %></strong>
    </div>

    <form action="AddExpenseServlet" method="post">
        <input type="hidden" name="friendName" value="<%= request.getParameter("friendName") %>">

        <div class="form-group">
            <label>Amount (₹)</label>
            <input type="number" name="amount" placeholder="Enter amount" required step="0.01" min="0">
        </div>

        <div class="form-group">
            <label>Note</label>
            <textarea name="note" placeholder="Add note (optional)"></textarea>
        </div>

        <div class="form-group">
            <label>Type</label>
            <div class="radio-group">
                <div class="radio-option">
                    <input type="radio" id="get" name="type" value="get" required>
                    <label for="get" class="get-label">You will GET</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="gave" name="type" value="gave" required>
                    <label for="gave" class="gave-label">You GAVE</label>
                </div>
            </div>
        </div>

        <button type="submit" class="submit-btn">Save Expense</button>
    </form>
</div>

</body>
</html>