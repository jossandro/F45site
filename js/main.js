;(function () {

	'use strict';



	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i);
		},
			BlackBerry: function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
			iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
			Opera: function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
			Windows: function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
			any: function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
		}
	};

	// Mobile Menu Clone ( Mobiles/Tablets )
	var mobileMenu = function() {
		if ( $(window).width() < 769 ) {
			$('html,body').addClass('fh5co-overflow');

			if ( $('#fh5co-mobile-menu').length < 1 ) {

				var clone = $('#fh5co-primary-menu').clone().attr({
					id: 'fh5co-mobile-menu-ul',
					class: ''
				});
				var cloneLogo = $('#fh5co-logo').clone().attr({
					id : 'fh5co-logo-mobile',
					class : ''
				});

				$('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
				$('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="ti-menu"></i></a>')
				$('<div id="fh5co-mobile-menu">').append(clone).insertBefore('#fh5co-header-section');

				$('#fh5co-header-section').hide();
				$('#fh5co-logo-mobile-wrap').show();
			} else {
				$('#fh5co-header-section').hide();
				$('#fh5co-logo-mobile-wrap').show();
			}

		} else {

			$('#fh5co-logo-mobile-wrap').hide();
			$('#fh5co-header-section').show();
			$('html,body').removeClass('fh5co-overflow');
			if ( $('body').hasClass('fh5co-mobile-menu-visible')) {
				$('body').removeClass('fh5co-mobile-menu-visible');
			}
		}
	};


	// Parallax
	// var scrollBanner = function () {
	//   var scrollPos = $(this).scrollTop();
	//   console.log(scrollPos);
	//   $('.fh5co-hero-intro').css({
	//     'opacity' : 1-(scrollPos/300)
	//   });
	// }


	// Click outside of the Mobile Menu
	var mobileMenuOutsideClick = function() {
		$(document).click(function (e) {
			var container = $("#fh5co-mobile-menu, #fh5co-mobile-menu-btn");
			if (!container.is(e.target) && container.has(e.target).length === 0) {
				$('body').removeClass('fh5co-mobile-menu-visible');
			}
		});
	};


	// Mobile Button Click
	var mobileBtnClick = function() {
		// $('#fh5co-mobile-menu-btn').on('click', function(e){
		$(document).on('click', '#fh5co-mobile-menu-btn', function(e){
			e.preventDefault();
			if ( $('body').hasClass('fh5co-mobile-menu-visible') ) {
				$('body').removeClass('fh5co-mobile-menu-visible');
			} else {
				$('body').addClass('fh5co-mobile-menu-visible');
			}

		});
	};


	// Main Menu Superfish
	var mainMenu = function() {

		$('#fh5co-primary-menu').superfish({
			delay: 0,
			animation: {
				opacity: 'show'
			},
			speed: 'fast',
			cssArrows: true,
			disableHI: true
		});

	};

	// Superfish Sub Menu Click ( Mobiles/Tablets )
	var mobileClickSubMenus = function() {

		$('body').on('click', '.fh5co-sub-ddown', function(event) {
			event.preventDefault();
			var $this = $(this),
				li = $this.closest('li');
			li.find('> .fh5co-sub-menu').slideToggle(200);
		});

	};

	var fullHeight = function() {

		// if ( !isMobile.any() ) {
			$('.js-fullheight').css('height', $(window).height());
			$(window).resize(function(){
				$('.js-fullheight').css('height', $(window).height());
			});
		// }

	};

	// Owl Carousel
	var owlCrouselFeatureSlide = function() {
		var owl = $('.owl-carousel1');
		owl.owlCarousel({
			items: 1,
			loop: true,
			margin: 0,
			responsiveClass: true,
			nav: true,
			dots: true,
			smartSpeed: 500,
			navText: [
				"<i class='icon-chevron-left owl-direction'></i>",
				"<i class='icon-chevron-right owl-direction'></i>"
			]
		});

		$('.owl-carousel2').owlCarousel({
			loop:true,
			margin:10,
			nav:true,
			dots: true,
			responsive:{
				0:{
					items:1
				},
				600:{
					items:3
				},
				1000:{
					items:3
				}
			},
			navText: [
				"<i class='icon-chevron-left owl-direction'></i>",
				"<i class='icon-chevron-right owl-direction'></i>"
			]
		})
	};


	// Animations

	var contentWayPoint = function() {
		var i = 0;
		$('.animate-box').waypoint( function( direction ) {

			if( direction === 'down' && !$(this.element).hasClass('animated') ) {

				i++;

				$(this.element).addClass('item-animate');
				setTimeout(function(){

					$('body .animate-box.item-animate').each(function(k){
						var el = $(this);
						setTimeout( function () {
							var effect = el.data('animate-effect');
							if ( effect === 'fadeIn') {
								el.addClass('fadeIn animated');
							} else {
								el.addClass('fadeInUp animated');
							}

							el.removeClass('item-animate');
						},  k * 200, 'easeInOutExpo' );
					});

				}, 100);

			}

		} , { offset: '85%' } );
	};

	var parallax = function() {
		$(window).stellar({
			horizontalScrolling: false,
			hideDistantElements: false,
			responsive: true

		});
	};

	var counter = function() {
		$('.js-counter').countTo({
			 formatter: function (value, options) {
	      return value.toFixed(options.decimals);
	    },
		});
	};


	var painelRefine = function () {
        $('.panel-title a').on('click', function () {
            $(this).children('span').toggleClass('icon-minus');
        });
    }

	// Document on load.
	$(function(){
		fullHeight();
		owlCrouselFeatureSlide();
		contentWayPoint();
		parallax();
		mobileMenu();
		mainMenu();
		mobileBtnClick();
		mobileClickSubMenus();
		mobileMenuOutsideClick();
		painelRefine();
	});


	$('.ckbcolor').on('click',function(){
		console.log(this.checked);
		if(this.checked){
			window.location.href = $(location).attr('href') + '&color=' + $(this).val();	
		}else{
			//remove value from url	
			var newurl = removeURLParameter($(location).attr('href'), 'color');
			
			$('input:checkbox.ckbcolor').each(function () {
				//var sThisVal = (this.checked ? $(this).val() : "");
				if(this.checked)
					newurl += '&color=' + $(this).val();
				console.log(newurl);
			});
			console.log(newurl);
			window.location.href = newurl;
			
		}

	});

	$('.ckbsize').on('click',function(){
		console.log($(this));
		if(this.checked){
			window.location.href = $(location).attr('href') + '&size=' + $(this).val();	
		}else{
			//remove value from url	
			var newurl = removeURLParameter($(location).attr('href'), 'size');
			
			$('input:checkbox.ckbsize').each(function () {
				//var sThisVal = (this.checked ? $(this).val() : "");
				if(this.checked)
					newurl += '&size=' + $(this).val();
				console.log(newurl);
			});
			console.log(newurl);
			window.location.href = newurl;
			
		}

	});

	function removeURLParameter(url, parameter) {
	    //prefer to use l.search if you have a location/link object
	    var urlparts= url.split('?');   
	    if (urlparts.length>=2) {

	        var prefix= encodeURIComponent(parameter)+'=';
	        var pars= urlparts[1].split(/[&;]/g);

	        //reverse iteration as may be destructive
	        for (var i= pars.length; i-- > 0;) {    
	            //idiom for string.startsWith
	            if (pars[i].lastIndexOf(prefix, 0) !== -1) {  
	                pars.splice(i, 1);
	            }
	        }

	        url= urlparts[0] + (pars.length > 0 ? '?' + pars.join('&') : "");
	        return url;
	    } else {
	        return url;
	    }
	}

}());