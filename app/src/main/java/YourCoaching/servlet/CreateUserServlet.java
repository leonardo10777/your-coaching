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

@WebServlet("/create-user")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String nome = request.getParameter("reg-name");
            String email = request.getParameter("reg-email");
            String telefone = request.getParameter("reg-telefone");
            String senha = request.getParameter("reg-password");
            LocalDate dataNascimento = LocalDate.parse(request.getParameter("reg-nascimento"));

            if (nome == null || nome.isEmpty() || email == null || !email.contains("@") ||
                    senha == null || senha.length() < 8) {
                response.sendRedirect("index.html?erro=validacao");
                return;
            }

            Usuario usuario = new Usuario(nome, email, telefone, senha, dataNascimento);
            new UsuarioDao().createUsuario(usuario);
            response.sendRedirect("index.html?sucesso=cadastro");

        } catch (Exception e) {
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }
}