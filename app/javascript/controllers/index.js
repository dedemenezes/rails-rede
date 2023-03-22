// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CharacterCounter from 'stimulus-character-counter'
application.register('character-counter', CharacterCounter)

import ActiveOnHeightController from "./active_on_height_controller"
application.register("active-on-height", ActiveOnHeightController)

import AddressAutocompleteController from "./address_autocomplete_controller"
application.register("address-autocomplete", AddressAutocompleteController)

import ArticleHighlightController from "./article_highlight_controller"
application.register("article-highlight", ArticleHighlightController)

import DisplayButtonOnHoverController from "./display_button_on_hover_controller"
application.register("display-button-on-hover", DisplayButtonOnHoverController)

import DisplayPhotoInputController from "./display_photo_input_controller"
application.register("display-photo-input", DisplayPhotoInputController)

import EventsScrollController from "./events_scroll_controller"
application.register("events-scroll", EventsScrollController)

import FilterCalendarController from "./filter_calendar_controller"
application.register("filter-calendar", FilterCalendarController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)

import NavbarTogglerController from "./navbar_toggler_controller"
application.register("navbar-toggler", NavbarTogglerController)

import OverlayMenuController from "./overlay_menu_controller"
application.register("overlay-menu", OverlayMenuController)

import PhotoPreviewController from "./photo_preview_controller"
application.register("photo-preview", PhotoPreviewController)

import SlideNFadeLController from "./slide_n_fade_l_controller"
application.register("slide-n-fade-l", SlideNFadeLController)

import SlideNFadeRController from "./slide_n_fade_r_controller"
application.register("slide-n-fade-r", SlideNFadeRController)

import SwiperController from "./swiper_controller"
application.register("swiper", SwiperController)

import TomSelectController from "./tom_select_controller"
application.register("tom-select", TomSelectController)

import TomSelectCreateOptionController from "./tom_select_create_option_controller"
application.register("tom-select-create-option", TomSelectCreateOptionController)

import TooltipController from "./tooltip_controller"
application.register("tooltip", TooltipController)
