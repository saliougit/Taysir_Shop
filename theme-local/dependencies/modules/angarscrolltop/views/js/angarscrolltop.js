/*
* @author      Krzysztof Pecak
* @copyright   2021 Krzysztof Pecak
* @license     http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*/

$(document).ready(function(){
    $(window).scroll(function(){
        if($(this).scrollTop() > 100){
            $('#scroll_top').fadeIn();
        }else{
            $('#scroll_top').fadeOut();
        }
    });
    $('#scroll_top').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });
});