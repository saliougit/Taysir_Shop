<div class="home_blog">
<h3 class='index_title'><span>{l s='Latest News' mod='smartblog'}</span></h3>
<div class="products">

        {if isset($view_data) AND !empty($view_data)}
            {assign var='i' value=1}
            {foreach from=$view_data item=post}
               
                    {assign var="options" value=null}
                    {$options.id_post = $post.id}
                    {$options.slug = $post.link_rewrite}
			<div class="product-miniature col-xs-12 col-sm-4 col-md-4">
				<div class="thumbnail-container">

                        <div class="product-image-container">
                             <a href="{smartblog::GetSmartBlogLink('smartblog_post',$options)}"><img alt="{$post.title}" class="feat_img_small" src="{$modules_dir}smartblog/images/{$post.post_img}-home-default.jpg"></a>
                        </div>

						<h4 class="product-title">
							<a href="{smartblog::GetSmartBlogLink('smartblog_post',$options)}">
								{$post.title}
							</a>
						</h4>

                        <p class="product-desc2">
                            {$post.short_description|escape:'htmlall':'UTF-8'}
                        </p>

						<div class="button-container">
							<a href="{smartblog::GetSmartBlogLink('smartblog_post',$options)}" class="button lnk_view btn">{l s='Read More' mod='smartbloghomelatestnews'}</a>
						</div>
				</div>		
			</div>
                
                {$i=$i+1}
            {/foreach}
        {/if}


</div>
</div>