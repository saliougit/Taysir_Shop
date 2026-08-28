document.addEventListener('DOMContentLoaded', function () {
	var header = document.getElementById('header');
	if (!header) {
		return;
	}

	var threshold = header.offsetHeight;
	var ticking = false;

	// Hauteur du header (etat normal, non "stuck") posee en variable CSS :
	// le carrousel s'en sert pour remplir exactement l'ecran sous le header,
	// sans avoir besoin de voir le texte "Bienvenue" en dessous sans scroller.
	document.documentElement.style.setProperty('--angar-header-h', threshold + 'px');

	function applyState() {
		if (window.scrollY > threshold) {
			if (!header.classList.contains('angar-stuck')) {
				header.classList.add('angar-stuck');
				document.body.style.paddingTop = header.offsetHeight + 'px';
			}
		} else {
			header.classList.remove('angar-stuck');
			document.body.style.paddingTop = '';
		}
		ticking = false;
	}

	window.addEventListener('scroll', function () {
		if (!ticking) {
			window.requestAnimationFrame(applyState);
			ticking = true;
		}
	}, { passive: true });

	// Carrousel accueil : fleches, puces, defilement auto, pause au survol
	var carousel = document.getElementById('angarCarousel');
	if (carousel) {
		var slides = carousel.querySelectorAll('.angar-carousel-slide');
		var dots = carousel.querySelectorAll('.angar-carousel-dot');
		var current = 0;
		var timer = null;

		function goTo(index) {
			index = (index + slides.length) % slides.length;
			slides[current].classList.remove('is-active');
			dots[current].classList.remove('is-active');
			current = index;
			slides[current].classList.add('is-active');
			dots[current].classList.add('is-active');
		}

		function next() { goTo(current + 1); }
		function prev() { goTo(current - 1); }

		function startAuto() {
			stopAuto();
			timer = window.setInterval(next, 5000);
		}
		function stopAuto() {
			if (timer) { window.clearInterval(timer); timer = null; }
		}

		carousel.querySelector('.angar-carousel-next').addEventListener('click', function () { next(); startAuto(); });
		carousel.querySelector('.angar-carousel-prev').addEventListener('click', function () { prev(); startAuto(); });
		dots.forEach(function (dot, i) {
			dot.addEventListener('click', function () { goTo(i); startAuto(); });
		});
		carousel.addEventListener('mouseenter', stopAuto);
		carousel.addEventListener('mouseleave', startAuto);

		startAuto();
	}
});
