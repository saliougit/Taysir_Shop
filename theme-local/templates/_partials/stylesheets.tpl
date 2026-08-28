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

{foreach $stylesheets.external as $stylesheet}
  <link rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
{/foreach}

{foreach $stylesheets.inline as $stylesheet}
  <style>
    {$stylesheet.content}
  </style>
{/foreach}

{include file='_partials/theme_styles/theme_css.tpl'}

{* AngarTheme *}
{if !empty($css59)}
<link rel="stylesheet" rel="preload" as="style" href="http{if Tools::usingSecureMode()}s{/if}://fonts.googleapis.com/css?family={$css59|escape:'htmlall':'UTF-8'|replace:'_':'+'}:400,{if $css59 == Poppins OR $css59 == Open_Sans OR $css59 == Oswald OR $css59 == Dosis OR $css59 == Raleway OR $css59 == Montserrat OR $css59 == Nunito OR $css59 == Fira_Sans OR $css59 == Titillium_Web}600{else}700{/if}&amp;subset=latin,latin-ext&display=block" type="text/css" media="all" />
{else}
<link rel="stylesheet" rel="preload" as="style" href="http{if Tools::usingSecureMode()}s{/if}://fonts.googleapis.com/css?family=Poppins:400,600&amp;subset=latin,latin-ext&display=block" type="text/css" media="all" />
{/if}

