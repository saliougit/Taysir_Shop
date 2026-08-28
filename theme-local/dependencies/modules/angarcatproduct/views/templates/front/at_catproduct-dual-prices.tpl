{* AngarTheme - dual price *}

{if !empty($css74) && $css74 == "pl_price_default"}
	<div class="home_cat_price_default">
		<span class="price">{$product.price}</span>
		{if $product.has_discount}
		  {hook h='displayProductPriceBlock' product=$product type="old_price"}
		  <span class="regular-price">{$product.regular_price}</span>
		{/if}
	</div>
{/if}

{if !empty($css74) && $css74 == "pl_price_incl_excl"}
	<div class="home_cat_price_incl_excl">
		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
			  {/if}
		  {/if}
		  <span class="price">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax incl.' d='Shop.Theme.Checkout'}{else}{l s='Tax included' d='Shop.Theme.Checkout'}{/if}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc)}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax excl.' d='Shop.Theme.Checkout'}{else}{l s='Tax excluded' d='Shop.Theme.Checkout'}{/if}</span>
		</div>
	</div>
{/if}

{if !empty($css74) && $css74 == "pl_price_excl_incl"}
	<div class="home_cat_price_excl_incl">
		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
			  {/if}
		  {/if}
		  <span class="price">{Tools::displayPrice($product.price_tax_exc)}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax excl.' d='Shop.Theme.Checkout'}{else}{l s='Tax excluded' d='Shop.Theme.Checkout'}{/if}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax incl.' d='Shop.Theme.Checkout'}{else}{l s='Tax included' d='Shop.Theme.Checkout'}{/if}</span>
		</div>
	</div>
{/if}

{if !empty($css74) && $css74 == "pl_price_incl_tax_excl"}
	<div class="home_cat_price_incl_tax_excl">
		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
			  {/if}
		  {/if}
		  <span class="price">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax incl.' d='Shop.Theme.Checkout'}{else}{l s='Tax included' d='Shop.Theme.Checkout'}{/if}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax * ($product.rate / 100))}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc * ($product.rate / 100))}</span>
		  <span class="tax_label">{l s='Tax' d='Shop.Theme.Checkout'}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc)}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax excl.' d='Shop.Theme.Checkout'}{else}{l s='Tax excluded' d='Shop.Theme.Checkout'}{/if}</span>
		</div>
	</div>
{/if}

{if !empty($css74) && $css74 == "pl_price_excl_tax_incl"}
	<div class="home_cat_price_excl_tax_incl">
		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax)}</span>
			  {/if}
		  {/if}
		  <span class="price">{Tools::displayPrice($product.price_tax_exc)}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax excl.' d='Shop.Theme.Checkout'}{else}{l s='Tax excluded' d='Shop.Theme.Checkout'}{/if}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax * ($product.rate / 100))}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc * ($product.rate / 100))}</span>
		  <span class="tax_label">{l s='Tax' d='Shop.Theme.Checkout'}</span>
		</div>

		<div>
		  {if $smarty.const._PS_VERSION_ >= '1.7.6.0'}
			  {if $product.has_discount}
				<span class="regular-price">{Tools::displayPrice($product.price_without_reduction_without_tax + ($product.price_without_reduction_without_tax * ($product.rate / 100)))}</span>
			  {/if}
		  {/if}
		  <span class="price_small">{Tools::displayPrice($product.price_tax_exc + ($product.price_tax_exc * ($product.rate / 100)))}</span>
		  <span class="tax_label">{if $smarty.const._PS_VERSION_ >= '1.7.7.0'}{l s='tax incl.' d='Shop.Theme.Checkout'}{else}{l s='Tax included' d='Shop.Theme.Checkout'}{/if}</span>
		</div>
	</div>
{/if}
