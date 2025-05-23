<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Your Coaching</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .login-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .login-title {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-login:hover {
            background-color: #2980b9;
        }
        .login-options {
            text-align: center;
            margin-top: 20px;
        }
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <a href="index.html" class="logo">
                    <img src="img/logo.png" alt="Your Coaching" class="logo-img">
                    <h1>Your Coaching</h1>
                </a>
                <nav class="main-nav">
                    <ul>
                        <li><a href="index.html"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="sobre.html"><i class="fas fa-users"></i> Sobre</a></li>
                        <li><a href="#services"><i class="fas fa-cogs"></i> Serviços</a></li>
                        <li><a href="contato.html"><i class="fas fa-envelope"></i> Contato</a></li>
                    </ul>
                </nav>
                <div class="header-buttons">
                    <a href="login.jsp" class="btn btn-primary">Login</a>
                    <a href="index.html#registerModal" class="btn btn-outline">Registrar Usuário</a>
                    <a href="index.html#coachModal" class="btn btn-outline">Registrar Coach</a>
                </div>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="login-container">
            <h1 class="login-title">Login</h1>

            <%-- Exibir mensagem de erro se existir --%>
            <% if (request.getAttribute("mensagem") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("mensagem") %>
                </div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="tipoUsuario">Tipo de Usuário</label>
                    <select id="tipoUsuario" name="tipoUsuario" required>
                        <option value="">Selecione...</option>
                        <option value="usuario">Usuário</option>
                        <option value="coach">Coach</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Seu email" required>
                </div>
                <div class="form-group">
                    <label for="senha">Senha</label>
                    <input type="password" id="senha" name="senha" placeholder="Sua senha" required>
                </div>
                <button type="submit" class="btn-login">Entrar</button>
            </form>

            <div class="login-options">
                <p>Ainda não tem conta?
                    <a href="index.html#registerModal">Registre-se como Usuário</a> ou
                    <a href="index.html#coachModal">Registre-se como Coach</a>
                </p>
                <p><a href="#">Esqueci minha senha</a></p>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-col">
                    <a href="index.html" class="footer-logo">
                        <img src="img/logo.png" alt="Your Coaching" class="logo-img">
                    </a>
                    <p>Transformando vidas através do coaching profissional, financeiro e motivacional.</p>
                </div>
                <div class="footer-col">
                    <h4>Links Rápidos</h4>
                    <ul>
                        <li><a href="index.html">Home</a></li>
                        <li><a href="#services">Serviços</a></li>
                        <li><a href="sobre.html">Sobre Nós</a></li>
                        <li><a href="contato.html">Contato</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Contato</h4>
                    <ul>
                        <li><i class="fas fa-envelope"></i> contato@yourcoaching.com</li>
                        <li><i class="fas fa-phone"></i> (11) 1234-5678</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2023 Your Coaching. Todos os direitos reservados.</p>
            </div>
        </div>
    </footer>
</body>
</html>