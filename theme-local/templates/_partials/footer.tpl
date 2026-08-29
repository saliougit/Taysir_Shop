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
<div class="container">
  <div class="row">
    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}
  </div>
</div>

<div class="footer-container">

  <div class="container">

    <div class="row">
      <div class="col-xs-12 angar-footer-brand">
        <a class="angar-footer-brand-link" href="{$urls.base_url}" aria-label="{$shop.name|escape:'html':'UTF-8'}">
          <img class="angar-footer-brand-logo" src="{$urls.base_url}images/logo_taysir_shop-preview.png" alt="{$shop.name|escape:'html':'UTF-8'}">
        </a>
      </div>
    </div>

    <div class="row angar-footer-intro">
      <div class="col-xs-12">
        <p class="angar-footer-blurb">{$shop.name} — cosmétiques, habillement et articles de spiritualité mouride. Livrés partout où vous êtes.</p>
        <div class="angar-footer-social">
          <a href="#" aria-label="Facebook">{include file='_partials/icons/facebook.tpl'}</a>
          <a href="#" aria-label="Instagram">{include file='_partials/icons/instagram.tpl'}</a>
          <a href="#" aria-label="WhatsApp">{include file='_partials/icons/whatsapp.tpl'}</a>
        </div>
      </div>
    </div>

    <div class="row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>

    <div class="row social_footer">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>

  </div>

  <div class="bottom-footer">
      {block name='copyright_link'}
        {l s='%copyright% Copyright %year% %shop_name%. All Rights Reserved.' sprintf=['%shop_name%' => $shop.name|escape:'html':'UTF-8', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Mytheme'}
      {/block}
  </div>

</div>
