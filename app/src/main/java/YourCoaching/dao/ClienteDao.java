package YourCoaching.dao;

import YourCoaching.config.ConnectionPoolConfig;
import YourCoaching.model.Cliente;
import YourCoaching.model.Usuario;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ClienteDao {
    // Use a configuração do ConnectionPoolConfig que já existe no seu projeto
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
            return DriverManager.getConnection(
                    "jdbc:h2:mem:yourcoaching;DB_CLOSE_DELAY=-1;INIT=RUNSCRIPT FROM 'classpath:schema.sql'",
                    "sa",
                    "sa");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver H2 não encontrado", e);
        }
    }

    public List<Cliente> findByCoach(Integer coachId) {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT u.ID, u.NOME, u.EMAIL, " +
                "COUNT(a.ID) as TOTAL_SESSOES, " +
                "MAX(a.DATA_HORA) as ULTIMA_SESSAO, " +
                "AVG(f.RATING) as ULTIMA_AVALIACAO " +
                "FROM USUARIO u " +
                "JOIN AGENDAMENTOS a ON u.ID = a.USUARIO_ID " +
                "LEFT JOIN FEEDBACK f ON a.ID = f.AGENDAMENTO_ID " +
                "WHERE a.COACH_ID = ? AND a.STATUS = 'REALIZADO' " +
                "GROUP BY u.ID, u.NOME, u.EMAIL";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Cliente cliente = new Cliente();
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("ID"));
                usuario.setNome(rs.getString("NOME"));
                usuario.setEmail(rs.getString("EMAIL"));

                cliente.setUsuario(usuario);
                cliente.setTotalSessoes(rs.getInt("TOTAL_SESSOES"));

                Timestamp timestamp = rs.getTimestamp("ULTIMA_SESSAO");
                if (timestamp != null) {
                    cliente.setUltimaSessao(timestamp.toLocalDateTime().toLocalDate());
                }

                cliente.setUltimaAvaliacao(rs.getDouble("ULTIMA_AVALIACAO"));

                clientes.add(cliente);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar clientes do coach: " + e.getMessage());
            e.printStackTrace();
        }
        return clientes;
    }
}