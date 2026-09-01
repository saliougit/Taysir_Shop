document.addEventListener('DOMContentLoaded', function () {
	// "Contact us" n'a pas de traduction francaise dans le catalogue de PrestaShop
	// (ni en base ni dans un fichier de theme trouvable) : correctif rapide en JS.
	document.querySelectorAll('a[id^="link-static-page-contact-"]').forEach(function (el) {
		if (el.textContent.trim() === 'Contact us') {
			el.textContent = 'Nous contacter';
		}
	});

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
		// "page-home" est une classe posee sur #content (index.tpl), pas sur
		// <body> (qui porte "page-index") : verifier document.body ici a
		// toujours silencieusement echoue.
		var contentEl = document.getElementById('content');
		if (!contentEl || !contentEl.classList.contains('page-home')) {
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

	// ============================================================
	// Animation "vol vers le panier" au clic sur "Ajouter au panier" :
	// une miniature du produit s'envole visuellement jusqu'à l'icône
	// panier du header, qui reagit ensuite avec un petit rebond + pulse
	// sur le badge. Purement visuel : n'intercepte pas le clic, l'ajout
	// AJAX normal de PrestaShop continue de se faire en parallèle.
	// ============================================================
	function setupFlyToCart() {
		var reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
		var cartIconSelector = '#header div#_desktop_cart .blockcart .header';
		if (!document.querySelector(cartIconSelector)) {
			return;
		}

		// Ecoute en phase de capture (3e argument = true) : certains gestionnaires
		// PrestaShop desactivent le bouton "Ajouter au panier" des le clic (anti
		// double-soumission). En bubble, notre listener s'executait APRES et
		// voyait donc btn.disabled=true, annulant l'animation. En capture, on
		// passe en premier, avant que quoi que ce soit d'autre ne desactive le bouton.
		document.addEventListener('click', function (e) {
			var btn = e.target.closest('.add-to-cart');
			if (!btn) {
				return;
			}

			// Reinterroge le DOM a CHAQUE clic : PrestaShop remplace l'icone panier
			// (rafraichissement AJAX du mini-panier apres chaque ajout), donc une
			// reference mise en cache une seule fois au chargement devient orpheline
			// (detachee du document) des le 2e ajout, et l'animation ne se voit plus.
			var cartIcon = document.querySelector(cartIconSelector);
			if (!cartIcon) {
				return;
			}

			// Petit rebond du panier a chaque ajout, meme sans image trouvee
			function bumpCart() {
				cartIcon.classList.remove('angar-cart-bump');
				// force reflow pour pouvoir relancer l'animation si on clique vite plusieurs fois
				void cartIcon.offsetWidth;
				cartIcon.classList.add('angar-cart-bump');
			}

			if (reduced) {
				window.setTimeout(bumpCart, 300);
				return;
			}

			var card = btn.closest('.product_container, .product-container, .product-miniature, #product, .quickview');
			var img = card ? card.querySelector('img') : null;
			var cartRect = cartIcon.getBoundingClientRect();

			if (!img || !cartRect.width) {
				window.setTimeout(bumpCart, 300);
				return;
			}

			var imgRect = img.getBoundingClientRect();
			var clone = img.cloneNode(true);
			clone.setAttribute('aria-hidden', 'true');
			clone.className = 'angar-fly-to-cart';
			clone.style.left = imgRect.left + 'px';
			clone.style.top = imgRect.top + 'px';
			clone.style.width = imgRect.width + 'px';
			clone.style.height = imgRect.height + 'px';
			document.body.appendChild(clone);

			var dx = (cartRect.left + cartRect.width / 2) - (imgRect.left + imgRect.width / 2);
			var dy = (cartRect.top + cartRect.height / 2) - (imgRect.top + imgRect.height / 2);

			window.requestAnimationFrame(function () {
				clone.style.transform = 'translate(' + dx + 'px, ' + dy + 'px) scale(0.12)';
				clone.style.opacity = '0.25';
			});

			window.setTimeout(function () {
				clone.remove();
				bumpCart();
			}, 700);
		}, true);
	}
	setupFlyToCart();

	// ============================================================
	// Trainee doree au curseur, page d'accueil uniquement : de petites
	// particules apparaissent au fil du mouvement de la souris et
	// s'evaporent derriere elle. Desactivee sur tactile (pas de "survol"
	// qui a du sens) et si l'utilisateur reduit les animations.
	// ============================================================
	function setupCursorTrail() {
		// "page-home" est une classe posee sur #content (index.tpl), pas sur
		// <body> (qui porte "page-index") : verifier document.body ici a
		// toujours silencieusement echoue.
		var contentEl = document.getElementById('content');
		if (!contentEl || !contentEl.classList.contains('page-home')) {
			return;
		}
		if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
			return;
		}
		if (!window.matchMedia('(hover: hover) and (pointer: fine)').matches) {
			return;
		}

		var lastSpawn = 0;
		var minInterval = 45; // ms entre deux particules : trainee fluide sans saturer le DOM

		document.addEventListener('mousemove', function (e) {
			var now = performance.now();
			if (now - lastSpawn < minInterval) {
				return;
			}
			lastSpawn = now;

			var spark = document.createElement('span');
			spark.className = 'angar-cursor-spark';
			spark.style.left = e.clientX + 'px';
			spark.style.top = e.clientY + 'px';
			// leger decalage aleatoire pour un nuage plus organique qu'une ligne parfaite
			spark.style.marginLeft = (Math.random() * 8 - 4) + 'px';
			spark.style.marginTop = (Math.random() * 8 - 4) + 'px';
			document.body.appendChild(spark);

			window.setTimeout(function () {
				spark.remove();
			}, 850);
		}, { passive: true });
	}
	setupCursorTrail();
});
