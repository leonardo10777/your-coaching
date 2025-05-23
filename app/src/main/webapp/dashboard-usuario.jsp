<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.tipoUsuario != 'usuario'}">
    <c:redirect url="/login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard do Usuário | Your Coaching</title>

    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .dashboard-container {
            padding: 40px 0;
        }
        .welcome-message {
            text-align: center;
            margin-bottom: 40px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 10px 0;
        }
        .stat-label {
            color: var(--text-light);
        }
        .recent-activities {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .activity-item {
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
        }
        .activity-item:last-child {
            border-bottom: none;
        }
        .activity-icon {
            margin-right: 15px;
            color: var(--primary-color);
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
                    <li><a href="admin.html" class="active"><i class="fas fa-user"></i> Admin</a></li>
                    <li><a href="dashboard-usuario.jsp" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="agendamentos.html"><i class="fas fa-calendar"></i> Agendamentos</a></li>
                    <li><a href="list-coaches-for-users"><i class="fas fa-users"></i> Encontrar Coachs</a></li>
                </ul>
            </nav>

            <a href="logout" class="btn btn-outline">Sair</a>
        </div>
    </div>
</header>

<main class="container">
    <section class="dashboard-container">
        <div class="welcome-message">
            <h1>Bem-vindo, ${sessionScope.usuarioNome}!</h1>
            <p>Veja suas estatísticas e atividades recentes</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <i class="fas fa-calendar-check fa-2x"></i>
                <div class="stat-value">3</div>
                <div class="stat-label">Sessões Agendadas</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-check-circle fa-2x"></i>
                <div class="stat-value">5</div>
                <div class="stat-label">Sessões Concluídas</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-star fa-2x"></i>
                <div class="stat-value">4.8</div>
                <div class="stat-label">Avaliação Média</div>
            </div>
        </div>

        <div class="recent-activities">
            <h2>Atividades Recentes</h2>
            <div class="activity-item">
                <i class="fas fa-calendar-plus activity-icon"></i>
                <div>Você agendou uma sessão com João Silva para 15/05</div>
            </div>
            <div class="activity-item">
                <i class="fas fa-comment activity-icon"></i>
                <div>Você enviou um feedback para Maria Souza</div>
            </div>
            <div class="activity-item">
                <i class="fas fa-check activity-icon"></i>
                <div>Sessão com Carlos Oliveira concluída</div>
            </div>
        </div>
    </section>
</main>

<footer>
    <div class="container">
        <div class="footer-bottom">
            <p>&copy; 2023 Your Coaching. Todos os direitos reservados.</p>
        </div>
    </div>
</footer>

<script src="js/script.js"></script>
</body>
</html>