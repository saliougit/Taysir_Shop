{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{* AngarThemes *}

{extends file='page.tpl'}

    {block name='page_content_container'}
      <section id="content" class="page-home">

		{if !empty($css7) && $css7 == 'slider_position_column'}
			{if $page.page_name == 'index'}
			<div id="slider_row">
				<div id="top_column">{hook h="displayTopColumn"}</div>
				<div class="clearfix"></div>
			</div>
			{hook h='angarHomeCat'}
			{/if}
		{/if}

        {block name='page_content_top'}
          {if $page.page_name == 'index'}
            <div class="angar-carousel" id="angarCarousel">
              <div class="angar-carousel-track">
                <div class="angar-carousel-slide is-active">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner1.jpg');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner1.jpg" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner2.png');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner2.png" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner3.png');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner3.png" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner4.jpg');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner4.jpg" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner5.jpg');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner5.jpg" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner6.jpg');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner6.jpg" alt="">
                </div>
                <div class="angar-carousel-slide">
                  <div class="angar-carousel-bg" style="background-image: url('{$urls.theme_assets}img/banners/banner7.png');"></div>
                  <img src="{$urls.theme_assets}img/banners/banner7.png" alt="">
                </div>
              </div>
              <button type="button" class="angar-carousel-arrow angar-carousel-prev" aria-label="Précédent">
                <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
              </button>
              <button type="button" class="angar-carousel-arrow angar-carousel-next" aria-label="Suivant">
                <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
              </button>
              <div class="angar-carousel-dots">
                <button type="button" class="angar-carousel-dot is-active" aria-label="Image 1"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 2"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 3"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 4"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 5"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 6"></button>
                <button type="button" class="angar-carousel-dot" aria-label="Image 7"></button>
              </div>
            </div>
            <div class="angar-hero">
              <span class="angar-hero-greeting" data-reveal="fade" data-reveal-delay="1">Bienvenue chez</span>
              <h1 data-reveal="fade" data-reveal-delay="2">{$shop.name}</h1>
              <p data-reveal="fade" data-reveal-delay="3">Cosmétiques, habillement et articles de spiritualité</p>
            </div>
            <span class="angar-section-label" data-reveal="fade" data-reveal-delay="1">Nos Catégories</span>
            <div class="angar-departments">
              <a class="angar-department angar-department--cosmetiques" href="{$link->getCategoryLink(10)}" data-reveal="up" data-reveal-delay="1">
                <span class="angar-department-icon">{include file='_partials/icons/cosmetics.tpl'}</span>Cosmétiques
              </a>
              <a class="angar-department angar-department--habillement" href="{$link->getCategoryLink(11)}" data-reveal="up" data-reveal-delay="2">
                <span class="angar-department-icon">{include file='_partials/icons/clothing.tpl'}</span>Habillement
              </a>
              <a class="angar-department angar-department--spiritualite" href="{$link->getCategoryLink(12)}" data-reveal="up" data-reveal-delay="3">
                <span class="angar-department-icon">{include file='_partials/icons/spirituality.tpl'}</span>Spiritualité
              </a>
            </div>
          {/if}
        {/block}
    
		{hook h='displayAngarAboveTabs'}

        {block name='page_content'}
          {assign var='HOOK_HOME_TAB_CONTENT' value=Hook::exec('displayHomeTabContent')}
          {assign var='HOOK_HOME_TAB' value=Hook::exec('displayHomeTab')}
          {if isset($HOOK_HOME_TAB_CONTENT) && $HOOK_HOME_TAB_CONTENT|trim}
            <div class="tabs">
                {if isset($HOOK_HOME_TAB) && $HOOK_HOME_TAB|trim}
                    <ul id="home-page-tabs" class="nav nav-tabs clearfix">
                        {$HOOK_HOME_TAB nofilter}
                    </ul>
                {/if}
                <div class="tab-content" id="tab-content">{$HOOK_HOME_TAB_CONTENT nofilter}</div>
            </div>
          {/if}

		  {$HOOK_HOME nofilter}

        {/block}
      </section>
    {/block}
