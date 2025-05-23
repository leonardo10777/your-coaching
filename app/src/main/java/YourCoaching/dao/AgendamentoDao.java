package YourCoaching.dao;

import YourCoaching.model.Agendamento;
import java.sql.*;
        import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDao {

    // Configuração da conexão com H2 Database
    private static final String JDBC_URL = "jdbc:h2:mem:yourcoaching;DB_CLOSE_DELAY=-1";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "sa";

    // Bloco estático para criar tabelas ao carregar a classe
    static {
        createTables();
    }

    private static void createTables() {
        String createAgendamentosTable =
                "CREATE TABLE IF NOT EXISTS agendamentos (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY," +
                        "usuario_id INT NOT NULL," +
                        "coach_id INT NOT NULL," +
                        "data_hora TIMESTAMP NOT NULL," +
                        "duracao INT NOT NULL," +
                        "servico VARCHAR(100) NOT NULL," +
                        "observacoes TEXT," +
                        "status VARCHAR(20) DEFAULT 'PENDENTE')";

        String createUsuariosTable =
                "CREATE TABLE IF NOT EXISTS usuarios (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY," +
                        "nome VARCHAR(100) NOT NULL," +
                        "imagem VARCHAR(255))";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.execute(createUsuariosTable);
            stmt.execute(createAgendamentosTable);

            // Inserir dados de exemplo (opcional)
            stmt.executeUpdate(
                    "INSERT INTO usuarios (nome, imagem) VALUES " +
                            "('João Silva', 'user1.jpg'), " +
                            "('Maria Santos', 'user2.jpg')");

            stmt.executeUpdate(
                    "INSERT INTO agendamentos (usuario_id, coach_id, data_hora, duracao, servico, observacoes, status) VALUES " +
                            "(1, 1, '2023-11-15 14:00:00', 60, 'Consultoria', 'Primeira sessão', 'CONFIRMADO'), " +
                            "(2, 1, '2023-11-16 10:00:00', 30, 'Orientações', 'Dúvidas iniciais', 'PENDENTE')");

        } catch (SQLException e) {
            System.err.println("Erro ao criar tabelas: " + e.getMessage());
        }
    }

    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver H2 não encontrado", e);
        }
    }

    public List<Agendamento> findByCoachAndDate(Integer coachId, LocalDate date) {
        List<Agendamento> agendamentos = new ArrayList<>();
        String sql = "SELECT a.*, u.nome as usuario_nome, u.imagem as usuario_imagem " +
                "FROM agendamentos a " +
                "JOIN usuarios u ON a.usuario_id = u.id " +
                "WHERE a.coach_id = ? AND DATE(a.data_hora) = ? " +
                "ORDER BY a.data_hora";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            stmt.setDate(2, Date.valueOf(date));

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                agendamentos.add(mapToAgendamento(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar agendamentos por data: " + e.getMessage());
        }
        return agendamentos;
    }

    public List<Agendamento> findFutureByCoach(Integer coachId) {
        List<Agendamento> agendamentos = new ArrayList<>();
        String sql = "SELECT a.*, u.nome as usuario_nome, u.imagem as usuario_imagem " +
                "FROM agendamentos a " +
                "JOIN usuarios u ON a.usuario_id = u.id " +
                "WHERE a.coach_id = ? AND a.data_hora >= NOW() " +
                "ORDER BY a.data_hora";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                agendamentos.add(mapToAgendamento(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar agendamentos futuros: " + e.getMessage());
        }
        return agendamentos;
    }

    public List<Agendamento> findPastByCoach(Integer coachId) {
        List<Agendamento> agendamentos = new ArrayList<>();
        String sql = "SELECT a.*, u.nome as usuario_nome, u.imagem as usuario_imagem " +
                "FROM agendamentos a " +
                "JOIN usuarios u ON a.usuario_id = u.id " +
                "WHERE a.coach_id = ? AND a.data_hora < NOW() " +
                "ORDER BY a.data_hora DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, coachId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                agendamentos.add(mapToAgendamento(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar agendamentos passados: " + e.getMessage());
        }
        return agendamentos;
    }

    public boolean save(Agendamento agendamento) {
        String sql = "INSERT INTO agendamentos " +
                "(usuario_id, coach_id, data_hora, duracao, servico, observacoes, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, agendamento.getUsuarioId());
            stmt.setInt(2, agendamento.getCoachId());
            stmt.setTimestamp(3, Timestamp.valueOf(agendamento.getDataHora()));
            stmt.setInt(4, agendamento.getDuracao());
            stmt.setString(5, agendamento.getServico());
            stmt.setString(6, agendamento.getObservacoes());
            stmt.setString(7, agendamento.getStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    agendamento.setId(rs.getInt(1));
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao salvar agendamento: " + e.getMessage());
        }
        return false;
    }

    private Agendamento mapToAgendamento(ResultSet rs) throws SQLException {
        Agendamento agendamento = new Agendamento();
        agendamento.setId(rs.getInt("id"));
        agendamento.setUsuarioId(rs.getInt("usuario_id"));
        agendamento.setCoachId(rs.getInt("coach_id"));
        agendamento.setDataHora(rs.getTimestamp("data_hora").toLocalDateTime());
        agendamento.setDuracao(rs.getInt("duracao"));
        agendamento.setServico(rs.getString("servico"));
        agendamento.setObservacoes(rs.getString("observacoes"));
        agendamento.setStatus(rs.getString("status"));

        // Informações adicionais do usuário
        try {
            agendamento.setUsuarioNome(rs.getString("usuario_nome"));
            agendamento.setUsuarioImagem(rs.getString("usuario_imagem"));
        } catch (SQLException e) {
            // Campos opcionais
        }

        return agendamento;
    }

    // Método para testar a conexão (opcional)
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Falha na conexão: " + e.getMessage());
            return false;
        }
    }

    public Agendamento findById(int id) {
        String sql = "SELECT a.*, u.nome as usuario_nome, u.imagem as usuario_imagem " +
                "FROM agendamentos a " +
                "JOIN usuarios u ON a.usuario_id = u.id " +
                "WHERE a.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapToAgendamento(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar agendamento por ID: " + e.getMessage());
        }
        return null;
    }

    public boolean update(Agendamento agendamento) {
        String sql = "UPDATE agendamentos SET " +
                "usuario_id = ?, coach_id = ?, data_hora = ?, " +
                "duracao = ?, servico = ?, observacoes = ?, status = ? " +
                "WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, agendamento.getUsuarioId());
            stmt.setInt(2, agendamento.getCoachId());
            stmt.setTimestamp(3, Timestamp.valueOf(agendamento.getDataHora()));
            stmt.setInt(4, agendamento.getDuracao());
            stmt.setString(5, agendamento.getServico());
            stmt.setString(6, agendamento.getObservacoes());
            stmt.setString(7, agendamento.getStatus());
            stmt.setInt(8, agendamento.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar agendamento: " + e.getMessage());
            return false;
        }
    }

    public boolean updateStatus(int agendamentoId, String status) {
        String sql = "UPDATE agendamentos SET status = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, agendamentoId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar status do agendamento: " + e.getMessage());
            return false;
        }
    }
}