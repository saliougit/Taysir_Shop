{*
* @author	Krzysztof Pecak
* @copyright	2017 Krzysztof Pecak
* @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*
* AngarTheme override : utilise 'medium_default' (452x452) au lieu de
* 'small_default' (98x98) pour la vignette produit, sinon l'image agrandie
* en CSS (~250px de large) rendait flou.
*}

{if $catprod_id}

<div id="home_cat_product">

	<div class="row">
	{foreach from=$catProducts item=catProduct name=atCatProducts}

		<div id="block_id_{$catProduct.id|escape:'htmlall':'UTF-8'}" class="col-xs-12 col-sm-3">

			<div class="catprod_title">
				<a href="{$link->getCategoryLink({$catProduct.id|escape:'htmlall':'UTF-8'},{$catProduct.link_rewrite})|escape:'html':'UTF-8'}" title="{$catProduct.name|escape:'htmlall':'UTF-8'}">
					<span>{$catProduct.name|escape:'htmlall':'UTF-8'}</span>
				</a>

				<div class="arrows_container">
					<div id="home-next_{$catProduct.id|escape:'htmlall':'UTF-8'}" class="slider-btn"></div>
					<div id="home-prev_{$catProduct.id|escape:'htmlall':'UTF-8'}" class="slider-btn"></div>
				</div>
			</div>

			<div class="bx_box">
				<ul id="bxslider_{$catProduct.id|escape:'htmlall':'UTF-8'}">
					{foreach from=$catProduct.product item=product name=myLoop}
					<li>
						<div class="product_container">
							<div class="left-block">
								<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}">
								{if !empty($product.cover.bySize.home_default.url)}
									<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'medium_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($product.cover.bySize.medium_default)} loading="lazy" width="{$product.cover.bySize.medium_default.width}" height="{$product.cover.bySize.medium_default.height}"{/if} />
								{else}
									<img class="replace-2x img-responsive" src = "{$urls.img_url}en-default-home_default.jpg" alt = "{$product.name|truncate:30:'...'}" {if isset($product.cover.bySize.medium_default)} loading="lazy" width="{$product.cover.bySize.medium_default.width}" height="{$product.cover.bySize.medium_default.height}" {/if} />
								{/if}
								</a>

								<a href="{$product.link|escape:'html':'UTF-8'}" class="product-flags-plist">
									{if isset($product.new) && $product.new == 1}
										<span class="product-flag new">{l s='New' mod='angarcatproduct'}</span>
									{/if}

									{if $product.reduction != 0}
										{if $product.discount_type === 'percentage'}
											<span class="product-flag on-sale">{$product.discount_percentage}</span>
										{/if}

										{if $product.discount_type === 'amount'}
											<span class="product-flag on-sale">-{$product.discount_amount}</span>
										{/if}
									{/if}
								</a>
							</div>

							<div class="right-block">
								<div class="name_block">
									{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
									<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" >
										{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
									</a>
								</div>
								{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
								{if $smarty.capture.displayProductListReviews}
									<div class="hook-reviews">
										{hook h='displayProductListReviews' product=$product}
									</div>
								{/if}

								{block name='product_shortdesc'}
									<p class="product-desc">
										{$product.description_short|strip_tags:'UTF-8'|truncate:40:'...'}
									</p>
								{/block}

								{if $product.show_price}
									<div class="product-price-and-shipping">
										{hook h='displayProductPriceBlock' product=$product type="before_price"}

										{include file='module:angarcatproduct/views/templates/front/at_catproduct-dual-prices.tpl'}

										{if (empty($enableconfig) OR $enableconfig != 1) && empty($css74)}
											<span class="price">{$product.price}</span>
											{if $product.has_discount}
												{hook h='displayProductPriceBlock' product=$product type="old_price"}
												<span class="regular-price">{$product.regular_price}</span>
											{/if}
										{/if}

										{hook h='displayProductPriceBlock' product=$product type='unit_price'}
										{hook h='displayProductPriceBlock' product=$product type='weight'}
									</div>
								{/if}
							</div>

							<div class="clearfix"></div>

						</div>

					</li>
					{/foreach}
				</ul>

			</div>

		</div>
	{/foreach}
	</div>

</div>

{/if}

<div class="clearfix"></div>
