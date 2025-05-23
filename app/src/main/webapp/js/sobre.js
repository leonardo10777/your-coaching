/**
 * Script específico para a página Sobre Nós
 * Controla as animações de scroll e interações da página
 */


document.addEventListener('DOMContentLoaded', function() {
    // =============================================
    // ANIMAÇÕES DE SCROLL
    // =============================================

    // Seleciona todas as seções que devem ser animadas
    const animatedSections = document.querySelectorAll('.animated-section');

    // Configuração inicial das seções animadas
    function setupInitialStyles() {
        animatedSections.forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'opacity 0.8s ease-out, transform 0.8s ease-out';
        });
    }

    // Observador de interseção para animar as seções
    function initScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const sectionObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                    sectionObserver.unobserve(entry.target);
                }
            });
        }, observerOptions);

        animatedSections.forEach(section => {
            sectionObserver.observe(section);
        });
    }

    // =============================================
    // CONTROLE DOS BOTÕES
    // =============================================

    function setupModalButtons() {
        const buttons = [
            { id: 'openLoginModal', url: 'login.html' },
            { id: 'openRegisterModal', url: 'registro-usuario.html' },
            { id: 'openCoachModal', url: 'registro-coach.html' }
        ];

        buttons.forEach(button => {
            const element = document.getElementById(button.id);
            if (element) {
                element.addEventListener('click', (e) => {
                    e.preventDefault();
                    window.location.href = button.url;
                });
            }
        });
    }

    // =============================================
    // INICIALIZAÇÃO
    // =============================================

    function init() {
        setupInitialStyles();
        initScrollAnimations();

        // Delay para garantir que o DOM está totalmente carregado
        setTimeout(setupModalButtons, 300);
    }

    // Inicia todas as funcionalidades
    init();
});