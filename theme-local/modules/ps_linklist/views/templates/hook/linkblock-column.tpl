{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License version 3.0
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License version 3.0
 *}

{foreach $linkBlocks as $linkBlock}
	<div class="list-block block">
		<div class="h6 text-uppercase facet-label"><span>{$linkBlock.title}</span></div>
		<div class="block_content">
			<ul>
				{foreach $linkBlock.links as $link}
				  <li>
					<a
						id="{$link.id}-{$linkBlock.id}"
						class="{$link.class}"
						href="{$link.url}"
						title="{$link.description}"
						{if !empty($link.target)} target="{$link.target}" {/if}
					>
					  {$link.title}
					</a>
				  </li>
				{/foreach}
			</ul>
		</div>
	</div>
{/foreach}
