document.addEventListener('DOMContentLoaded', function() {
    // Elementos do menu mobile
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const mainNav = document.querySelector('.main-nav');

    // Alternar menu mobile
    mobileMenuBtn.addEventListener('click', function() {
        mainNav.classList.toggle('active');
    });


    // Fechar menu ao clicar em um link
    const navLinks = document.querySelectorAll('.main-nav a');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            mainNav.classList.remove('active');
        });
    });

    // Elementos dos modais
    const loginModal = document.getElementById('loginModal');
    const registerModal = document.getElementById('registerModal');
    const openLoginBtn = document.getElementById('openLoginModal');
    const openRegisterBtn = document.getElementById('openRegisterModal');
    const closeBtns = document.querySelectorAll('.close-modal');
    const switchToRegister = document.getElementById('switchToRegister');
    const switchToLogin = document.getElementById('switchToLogin');

    // Abrir modal de login (se o botão existir)
    if (openLoginBtn) {
        openLoginBtn.addEventListener('click', function() {
            loginModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
        });
    }

    // Abrir modal de registro (se o botão existir)
    if (openRegisterBtn) {
        openRegisterBtn.addEventListener('click', function() {
            registerModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
        });
    }

    // Alternar entre modais
    if (switchToRegister) {
        switchToRegister.addEventListener('click', function(e) {
            e.preventDefault();
            loginModal.style.display = 'none';
            registerModal.style.display = 'block';
        });
    }

    if (switchToLogin) {
        switchToLogin.addEventListener('click', function(e) {
            e.preventDefault();
            registerModal.style.display = 'none';
            loginModal.style.display = 'block';
        });
    }

    // Fechar modais
    closeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            loginModal.style.display = 'none';
            registerModal.style.display = 'none';
            document.body.style.overflow = 'auto';
        });
    });

    // Fechar modais ao clicar fora
    window.addEventListener('click', function(event) {
        if (event.target === loginModal || event.target === registerModal) {
            loginModal.style.display = 'none';
            registerModal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    });

    // Fechar modais com ESC
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            loginModal.style.display = 'none';
            registerModal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    });
    document.getElementById('viewDataBtn')?.addEventListener('click', function() {
        window.location.href = 'list-data';
    });

    // Suavizar rolagem para âncoras
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();

            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });
});
document.addEventListener('DOMContentLoaded', function() {
    // Header sticky
    const header = document.querySelector('.sticky-header');
    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Menu mobile
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const mainNav = document.querySelector('.main-nav');

    mobileMenuBtn.addEventListener('click', function() {
        mainNav.classList.toggle('active');
        this.innerHTML = mainNav.classList.contains('active') ?
            '<i class="fas fa-times"></i>' : '<i class="fas fa-bars"></i>';
    });

    // Smooth scroll para links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                window.scrollTo({
                    top: target.offsetTop - 80,
                    behavior: 'smooth'
                });

                // Fechar menu mobile se aberto
                if (mainNav.classList.contains('active')) {
                    mainNav.classList.remove('active');
                    mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
                }
            }
        });
    });

    // Seção de vídeo
    const btnPlay = document.querySelector('.btn-play');
    const videoSection = document.querySelector('.video-section');
    const closeVideo = document.querySelector('.close-video');

    if (btnPlay && videoSection) {
        btnPlay.addEventListener('click', () => {
            videoSection.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        closeVideo.addEventListener('click', () => {
            videoSection.classList.remove('active');
            document.body.style.overflow = '';
        });
    }

    // Slider de depoimentos
    const testimonials = document.querySelectorAll('.testimonial');
    const prevBtn = document.querySelector('.slider-prev');
    const nextBtn = document.querySelector('.slider-next');
    let currentIndex = 0;

    function showTestimonial(index) {
        testimonials.forEach(testimonial => testimonial.classList.remove('active'));
        testimonials[index].classList.add('active');
    }

    if (prevBtn && nextBtn) {
        prevBtn.addEventListener('click', () => {
            currentIndex = (currentIndex > 0) ? currentIndex - 1 : testimonials.length - 1;
            showTestimonial(currentIndex);
        });

        nextBtn.addEventListener('click', () => {
            currentIndex = (currentIndex < testimonials.length - 1) ? currentIndex + 1 : 0;
            showTestimonial(currentIndex);
        });

        // Auto-rotate testimonials
        setInterval(() => {
            currentIndex = (currentIndex < testimonials.length - 1) ? currentIndex + 1 : 0;
            showTestimonial(currentIndex);
        }, 5000);
    }

    // Animações ao scroll
    const animateOnScroll = function() {
        const elements = document.querySelectorAll('.animate__animated');

        elements.forEach(element => {
            const elementPosition = element.getBoundingClientRect().top;
            const screenPosition = window.innerHeight / 1.2;

            if (elementPosition < screenPosition) {
                const animationClass = element.getAttribute('data-animation');
                element.classList.add(animationClass);
            }
        });
    };

    window.addEventListener('scroll', animateOnScroll);
    animateOnScroll(); // Executa uma vez ao carregar

    // Modais (mantendo sua implementação existente)
    // ... seu código existente para modais ...

    // Máscara de telefone melhorada
    const phoneInputs = document.querySelectorAll('input[type="tel"]');

    phoneInputs.forEach(input => {
        input.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');

            if (value.length > 11) {
                value = value.substring(0, 11);
            }

            if (value.length > 0) {
                value = value.replace(/^(\d{2})(\d)/g, '($1) $2');
                value = value.replace(/(\d)(\d{4})$/, '$1-$2');
            }

            e.target.value = value;
        });
    });

    // Botões de serviço
    const serviceButtons = document.querySelectorAll('.btn-service-details');

    serviceButtons.forEach(button => {
        button.addEventListener('click', function() {
            const serviceCard = this.closest('.service-card');
            const serviceTitle = serviceCard.querySelector('h3').textContent;

            // Aqui você pode implementar a lógica para mostrar mais detalhes
            // Por exemplo, abrir um modal ou redirecionar para uma página específica
            alert(`Você clicou em: ${serviceTitle}\nEsta funcionalidade pode ser expandida para mostrar mais detalhes.`);
        });
    });
});