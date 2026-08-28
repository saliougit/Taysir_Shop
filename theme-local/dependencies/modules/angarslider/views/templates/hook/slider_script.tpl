{*
* @author	Krzysztof Pecak
* @copyright	2024 Krzysztof Pecak
* @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

<script>
$(window).load(function(){
{if !empty($enableconfig)}

	var sliderConfig = {
		maxSlides: 1,
		slideWidth: 1920,
		infiniteLoop: true,
		auto: true,
		pager: {$pager},
		autoHover: {$pause_hover},
		speed: 500,
		pause: {$pause},
		adaptiveHeight: true,
		touchEnabled: true
	};

	var slider = $('#angarslider').bxSlider(sliderConfig);

	$('#theme_customization .page_width label, #theme_customization .slider_size label').on('click',function(){
		slider.reloadSlider(sliderConfig);
	});

{else}

	$('#angarslider').bxSlider({
		maxSlides: 1,
		slideWidth: 1920,
		infiniteLoop: true,
		auto: true,
		pager: {$pager},
		autoHover: {$pause_hover},
		speed: 500,
		pause: {$pause},
		adaptiveHeight: true,
		touchEnabled: true
	});

{/if}

});
</script>

