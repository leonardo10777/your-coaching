package YourCoaching.dao;

import YourCoaching.model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao {
    private static final String URL = "jdbc:h2:~/test";
    private static final String USER = "sa";
    private static final String PASSWORD = "sa";

    public void createUsuario(Usuario usuario) {
        String SQL = "INSERT INTO USUARIO (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getTelefone());
            preparedStatement.setString(4, usuario.getSenha());
            preparedStatement.setDate(5, Date.valueOf(usuario.getDataNascimento()));

            preparedStatement.executeUpdate();

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    usuario.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao criar usuário", e);
        }
    }

    public List<Usuario> findAllUsuario() {
        String SQL = "SELECT * FROM USUARIO";
        List<Usuario> usuarios = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                usuarios.add(new Usuario(
                        resultSet.getInt("ID"),
                        resultSet.getString("NOME"),
                        resultSet.getString("EMAIL"),
                        resultSet.getString("TELEFONE"),
                        resultSet.getString("SENHA"),
                        resultSet.getDate("DATA_NASCIMENTO").toLocalDate()
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar usuários", e);
        }
        return usuarios;
    }

    public void deleteUserById(Integer userId) {
        String SQL = "DELETE FROM USUARIO WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar usuário", e);
        }
    }

    public void updateUsuario(Usuario usuario) {
        String SQL = "UPDATE USUARIO SET NOME = ?, EMAIL = ?, TELEFONE = ?, SENHA = ?, DATA_NASCIMENTO = ? WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getTelefone());
            preparedStatement.setString(4, usuario.getSenha());
            preparedStatement.setDate(5, Date.valueOf(usuario.getDataNascimento()));
            preparedStatement.setInt(6, usuario.getId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar usuário", e);
        }
    }

    public Usuario findUsuarioById(int id) {
        String SQL = "SELECT * FROM USUARIO WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Usuario(
                            resultSet.getInt("ID"),
                            resultSet.getString("NOME"),
                            resultSet.getString("EMAIL"),
                            resultSet.getString("TELEFONE"),
                            resultSet.getString("SENHA"),
                            resultSet.getDate("DATA_NASCIMENTO").toLocalDate()
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar usuário por ID", e);
        }
        return null;
    }
}