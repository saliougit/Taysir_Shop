{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_default")}
	<div class="product_price_default">
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
	</div>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_excl")}
	<span class="price product_price_incl_excl">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_incl")}
	<span class="price product_price_excl_incl">{Tools::displayPrice($product.price_tax_exc)}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_tax_excl")}
	<span class="price product_price_incl_tax_excl">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_tax_incl")}
	<span class="price product_price_excl_tax_incl">{Tools::displayPrice($product.price_tax_exc)}</span>
{/if}
