{**
 * AngarTheme : illustration decorative pour le footer — un personnage qui
 * pousse un chariot de courses (roues visibles, legere animation de
 * "balade"/roulement) pour renforcer l'ambiance e-commerce du site.
 * Purement decoratif : aria-hidden, aucune info n'est portee par le SVG.
 *}
<svg class="angar-cart-walker" viewBox="0 0 320 170" xmlns="http://www.w3.org/2000/svg" role="img" aria-hidden="true" focusable="false">

  <ellipse class="angar-cw-shadow" cx="168" cy="156" rx="128" ry="8"></ellipse>

  <g class="angar-cw-stroll">

    <!-- traits de mouvement derriere le chariot -->
    <g class="angar-cw-motion-lines">
      <path d="M4 96 H34"></path>
      <path d="M0 112 H26"></path>
      <path d="M10 128 H36"></path>
    </g>

    <!-- personnage -->
    <g class="angar-cw-person">
      <circle class="angar-cw-head" cx="52" cy="44" r="14"></circle>
      <path class="angar-cw-body" d="M52 58 L46 100"></path>
      <path class="angar-cw-arm" d="M48 68 L86 80"></path>
      <g class="angar-cw-leg-back">
        <path d="M46 100 L26 140"></path>
      </g>
      <g class="angar-cw-leg-front">
        <path d="M46 100 L66 138"></path>
      </g>
    </g>

    <!-- chariot -->
    <g class="angar-cw-cart">
      <path class="angar-cw-handlebar" d="M86 58 L86 80 L108 80"></path>
      <path class="angar-cw-basket" d="M108 58 H218 L206 110 H120 Z"></path>
      <path class="angar-cw-basket-lines" d="M126 58 L134 110 M218 58 L206 110 M108 58 L120 110"></path>
      <path class="angar-cw-frame" d="M120 110 L112 130 M206 110 L214 130"></path>

      <g class="angar-cw-wheel angar-cw-wheel-rear">
        <circle cx="112" cy="134" r="11"></circle>
        <circle class="angar-cw-hub" cx="112" cy="134" r="3"></circle>
        <path d="M112 127 V141 M105 134 H119"></path>
      </g>
      <g class="angar-cw-wheel angar-cw-wheel-front">
        <circle cx="214" cy="134" r="11"></circle>
        <circle class="angar-cw-hub" cx="214" cy="134" r="3"></circle>
        <path d="M214 127 V141 M207 134 H221"></path>
      </g>
    </g>

  </g>
</svg>
