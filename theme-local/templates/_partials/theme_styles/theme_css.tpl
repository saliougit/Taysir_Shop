<style type="text/css">

{* Background *}
@media (min-width:768px) {
	{if !empty($css1)}
		{if strstr($css1, 'texture')}
			{if preg_match('/texture(03|06|07|08|09|10|11|12|13|14|15|16)/', $css1)}
				.{$css1|escape:'html':'UTF-8'} { background-image: url({$urls.img_url}textures/{$css1|escape:'html':'UTF-8'}.png);}
			{else}
				.{$css1|escape:'html':'UTF-8'} { background-image: url({$urls.img_url}textures/{$css1|escape:'html':'UTF-8'}.jpg);}
			{/if}
		{else}
			{if $css1 != 'no_bg' AND $css1 != 'color_only'}
				.{$css1|escape:'html':'UTF-8'} { background-image: url({$urls.img_url}patterns/{$css1|escape:'html':'UTF-8'}.png);}
			{/if}
		{/if}
	{/if}
}

{* Css *}
body {
	background-color: {if !empty($css2)}{$css2|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
	font-family: "{if !empty($css59)}{$css59|escape:'htmlall':'UTF-8'|replace:'_':' '}{else}Poppins{/if}", Arial, Helvetica, sans-serif;
}

.products .product-miniature .product-title {
    height: {if !empty($css26)}{$css26|escape:'htmlall':'UTF-8'}{else}32{/if}px;
}

.products .product-miniature .product-title a {
    font-size: {if !empty($css27)}{$css27|escape:'htmlall':'UTF-8'}{else}14{/if}px;
    line-height: {if !empty($css28)}{$css28|escape:'htmlall':'UTF-8'}{else}16{/if}px;
}

#content-wrapper .products .product-miniature .product-desc {
    height: {if !empty($css61)}{$css61|escape:'htmlall':'UTF-8'}{else}36{/if}px;
}

@media (min-width: 991px) {
    #home_categories ul li .cat-container {
        min-height: {if !empty($css56)}{$css56|escape:'htmlall':'UTF-8'}{else}0{/if}px;
    }
}

{* Logo *}
@media (min-width: 768px) {
    #_desktop_logo {
        padding-top: {if !empty($css44)}{$css44|escape:'htmlall':'UTF-8'}{else}0{/if}px;
        padding-bottom: {if !empty($css60)}{$css60|escape:'htmlall':'UTF-8'}{else}0{/if}px;
    }
}

{* Colors *}
{* Nav *}
nav.header-nav {
    background: {if !empty($color1)}{$color1|escape:'htmlall':'UTF-8'}{else}#f6f6f6{/if};
}

nav.header-nav,
.header_sep2 #contact-link span.shop-phone,
.header_sep2 #contact-link span.shop-phone.shop-tel,
.header_sep2 #contact-link span.shop-phone:last-child,
.header_sep2 .lang_currency_top,
.header_sep2 .lang_currency_top:last-child,
.header_sep2 #_desktop_currency_selector,
.header_sep2 #_desktop_language_selector,
.header_sep2 #_desktop_user_info {
    border-color: {if !empty($color2)}{$color2|escape:'htmlall':'UTF-8'}{else}#d6d4d4{/if};
}

#contact-link,
#contact-link a,
.lang_currency_top span.lang_currency_text,
.lang_currency_top .dropdown i.expand-more,
nav.header-nav .user-info span,
nav.header-nav .user-info a.logout,
#languages-block-top div.current,
nav.header-nav a {
    color: {if !empty($color3)}{$color3|escape:'htmlall':'UTF-8'}{else}#000000{/if};
}

