{*
* @author	Krzysztof Pecak
* @copyright	2024 Krzysztof Pecak
* @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}
{* AngarTheme *}

{if $angarwhatsapp_phone != ''}
	{if $angarwhatsapp_productlink == "1"}
		<a class="whatsapp_button" href="https://wa.me/{$angarwhatsapp_phone}?text={$angarwhatsapp_productpage_message} {$urls.current_url}" target="_blank" title="{l s='Contact us on WhatsApp' mod='angarwhatsapp'}">
			<i class="fa fa-whatsapp"></i><span>{l s='Ask about the product on WhatsApp' mod='angarwhatsapp'}</span>
		</a>
	{/if}
{/if}