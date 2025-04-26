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
            // 1. Obter lista de usuários usando o DAO
            UsuarioDao usuarioDao = new UsuarioDao();
            List<Usuario> usuarios = usuarioDao.findAllUsuario();

            // 2. Adicionar lista no escopo da requisição
            request.setAttribute("usuarios", usuarios);

            // 3. Encaminhar para a página JSP
            request.getRequestDispatcher("listUsers.jsp").forward(request, response);

        } catch (Exception e) {
            // 4. Tratamento de erro
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao listar usuários: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}