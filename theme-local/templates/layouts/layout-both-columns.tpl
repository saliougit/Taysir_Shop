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
<!doctype html>
<html lang="{$language.iso_code}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

{* AngarTheme *}
  <body id="{$page.page_name}" class="{$page.body_classes|classnames} {include file='_partials/theme_styles/body_classes.tpl'}">

    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    <main>
      {block name='product_activation'}
        {include file='catalog/_partials/product-activation.tpl'}
      {/block}

      <header id="header">
        {block name='header'}
          {include file='_partials/header.tpl'}
        {/block}
      </header>

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      {if $page.page_name == 'index'}
		<div class="hidden-md-up">{hook h="displayBelowMobileMenu"}</div>
      {/if}

      {* AngarThemes *}
      {if !empty($css7) && $css7 == 'slider_position_top' OR empty($css7)}
        {if $page.page_name == 'index'}
        <div id="slider_row">
            <div id="top_column">{hook h="displayTopColumn"}</div>
            <div class="clearfix"></div>
        </div>
        {/if}
      {/if}

      <section id="wrapper">
        {hook h="displayWrapperTop"}
        <div class="container">
			{* AngarThemes *}

			{if !empty($css7) && $css7 == 'slider_position_top' OR empty($css7)}
				{if $page.page_name == 'index'}
					{hook h='angarHomeCat'}
				{/if}
			{/if}

			<div class="row">
			  {if $page.page_name != 'index'}
			  {block name='breadcrumb'}
				{include file='_partials/breadcrumb.tpl'}
			  {/block}
			  {/if}

			  {block name="left_column"}
				<div id="left-column" class="columns col-xs-12 col-sm-4 col-md-3">
				  {* AngarThemes *}
				  {hook h="displayLeftColumn"}

				  {if $page.page_name == 'product'}
					{hook h='displayLeftColumnProduct'}
				  {/if}
				</div>
			  {/block}

			  {block name="content_wrapper"}
				<div id="content-wrapper" class="left-column right-column col-sm-4 col-md-6">
				  {hook h="displayContentWrapperTop"}
				  {block name="content"}
					<p>Hello world! This is HTML5 Boilerplate.</p>
				  {/block}
				  {hook h="displayContentWrapperBottom"}
				</div>
			  {/block}

			  {block name="right_column"}
				<div id="right-column" class="columns col-xs-12 col-sm-4 col-md-3">
				  {* AngarThemes *}
				  {hook h="displayRightColumn"}

				  {if $page.page_name == 'product'}
					{hook h='displayRightColumnProduct'}
				  {/if}
				</div>
			  {/block}
			</div>
        </div>
        {hook h="displayWrapperBottom"}

		<div class="container hook_box">
			{if $page.page_name == 'index'}
			  {hook h='angarCmsDesc'}
			  {hook h='angarParallax'}
			  {hook h='angarProductCat'}
			  {hook h='angarManufacturer'}
			  {hook h='angarBannersBottom'}
			  {hook h='angarCmsBottom'}

			  {hook h='displayAngarBeforeFooter'}

			{/if}

			{hook h='angarFacebook'}
		</div>

      </section>

      <footer id="footer">
        {block name="footer"}
          {include file="_partials/footer.tpl"}
        {/block}
      </footer>

    </main>

    {block name='javascript_bottom'}
      {if $smarty.const._PS_VERSION_ >= '8.0'}
        {include file="_partials/password-policy-template.tpl"}
      {/if}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
  </body>

</html>
