{*
* @author	Krzysztof Pecak
* @copyright	2024 Krzysztof Pecak
* @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}
{* AngarTheme *}

{if $angarwhatsapp_phone != ''}
	<div id="whatsapp-chat-footer" class="style_{$angarwhatsapp_style} position_{$angarwhatsapp_position} size_{$angarwhatsapp_size}">
		<a href="https://wa.me/{$angarwhatsapp_phone}?text={$angarwhatsapp_default_message}" target="_blank" title="{l s='Contact us on WhatsApp' mod='angarwhatsapp'}">
			<span>{l s='WhatsApp' mod='angarwhatsapp'}</span>
		</a>
	</div>
{/if}

