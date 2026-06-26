<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html>
<head>
    <title>Friend Details</title>
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
            font-size: 24px;
            cursor: pointer;
            margin-right: 10px;
        }

        .balance-info {
            background: white;
            margin: 10px;
            padding: 15px;
            border-radius: 10px;
        }

        .balance-summary {
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
        }

        .balance-item {
            text-align: center;
        }

        .balance-label {
            font-size: 12px;
            color: #666;
        }

        .balance-amount-get {
            font-size: 20px;
            font-weight: bold;
            color: red;
        }

        .balance-amount-gave {
            font-size: 20px;
            font-weight: bold;
            color: green;
        }

        .net-balance {
            font-size: 20px;
            font-weight: bold;
        }

        .section-title {
            margin: 15px 10px 10px 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        /* Expense card - same as selfexpense */
        .expense-item {
            background: white;
            margin: 8px;
            padding: 15px;
            border-radius: 10px;
            border-left: 4px solid #ccc;
        }

        .expense-item.get {
            border-left-color: red;
        }

        .expense-item.gave {
            border-left-color: green;
        }

        .expense-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }

        .expense-amount {
            font-size: 18px;
            font-weight: bold;
        }

        .expense-amount.get {
            color: red;
        }

        .expense-amount.gave {
            color: green;
        }

        /* Right side - type badge + edit button */
        .expense-actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .expense-type {
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 20px;
            color: white;
            font-weight: bold;
        }

        .expense-type.get {
            background: red;
        }

        .expense-type.gave {
            background: green;
        }

        /* Edit button - same blue as screenshot */
        .edit-btn {
            background: #1565c0;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }

        .edit-btn:hover {
            background: #0d47a1;
        }

        .expense-note {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }

        .expense-date {
            color: #999;
            font-size: 12px;
        }

        .no-data {
            text-align: center;
            padding: 40px 20px;
            color: #999;
        }

        .add-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #e91e63;
            color: white;
            padding: 15px 20px;
            border-radius: 30px;
            border: none;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
            font-size: 16px;
        }

        .add-btn:hover {
            background: #c2185b;
        }

        /* Edit friend button */
        .edit-friend-btn {
            display: block;
            margin: 10px;
            padding: 12px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            width: calc(100% - 20px);
            text-align: center;
        }

        .edit-friend-btn:hover {
            background: #0a3570;
        }
    </style>
</head>
<body>

<%
    String friendName = (String) request.getAttribute("friendName");
    Double totalGet = (Double) request.getAttribute("totalGet");
    Double totalGave = (Double) request.getAttribute("totalGave");

    if (totalGet == null) totalGet = 0.0;
    if (totalGave == null) totalGave = 0.0;

    double netBalance = totalGet - totalGave;
%>

<div class="header">
    <button class="back-btn" onclick="window.location.href='DashboardServlet'">←</button>
    <%= friendName %>
</div>

<!-- Balance Summary -->
<div class="balance-info">
    <div class="balance-summary">
        <div class="balance-item">
            <div class="balance-label">You will GET</div>
            <div class="balance-amount-get">₹ <%= String.format("%.2f", totalGet) %></div>
        </div>

        <div class="balance-item">
            <div class="balance-label">You GAVE</div>
            <div class="balance-amount-gave">₹ <%= String.format("%.2f", totalGave) %></div>
        </div>

        <div class="balance-item">
            <div class="balance-label">Net Balance</div>
            <div class="net-balance" style="color: <%= netBalance > 0 ? "red" : netBalance < 0 ? "green" : "#0d47a1" %>">
                ₹ <%= String.format("%.2f", Math.abs(netBalance)) %>
            </div>
        </div>
    </div>
</div>

<!-- Edit Friend Button -->
<button class="edit-friend-btn" onclick="window.location.href='editfriend.jsp?friendName=<%= friendName %>'">
    ✏️ Edit Friend
</button>

<!-- Transaction History -->
<div class="section-title">Transaction History</div>

<%
    List<String[]> expenses = (List<String[]>) request.getAttribute("expenses");

    if (expenses != null && !expenses.isEmpty()) {
        for (String[] expense : expenses) {
            String id      = expense[0];
            String amount  = expense[1];
            String note    = expense[2];
            String type    = expense[3];
            String date    = expense[4];
%>

<div class="expense-item <%= type %>">
    <div class="expense-header">
        <!-- Left: Amount -->
        <span class="expense-amount <%= type %>">
            <%= type.equals("get") ? "+" : "-" %> ₹ <%= amount %>
        </span>

        <!-- Right: Type Badge + Edit Button -->
        <div class="expense-actions">
            <span class="expense-type <%= type %>">
                <%= type.equals("get") ? "GET" : "GAVE" %>
            </span>
            <button class="edit-btn"
                    onclick="window.location.href='editexpense.jsp?id=<%= id %>'">
                ✏️
            </button>
        </div>
    </div>

    <% if (note != null && !note.equals("No note") && !note.isEmpty()) { %>
        <div class="expense-note"><%= note %></div>
    <% } %>

    <div class="expense-date"><%= date %></div>
</div>

<%
        }
    } else {
%>
<div class="no-data">
    <p>No transactions yet!</p>
    <p>Click the button below to add first transaction.</p>
</div>
<%
    }
%>

<!-- Add Expense Button -->
<button class="add-btn" onclick="window.location.href='addexpense.jsp?friendName=<%= friendName %>'">
    + Add Expense
</button>

</body>
</html>