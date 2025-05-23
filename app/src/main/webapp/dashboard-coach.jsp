<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard do Coach | Your Coaching</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/perfil-coach.css">
  <link rel="stylesheet" href="css/dashboard.css">
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
          <li><a href="dashboard-coach.html" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
          <li><a href="perfil-coach.jsp"><i class="fas fa-user"></i> Meu Perfil</a></li>
          <li><a href="agendamentos-coach.html"><i class="fas fa-calendar"></i> Agendamentos</a></li>
          <li><a href="clientes-coach.html"><i class="fas fa-users"></i> Meus Clientes</a></li>
        </ul>
      </nav>

      <a href="logout" class="btn btn-outline">Sair</a>
    </div>
  </div>
</header>

<main class="container">
  <section class="dashboard-section">
    <h1 class="section-title">Bem-vindo ao seu Dashboard, ${coach.nome}!</h1>

    <div class="dashboard-grid">
      <!-- Card de Agendamentos -->
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-calendar-check"></i>
        </div>
        <h3>Agendamentos Hoje</h3>
        <p>Você tem <strong>3 sessões</strong> agendadas para hoje</p>
        <a href="agendamentos-coach.html" class="btn btn-primary">Ver Todos</a>
      </div>

      <!-- Card de Clientes -->
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-users"></i>
        </div>
        <h3>Meus Clientes</h3>
        <p>Atualmente você tem <strong>12 clientes</strong> ativos</p>
        <a href="clientes-coach.html" class="btn btn-primary">Gerenciar</a>
      </div>

      <!-- Card de Financeiro -->
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-chart-line"></i>
        </div>
        <h3>Financeiro</h3>
        <p>R$ 4.250,00 em receitas este mês</p>
        <a href="#" class="btn btn-primary">Detalhes</a>
      </div>

      <!-- Card de Avaliações -->
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-star"></i>
        </div>
        <h3>Avaliações</h3>
        <p>Média de <strong>4.8</strong> estrelas (128 avaliações)</p>
        <a href="perfil-coach.jsp#testimonials" class="btn btn-primary">Ver Todas</a>
      </div>
    </div>

    <!-- Seção de Próximas Sessões -->
    <div class="dashboard-section">
      <h2 class="section-subtitle">Próximas Sessões</h2>

      <div class="sessions-list">
        <div class="session-card">
          <div class="session-info">
            <div class="client-avatar">
              <img src="${pageContext.request.contextPath}/img/client1.jpg" alt="Cliente">
            </div>
            <div class="session-details">
              <h4>Ana Paula Silva</h4>
              <p><i class="fas fa-clock"></i> Hoje, 14:00 - 15:00</p>
              <p><i class="fas fa-comment"></i> "Precisamos discutir os investimentos"</p>
            </div>
          </div>
          <div class="session-actions">
            <button class="btn btn-outline"><i class="fas fa-video"></i> Iniciar</button>
            <button class="btn btn-primary"><i class="fas fa-check"></i> Confirmar</button>
          </div>
        </div>

        <div class="session-card">
          <div class="session-info">
            <div class="client-avatar">
              <img src="${pageContext.request.contextPath}/img/client2.jpg" alt="Cliente">
            </div>
            <div class="session-details">
              <h4>Carlos Eduardo</h4>
              <p><i class="fas fa-clock"></i> Amanhã, 10:00 - 11:00</p>
              <p><i class="fas fa-comment"></i> "Revisão do plano financeiro"</p>
            </div>
          </div>
          <div class="session-actions">
            <button class="btn btn-outline"><i class="fas fa-edit"></i> Reagendar</button>
            <button class="btn btn-primary"><i class="fas fa-check"></i> Confirmar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Seção de Estatísticas -->
    <div class="dashboard-section">
      <h2 class="section-subtitle">Suas Estatísticas</h2>

      <div class="stats-grid">
        <div class="stat-card">
          <h4>Sessões Realizadas</h4>
          <div class="stat-value">42</div>
          <p>este mês</p>
        </div>

        <div class="stat-card">
          <h4>Novos Clientes</h4>
          <div class="stat-value">5</div>
          <p>este mês</p>
        </div>

        <div class="stat-card">
          <h4>Horas Trabalhadas</h4>
          <div class="stat-value">38</div>
          <p>este mês</p>
        </div>

        <div class="stat-card">
          <h4>Taxa de Reagendamento</h4>
          <div class="stat-value">12%</div>
          <p>menor que o mês passado</p>
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
<script>
  // Fallback para imagens
  document.addEventListener('DOMContentLoaded', function() {
    const images = document.querySelectorAll('img');
    images.forEach(img => {
      img.addEventListener('error', function() {
        if (this.classList.contains('client-avatar')) {
          this.src = '${pageContext.request.contextPath}/img/default-user.jpg';
        }
      });
    });
  });
</script>
</body>
</html>