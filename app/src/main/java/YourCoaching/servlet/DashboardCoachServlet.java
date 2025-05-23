package YourCoaching.servlet;

import YourCoaching.dao.AgendamentoDao;
import YourCoaching.dao.UsuarioDao;
import YourCoaching.model.Agendamento;
import YourCoaching.model.Coach;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard-coach")
public class DashboardCoachServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Coach coach = (Coach) session.getAttribute("coach");

        // Verificar se o coach está logado
        if (coach == null) {
            session.setAttribute("mensagemErro", "Você precisa estar logado como coach.");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            AgendamentoDao agendamentoDao = new AgendamentoDao();
            UsuarioDao usuarioDao = new UsuarioDao();

            // Buscar agendamentos do coach
            List<Agendamento> agendamentos = agendamentoDao.findAgendamentosByCoachId(coach.getId());

            // Criar uma lista com informações completas dos agendamentos
            List<Map<String, Object>> agendamentosCompletos = new ArrayList<>();

            for (Agendamento agendamento : agendamentos) {
                Usuario usuario = usuarioDao.findUsuarioById(agendamento.getUsuarioId());

                Map<String, Object> agendamentoInfo = new HashMap<>();
                agendamentoInfo.put("id", agendamento.getId());
                agendamentoInfo.put("data", agendamento.getData());
                agendamentoInfo.put("horario", agendamento.getHorario());
                agendamentoInfo.put("nomeUsuario", usuario != null ? usuario.getNome() : "Usuário não encontrado");
                agendamentoInfo.put("usuarioId", agendamento.getUsuarioId());

                agendamentosCompletos.add(agendamentoInfo);
            }

            // Adicionar a lista na requisição
            request.setAttribute("agendamentos", agendamentosCompletos);

            // Forward para a página JSP
            request.getRequestDispatcher("dashboard-coach.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensagemErro", "Erro ao carregar dashboard. Tente novamente mais tarde.");
            response.sendRedirect("login.jsp");
        }
    }
}