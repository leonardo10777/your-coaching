package YourCoaching.servlet;

import YourCoaching.dao.UsuarioDao;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userIdParam = req.getParameter("id");

        if (userIdParam == null || userIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário não fornecido.");
            return;
        }

        try {
            Integer userId = Integer.parseInt(userIdParam);
            new UsuarioDao().deleteUserById(userId);
            resp.sendRedirect("/find-all-users");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao deletar usuário.");
        }
    }
}