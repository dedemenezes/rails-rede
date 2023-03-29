[1mdiff --git a/app/javascript/controllers/index.js b/app/javascript/controllers/index.js[m
[1mindex e36ce80..c79a54f 100644[m
[1m--- a/app/javascript/controllers/index.js[m
[1m+++ b/app/javascript/controllers/index.js[m
[36m@@ -13,9 +13,6 @@[m [mapplication.register("address-autocomplete", AddressAutocompleteController)[m
 import ArticleHighlightController from "./article_highlight_controller"[m
 application.register("article-highlight", ArticleHighlightController)[m
 [m
[31m-import CharacterCounter from 'stimulus-character-counter'[m
[31m-application.register('character-counter', CharacterCounter)[m
[31m-[m
 import CheckboxListController from "./checkbox_list_controller"[m
 application.register("checkbox-list", CheckboxListController)[m
 [m
[36m@@ -52,8 +49,8 @@[m [mapplication.register("photo-preview", PhotoPreviewController)[m
 import PhotoswipeController from "./photoswipe_controller"[m
 application.register("photoswipe", PhotoswipeController)[m
 [m
[31m-import ScrollReveal from 'stimulus-scroll-reveal'[m
[31m-application.register('scroll-reveal', ScrollReveal)[m
[32m+[m[32mimport RevealOnClickController from "./reveal_on_click_controller"[m
[32m+[m[32mapplication.register("reveal-on-click", RevealOnClickController)[m
 [m
 import SlideNFadeLController from "./slide_n_fade_l_controller"[m
 application.register("slide-n-fade-l", SlideNFadeLController)[m
[36m@@ -75,3 +72,9 @@[m [mapplication.register("tom-select-create-option", TomSelectCreateOptionController[m
 [m
 import TooltipController from "./tooltip_controller"[m
 application.register("tooltip", TooltipController)[m
[32m+[m
[32m+[m[32mimport CharacterCounter from 'stimulus-character-counter'[m
[32m+[m[32mapplication.register('character-counter', CharacterCounter)[m
[32m+[m
[32m+[m[32mimport ScrollReveal from 'stimulus-scroll-reveal'[m
[32m+[m[32mapplication.register('scroll-reveal', ScrollReveal)[m
[1mdiff --git a/package.json b/package.json[m
[1mindex e9162e7..3ab376a 100644[m
[1m--- a/package.json[m
[1m+++ b/package.json[m
[36m@@ -12,7 +12,7 @@[m
     "mapbox-gl": "^2.13.0",[m
     "photoswipe": "^5.3.6",[m
     "stimulus-character-counter": "^4.2.0",[m
[31m-    "stimulus-scroll-reveal": "^3.1.0",[m
[32m+[m[32m    "stimulus-scroll-reveal": "^3.2.0",[m
     "swiper": "^9.0.3",[m
     "tom-select": "^2.2.2",[m
     "trix": "^2.0.4",[m
[1mdiff --git a/yarn.lock b/yarn.lock[m
[1mindex 5cd894e..fe6a850 100644[m
[1m--- a/yarn.lock[m
[1m+++ b/yarn.lock[m
[36m@@ -1458,10 +1458,10 @@[m [mstimulus-character-counter@^4.2.0:[m
   resolved "https://registry.yarnpkg.com/stimulus-character-counter/-/stimulus-character-counter-4.2.0.tgz#6e7782c2c525ccc661ffbb39a7b15085a3a42a21"[m
   integrity sha512-5ZN5wFlOnIkZRSiwtC7zb880yvE4O/4+KOhdg0z6zQet4iLA2+W0NJvHX5teW6tl5M1IGzHrgOtuEsUVfQ2TrA==[m
 [m
[31m-stimulus-scroll-reveal@^3.1.0:[m
[31m-  version "3.1.0"[m
[31m-  resolved "https://registry.yarnpkg.com/stimulus-scroll-reveal/-/stimulus-scroll-reveal-3.1.0.tgz#ffb087f802d8f8d23cb174ecf5f869e98172888b"[m
[31m-  integrity sha512-3xfiNgwgAM70F6Phy14CCVto3O2gIXiOd4arvqHD+sPv5EdRJ1rav+So2T+IZz89IT3AagF3I7ZY7DgeHm/iNg==[m
[32m+[m[32mstimulus-scroll-reveal@^3.2.0:[m
[32m+[m[32m  version "3.2.0"[m
[32m+[m[32m  resolved "https://registry.yarnpkg.com/stimulus-scroll-reveal/-/stimulus-scroll-reveal-3.2.0.tgz#e9bdf2c0ddce82c24df99ba627f2f3375bc64f41"[m
[32m+[m[32m  integrity sha512-KxXHibsGVqvBJ4TqUaTwss36WX543dlUWoNbDXvkAfuddE6H/D7egkVF9v85LEtCVd2h9KkrTNykBnPqyxpAoQ==[m
 [m
 strip-indent@^3.0.0:[m
   version "3.0.0"[m
