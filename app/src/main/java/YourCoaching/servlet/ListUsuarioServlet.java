package YourCoaching.servlet;

import YourCoaching.dao.UsuarioDao;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/find-all-users")
public class ListUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Usuario> usuarios = new UsuarioDao().findAllUsuario();
            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("listUsers.jsp").forward(request, response); // Nome corrigido aqui
        } catch (Exception e) {
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}