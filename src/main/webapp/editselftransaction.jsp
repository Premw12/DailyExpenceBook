<%@ page import="com.dailyexpence.action.SelfTransactionAction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
   

    String id = request.getParameter("id");
    SelfTransactionAction dao = new SelfTransactionAction();
    String[] transaction = dao.getTransactionById(id);

    if (transaction == null) {
        response.sendRedirect("SelfExpenseServlet");
        return;
    }
%>

<html>
<head>
    <title>Edit Transaction</title>
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
        select,
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

        .income-label {
            color: green;
        }

        .expense-label {
            color: red;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background: #0a3570;
        }

        .delete-btn {
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

        .delete-btn:hover {
            background: #c2185b;
        }
    </style>
</head>
<body>

<div class="header">
    <button class="back-btn" onclick="window.location.href='SelfExpenseServlet'">←</button>
    Edit Transaction
</div>

<div class="form-container">
    <form action="EditSelfTransactionServlet" method="post">
        <input type="hidden" name="id" value="<%= transaction[0] %>">

        <div class="form-group">
            <label>Type</label>
            <div class="radio-group">
                <div class="radio-option">
                    <input type="radio" id="income" name="type" value="income" 
                           <%= transaction[4].equals("income") ? "checked" : "" %> required>
                    <label for="income" class="income-label">Income</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="expense" name="type" value="expense" 
                           <%= transaction[4].equals("expense") ? "checked" : "" %> required>
                    <label for="expense" class="expense-label">Expense</label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label>Amount (₹)</label>
            <input type="number" name="amount" value="<%= transaction[1] %>" required step="0.01" min="0">
        </div>

        <div class="form-group">
            <label>Category</label>
            <select name="category" required>
                <option value="">Select category</option>
                <option value="Food" <%= transaction[2].equals("Food") ? "selected" : "" %>>Food</option>
                <option value="Transport" <%= transaction[2].equals("Transport") ? "selected" : "" %>>Transport</option>
                <option value="Entertainment" <%= transaction[2].equals("Entertainment") ? "selected" : "" %>>Entertainment</option>
                <option value="Shopping" <%= transaction[2].equals("Shopping") ? "selected" : "" %>>Shopping</option>
                <option value="Bills" <%= transaction[2].equals("Bills") ? "selected" : "" %>>Bills</option>
                <option value="Health" <%= transaction[2].equals("Health") ? "selected" : "" %>>Health</option>
                <option value="Education" <%= transaction[2].equals("Education") ? "selected" : "" %>>Education</option>
                <option value="Salary" <%= transaction[2].equals("Salary") ? "selected" : "" %>>Salary</option>
                <option value="Freelance" <%= transaction[2].equals("Freelance") ? "selected" : "" %>>Freelance</option>
                <option value="Investment" <%= transaction[2].equals("Investment") ? "selected" : "" %>>Investment</option>
                <option value="Other" <%= transaction[2].equals("Other") ? "selected" : "" %>>Other</option>
            </select>
        </div>

        <div class="form-group">
            <label>Note</label>
            <textarea name="note"><%= transaction[3].equals("No note") ? "" : transaction[3] %></textarea>
        </div>

        <button type="submit" class="submit-btn">Update Transaction</button>
    </form>

    <button class="delete-btn" onclick="confirmDelete()">Delete Transaction</button>
</div>

<script>
function confirmDelete() {
    if (confirm('Are you sure you want to delete this transaction?')) {
        window.location.href = 'DeleteSelfTransactionServlet?id=<%= transaction[0] %>';
    }
}
</script>

</body>
</html>