<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Acesso Negado</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    .error-container {
      text-align: center;
      padding: 50px 20px;
      max-width: 600px;
      margin: 0 auto;
    }
    .error-icon {
      font-size: 5rem;
      color: #e74c3c;
      margin-bottom: 20px;
    }
    .error-title {
      font-size: 2rem;
      color: #e74c3c;
      margin-bottom: 20px;
    }
    .error-message {
      font-size: 1.2rem;
      margin-bottom: 30px;
      color: var(--text-light);
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
    </div>
  </div>
</header>

<main class="container">
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-ban"></i>
    </div>
    <h1 class="error-title">Acesso Negado</h1>
    <p class="error-message">Você não tem permissão para acessar esta página.</p>
    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Voltar para o login</a>
  </div>
</main>

<footer>
  <div class="container">
    <div class="footer-bottom">
      <p>&copy; 2023 Your Coaching. Todos os direitos reservados.</p>
    </div>
  </div>
</footer>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</body>
</html>