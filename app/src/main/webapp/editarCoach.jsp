<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Coach</title>
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        .btn-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 15px;
            border-radius: 4px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #f44336;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Editar Coach</h1>

        <c:if test="${not empty param.erro}">
            <div style="color: red; margin-bottom: 15px;">
                Erro ao atualizar coach. Por favor, tente novamente.
            </div>
        </c:if>

        <form action="/update-coach" method="post">
            <input type="hidden" name="id" value="${coach.id}">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${coach.nome}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${coach.email}" required>
            </div>

            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" value="${coach.telefone}" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha (deixe em branco para manter):</label>
                <input type="password" id="senha" name="senha" placeholder="Nova senha (opcional)">
            </div>

            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento:</label>
                <input type="date" id="dataNascimento" name="dataNascimento"
                       value="${coach.dataNascimento}" required>
            </div>

            <div class="form-group">
                <label for="curso">Curso:</label>
                <input type="text" id="curso" name="curso" value="${coach.curso}" required>
            </div>

            <div class="form-group">
                <label for="area">Área:</label>
                <input type="text" id="area" name="area" value="${coach.area}" required>
            </div>

            <div class="form-group">
                <label for="descricaoProfissional">Descrição Profissional:</label>
                <textarea id="descricaoProfissional" name="descricaoProfissional" required>${coach.descricaoProfissional}</textarea>
            </div>

            <div class="form-group">
                <label for="preco">Preço (R$):</label>
                <input type="text" id="preco" name="preco" value="${coach.preco}" required>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                <a href="/find-all-coaches" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>

    <script>
        // Máscara para telefone
        document.getElementById('telefone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 11) value = value.substring(0, 11);

            if (value.length > 0) {
                value = value.replace(/^(\d{2})(\d{5})(\d{4})$/, "($1) $2-$3");
            }
            e.target.value = value;
        });

        // Máscara para preço
        document.getElementById('preco').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            value = (value/100).toFixed(2) + '';
            value = value.replace(".", ",");
            value = value.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
            e.target.value = value;
        });
    </script>
</body>
</html>