{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
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
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

<div class="block_newsletter block" id="blockEmailSubscription_{if $smarty.const._PS_VERSION_ >= '1.7.8.0'}{$hookName}{else}displayLeftColumn{/if}">
  <form action="{$urls.current_url}#blockEmailSubscription_{if $smarty.const._PS_VERSION_ >= '1.7.8.0'}{$hookName}{else}displayLeftColumn{/if}" method="post">
      <div id="block-newsletter-label" class="h6 text-uppercase facet-label"><span>{l s='Newsletter' d='Modules.Emailsubscription.Shop'}</span></div>

	<div class="block_content row">
      <div class="col-xs-12 mb-1">
        <input
          class="btn btn-newsletter float-xs-right"
          name="submitNewsletter"
          type="submit"
          value="{l s='OK' d='Shop.Theme.Actions'}"
        >
        <div class="input-wrapper">
          <input
            name="email"
            type="text"
            value="{$value}"
            placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
            aria-labelledby="block-newsletter-label"
          >
        </div>
        <input type="hidden" name="blockHookName" value="{if $smarty.const._PS_VERSION_ >= '1.7.8.0'}{$hookName}{else}displayLeftColumn{/if}" />
        <input type="hidden" name="action" value="0">
        <div class="clearfix"></div>
      </div>
      <div class="col-xs-12 news_info_column">
        {if !empty($conditions)}
          <p>{$conditions}</p>
        {/if}
        {if $msg}
          <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
            {$msg}
          </p>
        {/if}
        {hook h='displayNewsletterRegistration'}
        {if isset($id_module)}
          {hook h='displayGDPRConsent' id_module=$id_module}
        {/if}
      </div>
	</div>
  </form>
</div>
