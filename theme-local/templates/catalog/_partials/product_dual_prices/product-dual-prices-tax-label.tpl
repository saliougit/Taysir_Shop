{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_default")}
	{if $configuration.display_taxes_label}
		<span class="tax_label product_price_default">{$product.labels.tax_long}</span>
	{/if}
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_excl")}
	<span class="tax_label product_price_incl_excl">{l s='Tax included' d='Shop.Theme.Checkout'}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_incl")}
	<span class="tax_label product_price_excl_incl">{l s='Tax excluded' d='Shop.Theme.Checkout'}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_incl_tax_excl")}
	<span class="tax_label product_price_incl_tax_excl">{l s='Tax included' d='Shop.Theme.Checkout'}</span>
{/if}

{if isset($enableconfig) && isset($css75) && ($enableconfig == 1 OR $css75 == "product_price_excl_tax_incl")}
	<span class="tax_label product_price_excl_tax_incl">{l s='Tax excluded' d='Shop.Theme.Checkout'}</span>
{/if}
