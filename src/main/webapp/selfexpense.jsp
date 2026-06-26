<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Self Expenses</title>
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
    font-weight: bold;
}

.tabs {
    display: flex;
    background: #1565c0;
    color: white;
}

.tab {
    flex: 1;
    text-align: center;
    padding: 12px;
    cursor: pointer;
    font-size: 16px;
}

.tab.active {
    border-bottom: 3px solid orange;
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

        .balance-amount-income {
            font-size: 20px;
            font-weight: bold;
            color: green;
        }

        .balance-amount-expense {
            font-size: 20px;
            font-weight: bold;
            color: red;
        }

        .net-balance {
            font-size: 20px;
            font-weight: bold;
            color: #0d47a1;
        }

        .section-title {
            margin: 20px 10px 10px 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .transaction-item {
            background: white;
            margin: 8px;
            padding: 15px;
            border-radius: 10px;
            border-left: 4px solid #ccc;
        }

        .transaction-item.income {
            border-left-color: green;
        }

        .transaction-item.expense {
            border-left-color: red;
        }

        .transaction-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }

        .transaction-amount {
            font-size: 18px;
            font-weight: bold;
        }

        .transaction-amount.income {
            color: green;
        }

        .transaction-amount.expense {
            color: red;
        }

        .transaction-type {
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 10px;
            color: white;
        }

        .transaction-type.income {
            background: green;
        }

        .transaction-type.expense {
            background: red;
        }

        .transaction-category {
            color: #0d47a1;
            font-size: 13px;
            font-weight: bold;
            margin-bottom: 3px;
        }

        .transaction-note {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }

        .transaction-date {
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
        }

        .add-btn:hover {
            background: #c2185b;
        }
    </style>
</head>
<body>
<div class="header">
    <a href="DashboardServlet" style="color: white; text-decoration: none;">Daily Expense</a>
</div>
<div class="tabs">
    <div class="tab" onclick="window.location.href='DashboardServlet'">Friends</div>
    <div class="tab active">Self</div>
</div>

<%
    Double totalIncome = (Double) request.getAttribute("totalIncome");
    Double totalExpense = (Double) request.getAttribute("totalExpense");
    double netBalance = totalIncome - totalExpense;
%>

<!-- Balance Info -->
<div class="balance-info">
    <div class="balance-summary">
        <div class="balance-item">
            <div class="balance-label">Total Income</div>
            <div class="balance-amount-income">₹ <%= String.format("%.2f", totalIncome) %></div>
        </div>
        
        <div class="balance-item">
            <div class="balance-label">Total Expense</div>
            <div class="balance-amount-expense">₹ <%= String.format("%.2f", totalExpense) %></div>
        </div>
        
        <div class="balance-item">
            <div class="balance-label">Net Balance</div>
            <div class="net-balance" style="color: <%= netBalance >= 0 ? "green" : "red" %>">
                ₹ <%= String.format("%.2f", Math.abs(netBalance)) %>
            </div>
        </div>
    </div>
</div>

<!-- Transaction List -->
<div class="section-title">Transaction History</div>

<%
    List<String[]> transactions = (List<String[]>) request.getAttribute("transactions");
    
    if (transactions != null && !transactions.isEmpty()) {
        for (String[] transaction : transactions) {
            String id = transaction[0];
            String amount = transaction[1];
            String category = transaction[2];
            String note = transaction[3];
            String type = transaction[4];
            String date = transaction[5];
%>
    <div class="transaction-item <%= type %>" style="position: relative;">
    <div class="transaction-header">
        <div>
            <span class="transaction-amount <%= type %>">
                <%= type.equals("income") ? "+" : "-" %> ₹ <%= amount %>
            </span>
        </div>
        <div style="display: flex; gap: 10px; align-items: center;">
            <span class="transaction-type <%= type %>">
                <%= type.equals("income") ? "Income" : "Expense" %>
            </span>
            <button onclick="window.location.href='editselftransaction.jsp?id=<%= id %>'" 
                    style="background: #0d47a1; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer; font-size: 12px;">
                ✏️
            </button>
        </div>
    </div>
    <div class="transaction-category"><%= category %></div>
    <div class="transaction-note"><%= note %></div>
    <div class="transaction-date"><%= date %></div>
</div>
<%
        }
    } else {
%>
    <div class="no-data">
        <p>No transactions yet!</p>
        <p>Click the button below to add your first transaction.</p>
    </div>
<%
    }
%>

<!-- Add Transaction Button -->
<button class="add-btn" onclick="window.location.href='addselftransaction.jsp'">
    + Add Transaction
</button>

</body>
</html>