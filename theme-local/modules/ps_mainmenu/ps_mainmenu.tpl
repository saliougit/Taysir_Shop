{* AngarTheme *}

{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}

      <ul class="top-menu container" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">

		{if $depth == 0}
			<li class="home_icon"><a href="{$urls.base_url}"><i class="icon-home"></i><span>{l s='Home' d='Shop.Theme.Global'}</span></a></li>
		{/if}

	    {if $nodes|count}

			{foreach from=$nodes item=node}
				<li class="{$node.type}{if $node.current} current {/if}" id="{$node.page_identifier}">
				{assign var=_counter value=$_counter+1}
				  <a
					class="{if $depth >= 0}dropdown-item{/if}{if $depth === 1} dropdown-submenu{/if}{if $node.children|count} sf-with-ul{/if}"
					href="{$node.url}" data-depth="{$depth}"
					{if $node.open_in_new_window} target="_blank" {/if}
				  >
					{if $node.children|count}
					  {* Cannot use page identifier as we can have the same page several times *}
					  {assign var=_expand_id value=10|mt_rand:100000}
					  <span class="float-xs-right hidden-md-up">
						<span data-target="#top_sub_menu_{$_expand_id}" data-toggle="collapse" class="navbar-toggler collapse-icons">
						  <i class="material-icons add">&#xE313;</i>
						  <i class="material-icons remove">&#xE316;</i>
						</span>
					  </span>
					{/if}
					{if $node.page_identifier == 'category-10'}<span class="angar-menu-icon">{include file='_partials/icons/cosmetics.tpl'}</span>{elseif $node.page_identifier == 'category-11'}<span class="angar-menu-icon">{include file='_partials/icons/clothing.tpl'}</span>{elseif $node.page_identifier == 'category-12'}<span class="angar-menu-icon">{include file='_partials/icons/spirituality.tpl'}</span>{/if}
					{$node.label}
				  </a>
				  {if $node.children|count}
				  <div {if $depth === 0} class="popover sub-menu js-sub-menu collapse"{else} class="collapse"{/if} id="top_sub_menu_{$_expand_id}">
					{menu nodes=$node.children depth=$node.depth parent=$node}
					{if $depth === 0}
						{if $node.type == 'category'}
							{if $node.image_urls|count}
								<div class="menu-images-container">
									{foreach from=$node.image_urls item=image_url}
										<img src="{$image_url}">
									{/foreach}
									<div class="clearfix"></div>
								</div>
							{/if}
						{/if}
					{/if}
				  </div>
				  {/if}
				</li>
			{/foreach}

		{/if}

      </ul>

{/function}

<div class="menu js-top-menu position-static hidden-sm-down" id="_desktop_top_menu">
    {menu nodes=$menu.children}
    <div class="clearfix"></div>
</div>

