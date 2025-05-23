package YourCoaching.servlet;

import YourCoaching.dao.UsuarioDao;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet(name = "UserUpdateServlet", value = {"/edit-user", "/update-user"})
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Usuario usuario = new UsuarioDao().findUsuarioById(id);

            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/editarUsuario.jsp").forward(request, response);
            } else {
                // Corrigido: redireciona para a rota correta
                response.sendRedirect("/find-all-users");
            }
        } catch (Exception e) {
            // Corrigido: redireciona para a rota correta
            response.sendRedirect("/find-all-users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Usuario usuario = new Usuario(
                    Integer.parseInt(request.getParameter("id")),
                    request.getParameter("nome"),
                    request.getParameter("email"),
                    request.getParameter("telefone"),
                    request.getParameter("senha"),
                    LocalDate.parse(request.getParameter("dataNascimento"))
            );

            new UsuarioDao().updateUsuario(usuario);
            // Já estava correto
            response.sendRedirect("/find-all-users");

        } catch (Exception e) {
            // Mantido o redirecionamento para edição com o ID
            response.sendRedirect("/edit-user?id=" + request.getParameter("id"));
        }
    }
}