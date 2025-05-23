<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conheça Nossos Coachs | Your Coaching</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .coach-section {
            padding: 80px 0;
        }

        .coach-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            margin-top: 50px;
        }

        .coach-card {
            background-color: var(--lighter-color);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .coach-card:hover {
            transform: translateY(-10px);
        }

        .coach-header {
            padding: 30px;
            border-bottom: 1px solid var(--border-color);
            text-align: center;
        }

        .coach-image-container {
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
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
            font-size: 1.8rem;
            color: var(--dark-color);
            margin-bottom: 10px;
        }

        .coach-specialty {
            font-size: 1.2rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .coach-body {
            padding: 30px;
        }

        .coach-description {
            color: var(--text-light);
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .coach-footer {
            padding: 20px 30px;
            background-color: var(--light-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .coach-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .coach-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--text-light);
        }

        .coach-rating i {
            color: #FFD700;
        }

        .btn-know-more {
            display: block;
            text-align: center;
            margin-top: 20px;
            padding: 12px 0;
            background-color: var(--primary-color);
            color: var(--lighter-color);
            border-radius: 5px;
            font-weight: 600;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .btn-know-more:hover {
            background-color: var(--secondary-color);
        }

        .section-title {
            text-align: center;
            margin-bottom: 20px;
        }

        .section-subtitle {
            text-align: center;
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto 40px;
        }

        .btn-view-profile {
            display: block;
            text-align: center;
            margin-top: 20px;
            padding: 12px 0;
            background-color: var(--light-color);
            color: var(--dark-color);
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            border: 1px solid var(--border-color);
        }

        .btn-view-profile:hover {
            background-color: var(--primary-color);
            color: var(--lighter-color);
        }

        .coach-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .coach-actions a {
            flex: 1;
        }

        /* Estilos para a seção de comentários */
        .feedback-section {
            margin-top: 25px;
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
        }

        .feedback-title {
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .feedback-toggle {
            color: var(--primary-color);
            cursor: pointer;
            font-size: 0.9rem;
        }

        .feedback-list {
            max-height: 200px;
            overflow-y: auto;
            margin-bottom: 15px;
        }

        .feedback-item {
            padding: 12px;
            border-radius: 8px;
            background-color: var(--light-color);
            margin-bottom: 10px;
        }

        .feedback-user {
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--dark-color);
        }

        .feedback-text {
            color: var(--text-light);
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .feedback-form {
            margin-top: 15px;
        }

        .feedback-form textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            resize: vertical;
            min-height: 80px;
            margin-bottom: 10px;
            font-family: inherit;
        }

        .feedback-form button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .feedback-form button:hover {
            background-color: var(--secondary-color);
        }

        .hidden {
            display: none;
        }

        .feedback-container {
            margin-top: 15px;
        }

        .no-feedbacks {
            color: var(--text-light);
            font-style: italic;
            padding: 10px 0;
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <div class="header-content">
            <a href="index.html" class="logo">
                <img src="img/logo.png" alt="Liberte seu Potencial" class="logo-img">
                <h1>Your Coaching</h1>
            </a>

            <nav class="main-nav">
                <ul>
                    <li><a href="dashboard-usuario.html"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="perfil-usuario.html"><i class="fas fa-user"></i> Meu Perfil</a></li>
                    <li><a href="agendamentos.jsp"><i class="fas fa-calendar"></i> Agendamentos</a></li>
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
                        <div class="coach-actions">
                            <a href="${pageContext.request.contextPath}/perfil-coach?coachId=${coach.id}" class="btn-know-more">Agendar Consulta</a>
                            <a href="${pageContext.request.contextPath}/perfil-coach?coachId=${coach.id}" class="btn-view-profile">Visualizar Perfil</a>
                        </div>

                        <!-- Seção de Feedback -->
                        <div class="feedback-section">
                            <div class="feedback-title">
                                <span>Comentários</span>
                            </div>

                            <div class="feedback-container" id="feedback-container-${coach.id}">
                                <div class="feedback-list">
                                    <c:choose>
                                        <c:when test="${not empty feedbacks[coach.id] && feedbacks[coach.id].size() > 0}">
                                            <c:forEach var="feedback" items="${feedbacks[coach.id]}">
                                                <div class="feedback-item">
                                                    <div class="feedback-user">${feedback.usuarioNome}</div>
                                                    <div class="feedback-text">${feedback.comentario}</div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-feedbacks">Nenhum comentário ainda. Seja o primeiro a comentar!</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <form action="${pageContext.request.contextPath}/addFeedback" method="post" class="feedback-form">
                                    <input type="hidden" name="coachId" value="${coach.id}">
                                    <textarea name="comentario" placeholder="Deixe seu comentário sobre este coach..." required></textarea>
                                    <button type="submit">Enviar Comentário</button>
                                </form>
                            </div>
                        </div>
                        <!-- Fim da Seção de Feedback -->
                    </div>

                    <div class="coach-footer">
                        <span class="coach-price">
                            <fmt:setLocale value="pt_BR"/>
                            <fmt:formatNumber value="${coach.preco}" type="currency"/>
                        </span>
                        <span class="coach-rating">
                            <i class="fas fa-star"></i>
                            <span>4.9</span>
                        </span>
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

<script src="js/script.js"></script>
<script>
            // Fallback para imagens que não carregarem
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('.coach-image');
        images.forEach(img => {
            img.addEventListener('error', function() {
                this.src = '${pageContext.request.contextPath}/img/default-coach.jpg';
            });
        });

        // Exibir mensagem de erro se houver
        if ('${error}' !== '') {
            alert('${error}');
        }
    });
</script>
</body>
</html>