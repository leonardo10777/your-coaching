<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard do Usuário | Your Coaching</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                    <li><a href="dashboard-usuario.html" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="perfil-usuario.html"><i class="fas fa-user"></i> Meu Perfil</a></li>
                    <li><a href="agendamentos.html"><i class="fas fa-calendar"></i> Agendamentos</a></li>
                    <li><a href="list-coaches-for-users"><i class="fas fa-users"></i> Encontrar Coachs</a></li>
                </ul>
            </nav>

            <a href="logout" class="btn btn-outline">Sair</a>
        </div>
    </div>
</header>

<main class="container">
    <section class="dashboard-section">
        <h1 class="section-title">Bem-vindo de volta, ${usuario.nome}!</h1>

        <div class="dashboard-grid">
            <!-- Card de Próximas Sessões -->
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3>Próximas Sessões</h3>
                <p>Você tem <strong>2 sessões</strong> agendadas esta semana</p>
                <a href="agendamentos.html" class="btn btn-primary">Ver Agendamentos</a>
            </div>

            <!-- Card de Progresso -->
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Seu Progresso</h3>
                <p>Você completou <strong>75%</strong> do seu plano</p>
                <a href="progresso.html" class="btn btn-primary">Ver Detalhes</a>
            </div>

            <!-- Card de Coach -->
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-user-tie"></i>
                </div>
                <h3>Meu Coach</h3>
                <p>Você está trabalhando com <strong>${coach.nome}</strong></p>
                <a href="perfil-coach.jsp?coachId=${coach.id}" class="btn btn-primary">Ver Perfil</a>
            </div>

            <!-- Card de Metas -->
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-bullseye"></i>
                </div>
                <h3>Metas</h3>
                <p><strong>3/5</strong> metas concluídas este mês</p>
                <a href="metas.html" class="btn btn-primary">Acompanhar</a>
            </div>
        </div>

        <!-- Seção de Acompanhamento -->
        <div class="dashboard-section">
            <h2 class="section-subtitle">Seu Acompanhamento</h2>

            <div class="progress-container">
                <div class="progress-card">
                    <h4>Financeiro</h4>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 65%"></div>
                    </div>
                    <p>65% da meta mensal alcançada</p>
                </div>

                <div class="progress-card">
                    <h4>Desenvolvimento Pessoal</h4>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 80%"></div>
                    </div>
                    <p>4 de 5 atividades concluídas</p>
                </div>

                <div class="progress-card">
                    <h4>Investimentos</h4>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 45%"></div>
                    </div>
                    <p>R$ 4.500 de R$ 10.000 investidos</p>
                </div>
            </div>
        </div>

        <!-- Seção de Próximas Tarefas -->
        <div class="dashboard-section">
            <h2 class="section-subtitle">Próximas Tarefas</h2>

            <div class="tasks-list">
                <div class="task-item">
                    <input type="checkbox" id="task1">
                    <label for="task1">Revisar plano de investimentos com ${coach.nome}</label>
                    <span class="task-date">Amanhã, 10:00</span>
                </div>

                <div class="task-item">
                    <input type="checkbox" id="task2">
                    <label for="task2">Realizar aporte mensal nos investimentos</label>
                    <span class="task-date">Até sexta-feira</span>
                </div>

                <div class="task-item">
                    <input type="checkbox" id="task3">
                    <label for="task3">Completar questionário de perfil de risco</label>
                    <span class="task-date">Até domingo</span>
                </div>
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

<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>