<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conheça Nossos Coachs | Your Coaching</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #2e59d9;
            --dark-color: #5a5c69;
            --light-color: #f8f9fc;
            --lighter-color: #ffffff;
            --border-color: #e3e6f0;
            --text-light: #858796;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--dark-color);
            line-height: 1.6;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }

        /* Header Styles */
        header {
            background-color: var(--lighter-color);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: var(--dark-color);
        }

        .logo-img {
            height: 40px;
            margin-right: 10px;
        }

        .logo h1 {
            font-size: 1.5rem;
            font-weight: 700;
        }

        .main-nav ul {
            display: flex;
            list-style: none;
        }

        .main-nav li {
            margin-left: 1.5rem;
        }

        .main-nav a {
            text-decoration: none;
            color: var(--dark-color);
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: color 0.3s;
        }

        .main-nav a i {
            margin-right: 5px;
            font-size: 0.9rem;
        }

        .main-nav a:hover, .main-nav a.active {
            color: var(--primary-color);
        }

        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.35rem;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-outline {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }

        /* Main Content Styles */
        main {
            padding: 2rem 0;
        }

        .section-title {
            font-size: 2rem;
            margin-bottom: 1rem;
            text-align: center;
            color: var(--dark-color);
        }

        .section-subtitle {
            text-align: center;
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        /* Coach Grid Styles */
        .coach-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .coach-card {
            background-color: var(--lighter-color);
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: transform 0.3s ease;
        }

        .coach-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
        }

        .coach-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            text-align: center;
        }

        .coach-image-container {
            width: 150px;
            height: 150px;
            margin: 0 auto 1rem;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid var(--primary-color);
        }

        .coach-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .coach-name {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .coach-specialty {
            font-size: 1rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .coach-body {
            padding: 1.5rem;
        }

        .coach-description {
            color: var(--text-light);
            line-height: 1.7;
            margin-bottom: 1.5rem;
        }

        .btn-know-more {
            display: block;
            text-align: center;
            padding: 0.75rem;
            background-color: var(--primary-color);
            color: white;
            border-radius: 0.35rem;
            font-weight: 600;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .btn-know-more:hover {
            background-color: var(--secondary-color);
        }

        .coach-footer {
            padding: 1rem 1.5rem;
            background-color: var(--light-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .coach-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        /* Feedback Section Styles */
        .feedback-section {
            padding: 1.5rem;
            background-color: #f9f9f9;
            border-top: 1px solid #eee;
        }

        .feedback-section h3 {
            margin-bottom: 1rem;
            color: var(--dark-color);
            font-size: 1.25rem;
        }

        .add-feedback {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 0.5rem 0 rgba(58, 59, 69, 0.1);
        }

        .add-feedback textarea {
            width: 100%;
            padding: 0.75rem;
            margin: 0.5rem 0;
            border: 1px solid #ddd;
            border-radius: 0.35rem;
            min-height: 100px;
            font-family: inherit;
            resize: vertical;
        }

        .feedback-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .feedback-item {
            background-color: white;
            padding: 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 0.5rem 0 rgba(58, 59, 69, 0.1);
        }

        .feedback-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .feedback-user {
            font-weight: 600;
            color: var(--dark-color);
        }

        .feedback-comment {
            color: #555;
            line-height: 1.5;
        }

        /* Footer Styles */
        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 1.5rem 0;
            margin-top: 2rem;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <a href="index.html" class="logo">
                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Liberte seu Potencial" class="logo-img">
                    <h1>Your Coaching</h1>
                </a>

                <nav class="main-nav">
                    <ul>
                        <li><a href="dashboard-usuario.html"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li><a href="perfil-usuario.html"><i class="fas fa-user"></i> Meu Perfil</a></li>
                        <li><a href="agendamentos.html"><i class="fas fa-calendar"></i> Agendamentos</a></li>
                        <li><a href="list-coaches-for-users" class="active"><i class="fas fa-users"></i> Encontrar Coachs</a></li>
                    </ul>
                </nav>

                <a href="logout" class="btn btn-outline">Sair</a>
            </div>
        </div>
    </header>

    <main class="container">
        <section class="coach-section">
            <h1 class="section-title">Conheça Nossa Equipe</h1>
            <p class="section-subtitle">Profissionais qualificados prontos para te ajudar a alcançar seus objetivos</p>

            <div class="coach-grid">
                <c:forEach var="coach" items="${coaches}">
                    <div class="coach-card">
                        <div class="coach-header">
                            <div class="coach-image-container">
                                <c:choose>
                                    <c:when test="${not empty coach.image}">
                                        <img src="${pageContext.request.contextPath}/img/${coach.image}"
                                             alt="Foto do Coach ${coach.nome}"
                                             class="coach-image"
                                             onerror="this.src='${pageContext.request.contextPath}/img/default-coach.jpg'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/img/default-coach.jpg"
                                             alt="Foto padrão do coach"
                                             class="coach-image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h2 class="coach-name">${coach.nome}</h2>
                            <p class="coach-specialty">${coach.area}</p>
                        </div>
                        <div class="coach-body">
                            <p class="coach-description">${coach.descricaoprofissional}</p>
                            <a href="agendar-consulta?coachId=${coach.id}" class="btn-know-more">Agendar Consulta</a>
                        </div>
                        <div class="coach-footer">
                            <span class="coach-price">
                                <fmt:setLocale value="pt_BR"/>
                                <fmt:formatNumber value="${coach.preco}" type="currency"/>
                            </span>
                        </div>

                        <!-- Seção de comentários -->
                        <div class="feedback-section">
                            <h3>Comentários</h3>

                            <c:if test="${not empty sessionScope.usuario}">
                                <div class="add-feedback">
                                  <form action="${pageContext.request.contextPath}/addFeedback" method="post">
                                      <input type="hidden" name="coachId" value="${coach.id}">
                                      <textarea name="comentario" placeholder="Deixe seu comentário..." required></textarea>
                                      <button type="submit" class="btn-know-more" style="margin-top: 10px;">Enviar</button>
                                  </form>
                                </div>
                            </c:if>

                            <div class="feedback-list">
                                <c:forEach var="feedback" items="${feedbacks[coach.id]}">
                                    <div class="feedback-item">
                                        <div class="feedback-header">
                                            <span class="feedback-user">${feedback.usuarioNome}</span>
                                        </div>
                                        <div class="feedback-comment">${feedback.comentario}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <div class="footer-bottom">
                <p>&copy; 2023 Liberte seu Potencial. Todos os direitos reservados.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Fallback para imagens que não carregarem
            const images = document.querySelectorAll('.coach-image');
            images.forEach(img => {
                img.addEventListener('error', function() {
                    this.src = '${pageContext.request.contextPath}/img/default-coach.jpg';
                });
            });
        });
    </script>
</body>
</html>