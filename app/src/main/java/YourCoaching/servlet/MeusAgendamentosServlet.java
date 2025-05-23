package YourCoaching.servlet;

import YourCoaching.dao.AgendamentoDao;
import YourCoaching.dao.CoachDao;
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

@WebServlet("/meus-agendamentos")
public class MeusAgendamentosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Verificar se o usuário está logado
        if (usuario == null) {
            session.setAttribute("mensagemErro", "Você precisa estar logado para ver seus agendamentos.");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            AgendamentoDao agendamentoDao = new AgendamentoDao();
            CoachDao coachDao = new CoachDao();

            // Buscar agendamentos do usuário
            List<Agendamento> agendamentos = agendamentoDao.findAgendamentosByUsuarioId(usuario.getId());

            // Criar uma lista com informações completas dos agendamentos
            List<Map<String, Object>> agendamentosCompletos = new ArrayList<>();

            for (Agendamento agendamento : agendamentos) {
                Coach coach = coachDao.findCoachById(agendamento.getCoachId());

                Map<String, Object> agendamentoInfo = new HashMap<>();
                agendamentoInfo.put("id", agendamento.getId());
                agendamentoInfo.put("data", agendamento.getData());
                agendamentoInfo.put("horario", agendamento.getHorario());
                agendamentoInfo.put("nomeCoach", coach != null ? coach.getNome() : "Coach não encontrado");
                agendamentoInfo.put("coachId", agendamento.getCoachId());

                agendamentosCompletos.add(agendamentoInfo);
            }

            // Adicionar a lista na requisição
            request.setAttribute("agendamentos", agendamentosCompletos);

            // Forward para a página JSP
            request.getRequestDispatcher("meus-agendamentos.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensagemErro", "Erro ao carregar agendamentos. Tente novamente mais tarde.");
            response.sendRedirect("dashboard-usuario.html");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            if ("cancelar".equals(action)) {
                String agendamentoIdParam = request.getParameter("agendamentoId");

                if (agendamentoIdParam != null && !agendamentoIdParam.trim().isEmpty()) {
                    int agendamentoId = Integer.parseInt(agendamentoIdParam);

                    AgendamentoDao agendamentoDao = new AgendamentoDao();
                    agendamentoDao.deleteAgendamento(agendamentoId);

                    session.setAttribute("mensagemSucesso", "Agendamento cancelado com sucesso!");
                } else {
                    session.setAttribute("mensagemErro", "ID do agendamento inválido.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("mensagemErro", "ID do agendamento inválido.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensagemErro", "Erro ao cancelar agendamento. Tente novamente.");
        }

        // Redirecionar de volta para a página de agendamentos
        response.sendRedirect("meus-agendamentos");
    }
}