#contact-link span.shop-phone strong,
#contact-link span.shop-phone strong a,
.lang_currency_top span.expand-more,
nav.header-nav .user-info a.account {
    color: {if !empty($color4)}{$color4|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#contact-link span.shop-phone i {
    color: {if !empty($color5)}{$color5|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Header *}
.header-top {
    background: {if !empty($color6)}{$color6|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

div#search_widget form button[type=submit] {
    background: {if !empty($color7)}{$color7|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color78)}{$color78|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

div#search_widget form button[type=submit]:hover {
    background: {if !empty($color8)}{$color8|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color79)}{$color79|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}


{* Account cart *}
{*
a.account_cart_rwd {
    background: {if !empty($color59)}{$color59|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}
*}

#header div#_desktop_cart .blockcart .header {
    background: {if !empty($color9)}{$color9|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

#header div#_desktop_cart .blockcart .header a.cart_link {
    color: {if !empty($color80)}{$color80|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Sticky cart *}
{*
.cart_style2.stickycart_yes.sticky_cart #header div#_desktop_cart .blockcart .header {
    background: {if !empty($color86)}{$color86|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.cart_style2.stickycart_yes.sticky_cart #header div#_desktop_cart .blockcart .header a.cart_link span.cart-products-count {
    background: {if !empty($color87)}{$color87|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.cart_style2.stickycart_yes.sticky_cart #header div#_desktop_cart .blockcart .header a.cart_link {
    color: {if !empty($color88)}{$color88|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}
*}

{* Slider *}
#homepage-slider .bx-wrapper .bx-pager.bx-default-pager a:hover,
#homepage-slider .bx-wrapper .bx-pager.bx-default-pager a.active{
    background: {if !empty($color10)}{$color10|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

{* Menu *}
div#rwd_menu {
    background: {if !empty($color11)}{$color11|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

div#rwd_menu,
div#rwd_menu a {
    color: {if !empty($color13)}{$color13|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

div#rwd_menu,
div#rwd_menu .rwd_menu_item,
div#rwd_menu .rwd_menu_item:first-child {
    border-color: {if !empty($color12)}{$color12|escape:'htmlall':'UTF-8'}{else}#363636{/if};
}

div#rwd_menu .rwd_menu_item:hover,
div#rwd_menu .rwd_menu_item:focus,
div#rwd_menu .rwd_menu_item a:hover,
div#rwd_menu .rwd_menu_item a:focus {
    color: {if !empty($color14)}{$color14|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    background: {if !empty($color15)}{$color15|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

#mobile_top_menu_wrapper2 .top-menu li a:hover,
.rwd_menu_open ul.user_info li a:hover {
    background: {if !empty($color16)}{$color16|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color81)}{$color81|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#_desktop_top_menu{
    background: {if !empty($color11)}{$color11|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#_desktop_top_menu,
#_desktop_top_menu > ul > li,
.menu_sep1 #_desktop_top_menu > ul > li,
.menu_sep1 #_desktop_top_menu > ul > li:last-child,
.menu_sep2 #_desktop_top_menu,
.menu_sep2 #_desktop_top_menu > ul > li,
.menu_sep2 #_desktop_top_menu > ul > li:last-child,
.menu_sep3 #_desktop_top_menu,
.menu_sep4 #_desktop_top_menu,
.menu_sep5 #_desktop_top_menu,
.menu_sep6 #_desktop_top_menu {
    border-color: {if !empty($color12)}{$color12|escape:'htmlall':'UTF-8'}{else}#363636{/if};
}

#_desktop_top_menu > ul > li > a {
    color: {if !empty($color13)}{$color13|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

#_desktop_top_menu > ul > li:hover > a {
    color: {if !empty($color14)}{$color14|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    background: {if !empty($color15)}{$color15|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

.submenu1 #_desktop_top_menu .popover.sub-menu ul.top-menu li a:hover,
.submenu3 #_desktop_top_menu .popover.sub-menu ul.top-menu li a:hover,
.live_edit_0.submenu1 #_desktop_top_menu .popover.sub-menu ul.top-menu li:hover > a,
.live_edit_0.submenu3 #_desktop_top_menu .popover.sub-menu ul.top-menu li:hover > a {
    background: {if !empty($color16)}{$color16|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color81)}{$color81|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{*
.submenu1 #_desktop_top_menu .popover.sub-menu ul.top-menu li:hover > a,
.submenu3 #_desktop_top_menu .popover.sub-menu ul.top-menu li:hover > a {
    background: {if !empty($color16)}{$color16|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    color: {if !empty($color81)}{$color81|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}
*}

{* Featured categories *}
#home_categories .homecat_title span {
    border-color: {if !empty($color60)}{$color60|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#home_categories ul li .homecat_name span {
    background: {if !empty($color61)}{$color61|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#home_categories ul li a.view_more {
    background: {if !empty($color62)}{$color62|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color63)}{$color63|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    border-color: {if !empty($color64)}{$color64|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

#home_categories ul li a.view_more:hover {
    background: {if !empty($color65)}{$color65|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    color: {if !empty($color66)}{$color66|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color67)}{$color67|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Columns *}
.columns .text-uppercase a,
.columns .text-uppercase span,
.columns div#_desktop_cart .cart_index_title a,
#home_man_product .catprod_title a span {
    border-color: {if !empty($color17)}{$color17|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Tabs or blocks *}
#index .tabs ul.nav-tabs li.nav-item a.active,
#index .tabs ul.nav-tabs li.nav-item a:hover,
.index_title a,
.index_title span {
    border-color: {if !empty($color19)}{$color19|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Product-list *}
a.product-flags-plist span.product-flag,
a.product-flags-plist span.product-flag.new,
#home_cat_product a.product-flags-plist span.product-flag.new,
#product #content .product-flags li,
#product #content .product-flags .product-flag.new {
    background: {if !empty($color20)}{$color20|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

.products .product-miniature .product-title a,
#home_cat_product ul li .right-block .name_block a {
    color: {if !empty($color21)}{$color21|escape:'htmlall':'UTF-8'}{else}#282828{/if};
}

.products .product-miniature span.price,
#home_cat_product ul li .product-price-and-shipping .price,
.ui-widget .search_right span.search_price,
body#view #main .wishlist-product-price {
    color: {if !empty($color22)}{$color22|escape:'htmlall':'UTF-8'}{else}#ee0000{/if};
}

.button-container .add-to-cart:hover,
#subcart .cart-buttons .viewcart:hover,
body#view ul li.wishlist-products-item .wishlist-product-bottom .btn-primary:hover {
    background: {if !empty($color26)}{$color26|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    color: {if !empty($color27)}{$color27|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color28)}{$color28|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.button-container .add-to-cart,
.button-container .add-to-cart:disabled,
#subcart .cart-buttons .viewcart,
body#view ul li.wishlist-products-item .wishlist-product-bottom .btn-primary {
    background: {if !empty($color23)}{$color23|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color24)}{$color24|escape:'htmlall':'UTF-8'}{else}#000000{/if};
    border-color: {if !empty($color25)}{$color25|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

{* Products from category *}
#home_cat_product .catprod_title span {
    border-color: {if !empty($color68)}{$color68|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Featured manufacturers *}
#home_man .man_title span {
    border-color: {if !empty($color71)}{$color71|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Footer *}
div#angarinfo_block .icon_cms {
    color: {if !empty($color29)}{$color29|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

.footer-container {
    background: {if !empty($color30)}{$color30|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.footer-container,
.footer-container .h3,
.footer-container .links .title,
.row.social_footer {
    border-color: {if !empty($color31)}{$color31|escape:'htmlall':'UTF-8'}{else}#363636{/if};
}

.footer-container .h3 span,
.footer-container .h3 a,
.footer-container .links .title span.h3,
.footer-container .links .title a.h3 {
    border-color: {if !empty($color32)}{$color32|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
}

.footer-container,
.footer-container .h3,
.footer-container .links .title .h3,
.footer-container a,
.footer-container li a,
.footer-container .links ul>li a {
    color: {if !empty($color33)}{$color33|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

.block_newsletter .btn-newsletter {
    background: {if !empty($color34)}{$color34|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color82)}{$color82|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.block_newsletter .btn-newsletter:hover {
    background: {if !empty($color35)}{$color35|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color83)}{$color83|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.footer-container .bottom-footer {
    background: {if !empty($color36)}{$color36|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    border-color: {if !empty($color37)}{$color37|escape:'htmlall':'UTF-8'}{else}#363636{/if};
    color: {if !empty($color38)}{$color38|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

{* Product page *}
.product-prices .current-price span.price {
    color: {if !empty($color39)}{$color39|escape:'htmlall':'UTF-8'}{else}#ee0000{/if};
}

.product-add-to-cart button.btn.add-to-cart:hover {
    background: {if !empty($color43)}{$color43|escape:'htmlall':'UTF-8'}{else}#282828{/if};
    color: {if !empty($color44)}{$color44|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color45)}{$color45|escape:'htmlall':'UTF-8'}{else}#282828{/if};
}

.product-add-to-cart button.btn.add-to-cart,
.product-add-to-cart button.btn.add-to-cart:disabled {
    background: {if !empty($color40)}{$color40|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    color: {if !empty($color41)}{$color41|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color42)}{$color42|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#product .tabs ul.nav-tabs li.nav-item a.active,
#product .tabs ul.nav-tabs li.nav-item a:hover,
#product .index_title span,
.page-product-heading span,
body #product-comments-list-header .comments-nb {
    border-color: {if !empty($color46)}{$color46|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Other buttons *}
body .btn-primary:hover {
    background: {if !empty($color50)}{$color50|escape:'htmlall':'UTF-8'}{else}#3aa04c{/if};
    color: {if !empty($color51)}{$color51|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color52)}{$color52|escape:'htmlall':'UTF-8'}{else}#196f28{/if};
}

body .btn-primary,
body .btn-primary.disabled,
body .btn-primary:disabled,
body .btn-primary.disabled:hover {
    background: {if !empty($color47)}{$color47|escape:'htmlall':'UTF-8'}{else}#43b754{/if};
    color: {if !empty($color48)}{$color48|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
    border-color: {if !empty($color49)}{$color49|escape:'htmlall':'UTF-8'}{else}#399a49{/if};
}

body .btn-secondary:hover {
    background: {if !empty($color56)}{$color56|escape:'htmlall':'UTF-8'}{else}#eeeeee{/if};
    color: {if !empty($color57)}{$color57|escape:'htmlall':'UTF-8'}{else}#000000{/if};
    border-color: {if !empty($color58)}{$color58|escape:'htmlall':'UTF-8'}{else}#d8d8d8{/if};
}

body .btn-secondary,
body .btn-secondary.disabled,
body .btn-secondary:disabled,
body .btn-secondary.disabled:hover {
    background: {if !empty($color53)}{$color53|escape:'htmlall':'UTF-8'}{else}#f6f6f6{/if};
    color: {if !empty($color54)}{$color54|escape:'htmlall':'UTF-8'}{else}#000000{/if};
    border-color: {if !empty($color55)}{$color55|escape:'htmlall':'UTF-8'}{else}#d8d8d8{/if};
}

{* Other elements *}
.form-control:focus, .input-group.focus {
    border-color: {if !empty($color72)}{$color72|escape:'htmlall':'UTF-8'}{else}#dbdbdb{/if};
    outline-color: {if !empty($color72)}{$color72|escape:'htmlall':'UTF-8'}{else}#dbdbdb{/if};
}

body .pagination .page-list .current a,
body .pagination .page-list a:hover,
body .pagination .page-list .current a.disabled,
body .pagination .page-list .current a.disabled:hover {
    color: {if !empty($color73)}{$color73|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

.page-my-account #content .links a:hover i {
    color: {if !empty($color74)}{$color74|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

{* Scroll to top *}
#scroll_top {
    background: {if !empty($color76)}{$color76|escape:'htmlall':'UTF-8'}{else}#ffcf00{/if};
    color: {if !empty($color84)}{$color84|escape:'htmlall':'UTF-8'}{else}#222222{/if};
}

#scroll_top:hover,
#scroll_top:focus {
    background: {if !empty($color77)}{$color77|escape:'htmlall':'UTF-8'}{else}#222222{/if};
    color: {if !empty($color85)}{$color85|escape:'htmlall':'UTF-8'}{else}#ffffff{/if};
}

</style>
