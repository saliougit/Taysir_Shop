	{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_default")}
		<span class="regular-price product_price_default">{$product.regular_price}</span>
	{/if}

{if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
	{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_excl")}
		<span class="regular-price product_price_incl_excl">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
	{/if}

	{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_incl")}
		<span class="regular-price product_price_excl_incl">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
	{/if}

	{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_tax_excl")}
		<span class="regular-price product_price_incl_tax_excl">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
	{/if}

	{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_tax_incl")}
		<span class="regular-price product_price_excl_tax_incl">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
	{/if}
{/if}
