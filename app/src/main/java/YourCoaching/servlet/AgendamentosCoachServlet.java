package YourCoaching.servlet;

import YourCoaching.dao.AgendamentoDao;
import YourCoaching.model.Coach;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import YourCoaching.model.Agendamento;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/agendamentos-coach")
public class AgendamentosCoachServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AgendamentosCoachServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("coach") == null) {
                response.sendRedirect("login-coach.jsp");
                return;
            }

            Coach coach = (Coach) session.getAttribute("coach");
            AgendamentoDao agendamentoDao = new AgendamentoDao();

            String filtro = request.getParameter("filtro");
            LocalDate dataFiltro = null;

            try {
                if (filtro != null && !filtro.isEmpty()) {
                    dataFiltro = LocalDate.parse(filtro);
                }
            } catch (DateTimeParseException e) {
                logger.warning("Formato de data inválido no filtro: " + filtro);
            }

            List<Agendamento> hoje = agendamentoDao.findByCoachAndDate(coach.getId(),
                    dataFiltro != null ? dataFiltro : LocalDate.now());
            List<Agendamento> futuros = agendamentoDao.findFutureByCoach(coach.getId());
            List<Agendamento> passados = agendamentoDao.findPastByCoach(coach.getId());

            Map<String, Integer> stats = new HashMap<>();
            stats.put("totalHoje", hoje.size());
            stats.put("totalFuturos", futuros.size());
            stats.put("totalPassados", passados.size());

            double receitaEstimada = futuros.stream()
                    .filter(a -> a.isConfirmado())
                    .mapToDouble(a -> Double.parseDouble(coach.getPreco()))
                    .sum();

            request.setAttribute("agendamentosHoje", hoje);
            request.setAttribute("agendamentosFuturos", futuros);
            request.setAttribute("agendamentosPassados", passados);
            request.setAttribute("estatisticas", stats);
            request.setAttribute("receitaEstimada", receitaEstimada);
            request.setAttribute("dataFiltro", dataFiltro != null ? dataFiltro.toString() : "");

            request.getRequestDispatcher("/WEB-INF/views/coach/agendamentos-coach.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Erro ao processar agendamentos do coach: " + e.getMessage());
            request.setAttribute("errorMessage", "Ocorreu um erro ao carregar os agendamentos.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            doGet(request, response);
            return;
        }

        try {
            HttpSession session = request.getSession();
            Coach coach = (Coach) session.getAttribute("coach");
            if (coach == null) {
                response.sendRedirect("login-coach.jsp");
                return;
            }

            AgendamentoDao agendamentoDao = new AgendamentoDao();
            int agendamentoId = Integer.parseInt(request.getParameter("agendamentoId"));

            switch (action.toLowerCase()) {
                case "confirmar":
                    agendamentoDao.updateStatus(agendamentoId, "CONFIRMADO");
                    break;
                case "cancelar":
                    agendamentoDao.updateStatus(agendamentoId, "CANCELADO");
                    break;
                case "realizado":
                    agendamentoDao.updateStatus(agendamentoId, "REALIZADO");
                    break;
                default:
                    throw new IllegalArgumentException("Ação inválida: " + action);
            }

            response.sendRedirect("agendamentos-coach");

        } catch (NumberFormatException e) {
            logger.severe("ID de agendamento inválido: " + e.getMessage());
            request.setAttribute("errorMessage", "ID de agendamento inválido.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.severe("Erro ao processar ação POST: " + e.getMessage());
            request.setAttribute("errorMessage", "Ocorreu um erro ao processar sua solicitação.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}