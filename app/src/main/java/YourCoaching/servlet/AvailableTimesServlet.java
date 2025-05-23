package YourCoaching.servlet;

import YourCoaching.dao.DisponibilidadeDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import com.google.gson.Gson;

@WebServlet("/get-available-times")
public class AvailableTimesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int coachId = Integer.parseInt(request.getParameter("coachId"));
            LocalDate date = LocalDate.parse(request.getParameter("date"));

            // Determinar o dia da semana (0=Domingo, 1=Segunda, etc.)
            int dayOfWeek = date.getDayOfWeek().getValue() % 7;

            // Simular horários disponíveis (substitua pela sua lógica real)
            List<DisponibilidadeDao.TimeSlot> availableTimes = new ArrayList<>();

            // Horários de trabalho padrão
            if (dayOfWeek >= 1 && dayOfWeek <= 5) { // Dias úteis
                availableTimes.add(new DisponibilidadeDao.TimeSlot("09:00", "10:00"));
                availableTimes.add(new DisponibilidadeDao.TimeSlot("10:30", "11:30"));
                availableTimes.add(new DisponibilidadeDao.TimeSlot("14:00", "15:00"));
                availableTimes.add(new DisponibilidadeDao.TimeSlot("15:30", "16:30"));
                availableTimes.add(new DisponibilidadeDao.TimeSlot("17:00", "18:00"));
            } else { // Fim de semana
                availableTimes.add(new DisponibilidadeDao.TimeSlot("10:00", "11:00"));
                availableTimes.add(new DisponibilidadeDao.TimeSlot("11:30", "12:30"));
            }

            // Aqui você deve adicionar a lógica para:
            // 1. Verificar horários já agendados
            // 2. Verificar bloqueios de agenda
            // 3. Aplicar as regras específicas do coach

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(availableTimes));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}