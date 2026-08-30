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

	// ============================================================
	// Révélations au scroll (Intersection Observer)
	// Les éléments porteurs de [data-reveal] (ou ajoutés dynamiquement
	// via .js-reveal pour les blocs issus de modules) apparaissent en
	// fondu + léger glissement une fois qu'ils entrent dans le viewport.
	// Respecte prefers-reduced-motion : dans ce cas tout reste visible.
	// ============================================================
	function markModuleReveals() {
		if (!document.body.classList.contains('page-home')) {
			return;
		}
		// Blocs produits "par sous-catégorie" (module angarcatproduct) : on arme
		// chaque carte produit, en ne le faisant qu'une fois (tag .js-reveal).
		document.querySelectorAll('#home_cat_product ul[id^="bxslider_"] > li:not(.js-reveal)')
			.forEach(function (el, i) {
				el.classList.add('js-reveal');
				el.setAttribute('data-reveal-delay', (i % 4) + 1);
			});
		document.querySelectorAll('#home_cat_product .catprod_title a:not(.js-reveal)')
			.forEach(function (el) { el.classList.add('js-reveal'); el.setAttribute('data-reveal-delay', 1); });
		// Badges de réassurance
		document.querySelectorAll('.block-reassurance ul li:not(.js-reveal)')
			.forEach(function (el, i) { el.classList.add('js-reveal'); el.setAttribute('data-reveal-delay', (i % 4) + 1); });
	}

	function setupReveals() {
		var reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
		markModuleReveals();
		var selectors = [
			'[data-reveal]',
			'.js-reveal'
		];
		var items = [];
		selectors.forEach(function (sel) {
			Array.prototype.push.apply(items, Array.from(document.querySelectorAll(sel)));
		});

		if (reduced || !('IntersectionObserver' in window)) {
			items.forEach(function (el) { el.classList.add('is-visible'); });
			return;
		}

		var observer = new IntersectionObserver(function (entries, obs) {
			entries.forEach(function (entry) {
				if (entry.isIntersecting) {
					entry.target.classList.add('is-visible');
					obs.unobserve(entry.target);
				}
			});
		}, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

		items.forEach(function (el) { observer.observe(el); });
	}
	setupReveals();
});
