package YourCoaching.dao;

import YourCoaching.model.Usuario;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

public class UsuarioDao {

    public void createUsuario(Usuario usuario) {
        // SQL com todos os campos
        String SQL = "INSERT INTO USUARIO (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO) VALUES (?, ?, ?, ?, ?)";

        try {
            // 1. Conectar ao banco
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            // 2. Preparar a declaração SQL
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getTelefone());
            preparedStatement.setString(4, usuario.getSenha()); // Em produção: usar hash!
            preparedStatement.setDate(5, Date.valueOf(usuario.getDataNascimento()));

            // 3. Executar a inserção
            preparedStatement.execute();
            System.out.println("Sucesso na inserção do usuário");

            // 4. Fechar recursos
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Falha na conexão com o banco");
            e.printStackTrace(); // Isso ajuda a ver detalhes do erro
        }
    }
}