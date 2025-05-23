<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Meus Clientes | Your Coaching</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    .clients-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
      margin-top: 30px;
    }

    .client-card {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 20px;
      display: flex;
      align-items: center;
    }

    .client-avatar {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      overflow: hidden;
      margin-right: 20px;
      border: 3px solid var(--primary-color);
    }

    .client-info {
      flex: 1;
    }

    .client-stats {
      display: flex;
      margin-top: 10px;
      gap: 15px;
    }

    .stat-item {
      text-align: center;
    }

    .stat-value {
      font-weight: 600;
      color: var(--primary-color);
    }

    .stat-label {
      font-size: 0.8rem;
      color: #666;
    }

    .no-clients {
      text-align: center;
      padding: 50px;
      color: #666;
    }
  </style>
</head>
<body>
<header>
  <div class="container">
    <div class="header-content">
      <a href="index.html" class="logo">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="Your Coaching" class="logo-img">
        <h1>Your Coaching</h1>
      </a>

      <nav class="main-nav">
        <ul>
          <li><a href="dashboard-coach.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
          <li><a href="perfil-coach.jsp"><i class="fas fa-user"></i> Meu Perfil</a></li>
          <li><a href="agendamentos-coach.jsp"><i class="fas fa-calendar"></i> Agendamentos</a></li>
          <li><a href="clientes-coach.jsp" class="active"><i class="fas fa-users"></i> Meus Clientes</a></li>
        </ul>
      </nav>

      <a href="logout" class="btn btn-outline">Sair</a>
    </div>
  </div>
</header>

<main class="container">
  <section class="clients-section">
    <h1>Meus Clientes</h1>

    <div class="search-filter">
      <input type="text" placeholder="Buscar cliente..." class="form-control">
    </div>

    <div class="clients-grid">
      <c:choose>
        <c:when test="${not empty clientes}">
          <c:forEach var="cliente" items="${clientes}">
            <div class="client-card">
              <div class="client-avatar">
                <img src="${pageContext.request.contextPath}/img/${not empty cliente.image ? cliente.image : 'default-user.jpg'}"
                     alt="${cliente.nome}"
                     onerror="this.src='${pageContext.request.contextPath}/img/default-user.jpg'">
              </div>
              <div class="client-info">
                <h3>${cliente.nome}</h3>
                <p>${cliente.email}</p>

                <div class="client-stats">
                  <div class="stat-item">
                    <div class="stat-value">${cliente.totalSessoes}</div>
                    <div class="stat-label">Sessões</div>
                  </div>
                  <div class="stat-item">
                    <div class="stat-value">
                      <fmt:formatNumber value="${cliente.ultimaAvaliacao}" maxFractionDigits="1"/>
                    </div>
                    <div class="stat-label">Avaliação</div>
                  </div>
                  <div class="stat-item">
                    <div class="stat-value">
                      <fmt:formatDate value="${cliente.ultimaSessao}" pattern="dd/MM" />
                    </div>
                    <div class="stat-label">Última</div>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-clients">
            <i class="fas fa-user-friends fa-3x"></i>
            <p>Você ainda não possui clientes</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </section>
</main>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Search functionality
    const searchInput = document.querySelector('.search-filter input');
    searchInput.addEventListener('input', function() {
      const searchTerm = this.value.toLowerCase();

      document.querySelectorAll('.client-card').forEach(card => {
        const clientName = card.querySelector('h3').textContent.toLowerCase();
        if (clientName.includes(searchTerm)) {
          card.style.display = 'flex';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });
</script>
</body>
</html>