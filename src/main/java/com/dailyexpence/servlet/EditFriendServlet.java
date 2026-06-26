package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.AddFriendAction;

@WebServlet("/EditFriendServlet")
public class EditFriendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       

        String oldName = request.getParameter("oldName");
        String newName = request.getParameter("name");
        String address = request.getParameter("address");
        String phone   = request.getParameter("phone");

        System.out.println("=== EditFriendServlet ===");
        System.out.println("Old Name: " + oldName);
        System.out.println("New Name: " + newName);
        System.out.println("Address: "  + address);
        System.out.println("Phone: "    + phone);

        try {
            AddFriendAction dao = new AddFriendAction();
            boolean success = dao.updateFriend(oldName, newName, address, phone);

            if (success) {
                System.out.println("Friend updated successfully!");
                response.sendRedirect("FriendDetailsServlet?friendName=" + newName);
            } else {
                System.out.println("Failed to update friend!");
                response.sendRedirect("editfriend.jsp?friendName=" + oldName + "&error=1");
            }

        } catch (Exception e) {
            System.out.println("ERROR in EditFriendServlet:");
            e.printStackTrace();
            response.sendRedirect("editfriend.jsp?friendName=" + oldName + "&error=1");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("DashboardServlet");
    }
}