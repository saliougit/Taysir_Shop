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

{* AngarTheme *}

{if $product.show_price}
  <div class="product-prices">

	{block name='product_discount'}
	  {if $product.has_discount}
		<div class="product-discount">
		  {hook h='displayProductPriceBlock' product=$product type="old_price"}
			{if (empty($enableconfig) OR $enableconfig != 1) && empty($css75)}
			 <span class="regular-price">{$product.regular_price}</span>
			{/if}

			{include file='catalog/_partials/product_dual_prices/product-dual-prices-old-price.tpl'}

		</div>
	  {/if}
	{/block}

	{block name='product_price'}
	  <div class="product-price h5 {if $product.has_discount}has-discount{/if}">
		<div class="current-price">

		  {if (empty($enableconfig) OR $enableconfig != 1) && empty($css75)}

			<span class="price" content="{$product.price_amount}">{$product.price}</span>

			{if $product.has_discount}
				{if $product.discount_type === 'percentage'}
				  <span class="discount discount-percentage product_price_default">{l s='Save %percentage%' d='Shop.Theme.Catalog' sprintf=['%percentage%' => $product.discount_percentage_absolute]}</span>
				{else}
				  <span class="discount discount-amount product_price_default">
					  {l s='Save %amount%' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.discount_to_display]}
				  </span>
				{/if}
			{/if}

		  {/if}

		  {include file='catalog/_partials/product_dual_prices/product-dual-prices-main-price.tpl'}

		</div>
	  </div>
	{/block}

	{block name='product_tax_labels'}
		<div class="tax-shipping-delivery-label tax_label">
			{if (empty($enableconfig) OR $enableconfig != 1) && empty($css75)}
				{if $configuration.display_taxes_label}
					<span class="tax_label">{$product.labels.tax_long}</span>
				{/if}
			{/if}
			{include file='catalog/_partials/product_dual_prices/product-dual-prices-tax-label.tpl'}
		</div>
	{/block}

	<div class="clearfix"></div>

	{include file='catalog/_partials/product_dual_prices/product-dual-prices-small-price.tpl'}

	{block name='product_unit_price'}
	  {if $displayUnitPrice}
		<p class="product-unit-price sub">{$product.unit_price_full|replace:' ':' / '} {if $configuration.display_taxes_label}{$product.labels.tax_long}{/if}</p>
	  {/if}
	{/block}


    {block name='product_without_taxes'}
      {if $priceDisplay == 2}
        <p class="product-without-taxes">{l s='%price% tax excl.' d='Shop.Theme.Catalog' sprintf=['%price%' => $product.price_tax_exc]}</p>
      {/if}
    {/block}

    {block name='product_ecotax'}
      {if $product.ecotax.amount > 0}
        <p class="price-ecotax">{l s='Including %amount% for ecotax' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.ecotax.value]}
          {if $product.has_discount}
            {l s='(not impacted by the discount)' d='Shop.Theme.Catalog'}
          {/if}
        </p>
      {/if}
    {/block}

    {hook h='displayProductPriceBlock' product=$product type="weight" hook_origin='product_sheet'}

    <div class="shipping-delivery-label">
      {hook h='displayProductPriceBlock' product=$product type="price"}
      {hook h='displayProductPriceBlock' product=$product type="after_price"}
    </div>

    {block name='product_pack_price'}
      {if $displayPackPrice}
        <p class="product-pack-price"><span>{l s='Instead of %price%' d='Shop.Theme.Catalog' sprintf=['%price%' => $noPackPrice]}</span></p>
      {/if}
    {/block}

	{if $smarty.const._PS_VERSION_ >= '1.7.3.0'}
	  {if $product.is_virtual == 0}
		  {if $product.additional_delivery_times == 1}
			{if $product.delivery_information}
			  <span class="delivery-information">{$product.delivery_information}</span>
			{/if}
		  {elseif $product.additional_delivery_times == 2}
			{if $product.quantity > 0}
			  {if $product.delivery_in_stock}<span class="delivery-information">{$product.delivery_in_stock}</span>{/if}
			{* Out of stock message should not be displayed if customer can't order the product. *}
			{elseif $product.quantity <= 0 && $product.add_to_cart_url}
			  {if $product.delivery_out_stock}<span class="delivery-information">{$product.delivery_out_stock}</span>{/if}
			{/if}
		  {/if}
	  {/if}
	{/if}

	<div class="clearfix"></div> {* AngarTheme *}

  </div>
{/if}
