package com.dailyexpence.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dailyexpence.action.AddFriendAction;

@WebServlet("/DeleteFriendServlet")
public class DeleteFriendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String friendName = request.getParameter("friendName");

        System.out.println("=== DeleteFriendServlet ===");
        System.out.println("Deleting friend: " + friendName);

        try {
            AddFriendAction dao = new AddFriendAction();
            boolean success = dao.deleteFriend(friendName);

            if (success) {
                System.out.println("Friend deleted successfully!");
            } else {
                System.out.println("Failed to delete friend!");
            }

        } catch (Exception e) {
            System.out.println("ERROR in DeleteFriendServlet:");
            e.printStackTrace();
        }

        // Always redirect to dashboard
        response.sendRedirect("DashboardServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}