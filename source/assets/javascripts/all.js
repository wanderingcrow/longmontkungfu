jQuery(document).ready(function($){

	// navigation

	var isLateralNavAnimating = false;

	// open/close lateral navigation
	$('.nav-trigger').on('click', function(event){
		event.preventDefault();
		//stop if nav animation is running
		if( !isLateralNavAnimating ) {
			if($(this).parents('.csstransitions').length > 0 ) isLateralNavAnimating = true;

			$('body').toggleClass('navigation-is-open');
			$('.main-nav').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(){
				// animation is over
				isLateralNavAnimating = false;
			});
		}
	});



	// slick sliders
  $('.slick-slider').slick({
    dots: true,
    infinite: false,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: true,
		arrows: false
	});



	// random home page hero
	var random;
	random = Math.floor(Math.random() * $('.hero-bkgrnd').length);
	$('.hero-bkgrnd').hide().eq(random).show();

});
