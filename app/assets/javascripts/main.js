var ready = function() {
	// Disable blank link action
	$('a[href="#"]').click(function(event) {
		event.preventDefault();
	});
	
	//Rotator
	$("#rotator.work").owlCarousel({
      navigation : true,
      navigationText: [
	      "<span class='glyphicon glyphicon-chevron-left icon-white'></span>",
	      "<span class='glyphicon glyphicon-chevron-right icon-white'></span>"
      ],
      slideSpeed : 300,
      paginationSpeed : 400,
      singleItem:true
  	});

  	// StickyNav onReady
  	stickyNav();

  	// Modal vertical center
  	$('#myModal').on('shown.bs.modal', function (e) {
  		var dialog = $(this).find('.modal-dialog');
  		var dialogHeight = dialog.height();
  		var dialogMarginTop = (dialog.outerHeight(true) - dialogHeight)/2;
  		var dialogTranslate = ( $(window).height() - dialogHeight )/2 - dialogMarginTop;
  		if( dialogTranslate > 0 ) {
	  		dialog.css({
	  			'transform': 'translateY('+ dialogTranslate +'px)',
				'-ms-transform': 'translateY('+ dialogTranslate +'px)',
				'-webkit-transform': 'translateY('+ dialogTranslate +'px)'
	  		});
	  	}
	});

  	// Tooltip
  	$('.tooltip-btn').tooltip({
  		placement: 'bottom',
  		container: 'body'
  	});

  	// Events list tab
  	$('.events-list .events-menu a').click(function(event) {
		event.preventDefault();

		var node = $(this)

		// Check if mobile version
		var mobile = $('.events-list .controller').is(':visible');

		// Mobile click only on controller icon
		if( mobile && $(this).hasClass('controller') ) {
			var controlers = $('.events-list .events-menu a').not('.controller');
			controlers.not('.active').addClass('active').siblings().removeClass('active');
			$(this).toggleClass('fa-flip-horizontal');
		}  else if( !$(this).hasClass('active') ) {
			$(this).siblings().not('.controller').removeClass('active');
			$(this).addClass('active');
			$('.events-list .controller').toggleClass('fa-flip-horizontal');
		}

		$('.tab').fadeOut('fast', function() {
			$( node.attr('data-for') ).fadeIn('fast');
		});
	});

	// Filter toggle
	$('.filter-toggle').click(function() {
		$(this).toggleClass('open');
		var filterHeight = $(this).next('.filter').children('form').height() + 10;
		if( $(this).hasClass('open') ) {
			$(this).next('.filter').css('height', filterHeight+'px');
		} else {
			$(this).next('.filter').css('height', '0px');
		}
	});

	// Profile edit new icon
	$('.icons .new').each(function() {
		var lh = $(this).width();
		$(this).find('i').css({'line-height': lh+"px"});
	});

	// Search input
	$('.search-input input').width( searchWidth() );
	$('.search-toggle a').click(function() {
		$(this).children('i').toggleClass('fa-search');
		$(this).children('i').toggleClass('fa-times');
		$('.search-input').toggleClass('open');

	});
}

var searchWidth = function() {
	return $('#main-menu .nav').width() - $('.search-toggle').width() - 5;
}

var stickyNav = function() {
	if(window.pageYOffset >= 80) {
		$('#site-header').addClass('sticky');
	} else {
		$('#site-header').removeClass('sticky');
	}
}

$(document).ready( ready );
$(window).scroll(function() {
	stickyNav();
})