package YourCoaching.dao;

import YourCoaching.model.Usuario;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao {

    public void createUsuario(Usuario usuario) {
        String SQL = "INSERT INTO USUARIO (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO) VALUES (?, ?, ?, ?, ?)";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getTelefone());
            preparedStatement.setString(4, usuario.getSenha());
            preparedStatement.setDate(5, Date.valueOf(usuario.getDataNascimento()));

            preparedStatement.execute();
            System.out.println("Sucesso na inserção do usuário");

            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Falha na conexão com o banco");
            e.printStackTrace();
        }
    }

    public Usuario findUsuarioByEmailAndSenha(String email, String senha) {
        String SQL = "SELECT * FROM USUARIO WHERE EMAIL = ? AND SENHA = ?";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);

            ResultSet resultSet = preparedStatement.executeQuery();

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

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Erro ao buscar usuário: " + e.getMessage());
        }

        return null;
    }

    public List<Usuario> findAllUsuario() {
        String SQL = "SELECT * FROM USUARIO";
        List<Usuario> usuarios = new ArrayList<>();

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Usuario usuario = new Usuario(
                        resultSet.getInt("ID"),
                        resultSet.getString("NOME"),
                        resultSet.getString("EMAIL"),
                        resultSet.getString("TELEFONE"),
                        resultSet.getString("SENHA"),
                        resultSet.getDate("DATA_NASCIMENTO").toLocalDate()
                );
                usuarios.add(usuario);
            }

            System.out.println("Sucesso na busca de todos os usuários");

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Falha na conexão com o banco");
            System.out.println("Erro ao buscar usuários: " + e.getMessage());
            e.printStackTrace();
        }

        return usuarios;
    }

    public void deleteUserById(Integer userId) {
        String SQL = "DELETE FROM USUARIO WHERE ID = ?";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, userId);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Usuário deletado com sucesso! ID: " + userId);
            } else {
                System.out.println("Nenhum usuário encontrado com o ID: " + userId);
            }

            preparedStatement.close();
            connection.close();

        } catch (SQLException e) {
            System.out.println("Falha ao deletar usuário");
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}