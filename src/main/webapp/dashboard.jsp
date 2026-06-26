<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }

        .back-btn {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            margin-right: 10px;
            display: none;
        }

        .tabs {
            display: flex;
            background: #1565c0;
            color: white;
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

        .balance-amount-give {
            font-size: 20px;
            font-weight: bold;
            color: green;
        }

        .balance-amount-get {
            font-size: 20px;
            font-weight: bold;
            color: red;
        }

        .net-balance {
            font-size: 20px;
            font-weight: bold;
            color: #0d47a1;
        }

        .search {
            margin: 10px;
        }

        .search input {
            width: 100%;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .section-title {
            margin: 20px 10px 10px 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .friends-list {
            margin: 10px;
            margin-bottom: 100px;
        }

        .friend-card {
            background: white;
            margin-bottom: 8px;
            padding: 15px;
            border-radius: 10px;
            border-left: 4px solid #ccc;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .friend-card:hover {
            transform: translateX(5px);
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .friend-card.positive {
            border-left-color: red;
        }

        .friend-card.negative {
            border-left-color: green;
        }

        .friend-card.zero {
            border-left-color: #ccc;
        }

        .friend-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }

        .friend-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .friend-amount {
            font-size: 18px;
            font-weight: bold;
        }

        .friend-amount.positive {
            color: red;
        }

        .friend-amount.negative {
            color: green;
        }

        .friend-amount.zero {
            color: #6b7280;
        }

        .friend-status {
            font-size: 12px;
            color: #6b7280;
            font-weight: 500;
            text-align: right;
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
    <div class="tab active">Friends</div>
    <div class="tab" onclick="window.location.href='SelfExpenseServlet'">Self</div>
</div>

<%
    Double totalGive = (Double) request.getAttribute("give");
    Double totalGet = (Double) request.getAttribute("get");
    
    if (totalGive == null) totalGive = 0.0;
    if (totalGet == null) totalGet = 0.0;
    
    double netBalance = totalGet - totalGive;
%>

<!-- Balance Info -->
<div class="balance-info">
    <div class="balance-summary">
        <div class="balance-item">
            <div class="balance-label">You Will Give</div>
            <div class="balance-amount-give">₹ <%= String.format("%.2f", totalGive) %></div>
        </div>
        
        <div class="balance-item">
            <div class="balance-label">You Will Get</div>
            <div class="balance-amount-get">₹ <%= String.format("%.2f", totalGet) %></div>
        </div>
        
        <div class="balance-item">
            <div class="balance-label">Net Balance</div>
            <div class="net-balance" style="color: <%= netBalance > 0 ? "red" : netBalance < 0 ? "green" : "#0d47a1" %>">
                ₹ <%= String.format("%.2f", Math.abs(netBalance)) %>
            </div>
        </div>
    </div>
</div>

<!-- Search -->
<div class="search">
    <input type="text" id="searchInput" placeholder="Search friends..." onkeyup="searchFriends()">
</div>

<!-- Friends List -->
<div class="section-title">Friends List</div>

<div class="friends-list" id="friendsList">
<%
    List<String[]> friends = (List<String[]>) request.getAttribute("friends");
    
    if (friends != null && !friends.isEmpty()) {
        for (String[] f : friends) {
            try {
                String name = f[0];
                double totalGetFriend = Double.parseDouble(f[1]);
                double totalGaveFriend = Double.parseDouble(f[2]);
                double balance = totalGetFriend - totalGaveFriend;
                
                String balanceClass = balance > 0 ? "positive" : balance < 0 ? "negative" : "zero";
                String balanceText = balance > 0 ? "You will get" : balance < 0 ? "You gave" : "Settled up";
%>
    <div class="friend-card <%= balanceClass %>" onclick="window.location.href='FriendDetailsServlet?friendName=<%= name %>'">
        <div class="friend-header">
            <div class="friend-name"><%= name %></div>
            <div class="friend-amount <%= balanceClass %>">
                <%= balance != 0 ? (balance > 0 ? "+" : "") + " ₹ " + String.format("%.2f", Math.abs(balance)) : "₹ 0.00" %>
            </div>
        </div>
        <div class="friend-status"><%= balanceText %></div>
    </div>
<%
            } catch (Exception e) {
                out.println("<div style='color:red; padding:10px;'>Error: " + e.getMessage() + "</div>");
            }
        }
    } else {
%>
    <div class="no-data">
        <p>No friends added yet!</p>
        <p>Click the button below to add your first friend.</p>
    </div>
<%
    }
%>
</div>

<!-- Add Friend Button -->
<button class="add-btn" onclick="window.location.href='addfriend.jsp'">+ Add Friend</button>

<script>
function searchFriends() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toUpperCase();
    const friendsList = document.getElementById('friendsList');
    const cards = friendsList.getElementsByClassName('friend-card');

    for (let i = 0; i < cards.length; i++) {
        const name = cards[i].getElementsByClassName('friend-name')[0];
        const txtValue = name.textContent || name.innerText;
        
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            cards[i].style.display = "";
        } else {
            cards[i].style.display = "none";
        }
    }
}
</script>

</body>
</html>