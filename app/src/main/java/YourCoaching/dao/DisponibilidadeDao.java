package YourCoaching.dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DisponibilidadeDao {
    private static final String JDBC_URL = "jdbc:h2:mem:yourcoaching;DB_CLOSE_DELAY=-1";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "sa";

    public static class TimeSlot {
        public String start;
        public String end;

        public TimeSlot(String start, String end) {
            this.start = start;
            this.end = end;
        }
    }

    public List<TimeSlot> findAvailableTimesByDate(int coachId, LocalDate date) {
        List<TimeSlot> availableTimes = new ArrayList<>();
        String sql = "SELECT HORA_INICIO, HORA_FIM FROM DISPONIBILIDADE_COACH " +
                "WHERE COACH_ID = ? AND DIA_SEMANA = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            stmt.setInt(2, date.getDayOfWeek().getValue() % 7);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                availableTimes.add(new TimeSlot(
                        rs.getTime("HORA_INICIO").toString(),
                        rs.getTime("HORA_FIM").toString()
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableTimes;
    }

    public boolean verificarDisponibilidade(int coachId, LocalDateTime dataHora, int duracao) {
        String sql = "SELECT 1 FROM DISPONIBILIDADE_COACH dc " +
                "WHERE dc.COACH_ID = ? " +
                "AND dc.DIA_SEMANA = ? " +
                "AND TIME(?) BETWEEN dc.HORA_INICIO AND dc.HORA_FIM " +
                "AND NOT EXISTS (" +
                "   SELECT 1 FROM HORARIOS_BLOQUEADOS hb " +
                "   WHERE hb.COACH_ID = dc.COACH_ID " +
                "   AND ? BETWEEN hb.DATA_INICIO AND hb.DATA_FIM" +
                ") " +
                "AND NOT EXISTS (" +
                "   SELECT 1 FROM AGENDAMENTOS a " +
                "   WHERE a.COACH_ID = dc.COACH_ID " +
                "   AND a.STATUS IN ('PENDENTE', 'CONFIRMADO') " +
                "   AND ? < DATE_ADD(a.DATA_HORA, INTERVAL a.DURACAO MINUTE) " +
                "   AND DATE_ADD(?, INTERVAL ? MINUTE) > a.DATA_HORA" +
                ")";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            stmt.setInt(2, dataHora.getDayOfWeek().getValue() % 7);
            stmt.setTimestamp(3, Timestamp.valueOf(dataHora));
            stmt.setTimestamp(4, Timestamp.valueOf(dataHora));
            stmt.setTimestamp(5, Timestamp.valueOf(dataHora));
            stmt.setTimestamp(6, Timestamp.valueOf(dataHora));
            stmt.setInt(7, duracao);

            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver H2 não encontrado", e);
        }
    }
}