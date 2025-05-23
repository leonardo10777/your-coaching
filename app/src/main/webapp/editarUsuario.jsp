<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <title>Editar Usuário</title>
    <style>
        .form-container { max-width: 500px; margin: 20px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 15px; border-radius: 4px; text-decoration: none; }
        .btn-primary { background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .btn-secondary { background-color: #f44336; color: white; }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Editar Usuário</h1>
        <form action="/update-user" method="post">
            <input type="hidden" name="id" value="${usuario.id}">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${usuario.nome}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${usuario.email}" required>
            </div>

            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" value="${usuario.telefone}" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha (deixe em branco para manter):</label>
                <input type="password" id="senha" name="senha" placeholder="Nova senha (opcional)">
            </div>

            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento:</label>
                <input type="date" id="dataNascimento" name="dataNascimento"
                       value="${usuario.dataNascimento}" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="/find-all-users" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>