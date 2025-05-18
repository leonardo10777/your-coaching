// Funções específicas para a página Sobre Nós

document.addEventListener('DOMContentLoaded', function() {
    // Efeito de carregamento para as seções
    const sections = document.querySelectorAll('section');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, {
        threshold: 0.1
    });

    sections.forEach(section => {
        observer.observe(section);
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
    });

    // Adiciona a classe 'visible' quando a seção aparece na tela
    document.querySelectorAll('section').forEach(section => {
        section.classList.add('visible');
    });

    // Integração com os modais (reutilizando funções do script principal)
    const openLoginModal = document.getElementById('openLoginModal');
    const openRegisterModal = document.getElementById('openRegisterModal');
    const openCoachModal = document.getElementById('openCoachModal');

    if (openLoginModal) {
        openLoginModal.addEventListener('click', () => {
            window.location.href = 'login.html';
        });
    }

    if (openRegisterModal) {
        openRegisterModal.addEventListener('click', () => {
            window.location.href = 'registro-usuario.html';
        });
    }

    if (openCoachModal) {
        openCoachModal.addEventListener('click', () => {
            window.location.href = 'registro-coach.html';
        });
    }
});