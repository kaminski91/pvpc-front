var ready = function() {
	// Disable blank link action
	$('a[href="#"]').on('click', function(event) {
		event.preventDefault();
	});

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

	// Events list tab
	$('.events-list .events-menu a').on('click', function(event) {
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
	$('.filter-toggle').on('click', function() {
		$(this).toggleClass('open');
		var filterHeight = $(this).next('.filter').children('form').height() + 10;
		if( $(this).hasClass('open') ) {
			$(this).next('.filter').css('height', filterHeight+'px');
		} else {
			$(this).next('.filter').css('height', '0px');
		}
	});

	// Search input
	$('.search-toggle a').on('click', function() {
		$(this).children('i').toggleClass('fa-search');
		$(this).children('i').toggleClass('fa-times');
		$('.search-input').toggleClass('open');
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

	// Tooltip
	$('.tooltip-btn').tooltip({
		placement: 'bottom',
		container: 'body'
	});

	// Profile edit new icon
	$('.icons .new').each(function() {
		var lh = $(this).width();
		$(this).find('i').css({'line-height': lh+"px"});
	});
}

var searchWidth = function() {
	return $('#main-menu .nav').width() - $('.search-toggle').width() - 5 - ( $('.search-input input').outerWidth(true) - $('.search-input input').width() );
}

var stickyNav = function() {
	if(window.pageYOffset >= 80) {
		$('#site-header').addClass('sticky');
	} else {
		$('#site-header').removeClass('sticky');
	}
}

$(document).ready(ready);
$(document).on('page:load', ready);

$(window).scroll(function() {
	stickyNav();
});

$(document).on('click', '.search-toggle a', function() {
		$('.search-input input').width( searchWidth() );
		//console.log(searchWidth());
});