package servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import services.UserService;

/**
 *
 * @author Andrew
 */
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService us = new UserService();
        
        try {
            String action = request.getParameter("action");
            
            if (action != null && action.equals("delete")) {
                String email = request.getParameter("email").replaceAll(" ", "+");
                us.delete(email);
            }
            
            List<User> users = us.getAll();
            request.setAttribute("userList", users);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService us = new UserService();

        try {
            String action = request.getParameter("action");
            int roleId;
            
            if (action.equals("add")) {
                switch (request.getParameter("add_roles")) {
                    case "system admin":
                        roleId = 1;
                        break;
                    case "regular user":
                        roleId = 2;
                        break;
                    default:
                        roleId = 3;
                        break;
                }
                String email = request.getParameter("add_email");
                boolean active = Boolean.parseBoolean(request.getParameter("add_active"));
                String firstName = request.getParameter("add_first_name");
                String lastName = request.getParameter("add_last_name");
                String password = request.getParameter("add_password");
                
                us.insert(email, active, firstName, lastName, password, roleId);
                
                List<User> users = us.getAll();
                request.setAttribute("userList", users);
            }
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }
}
