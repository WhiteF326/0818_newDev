/*
 * ClickSpark.js
 * https://github.com/ymc-thzi/clickspark.js
 *
 * Thomas Zinnbauer @ YMC
 *
 * 2015 YMC AG | Sonnenstrasse 4 | CH-8280 Kreuzlingen | Switzerland
 * http://www.ymc.ch
 *
 */

var clickSpark=function(){"use strict";var t=jQuery,e={particleImagePath:"",particleCount:35,particleSpeed:12,particleDuration:400,particleSize:12,particleRotationSpeed:0,animationType:"explosion",callback:null};t.fn.clickSpark=function(i){i=t.extend({},e,i),t(this).on("click",function(t){n.setParticleImagePath(i.particleImagePath),n.setParticleCount(i.particleCount),n.setParticleSpeed(i.particleSpeed),n.setParticleDuration(i.particleDuration),n.setParticleSize(i.particleSize),n.setParticleRotationSpeed(i.particleRotationSpeed),n.setAnimationType(i.animationType),n.setCallback(i.callback),n.stdFuncOCl(t)})};var n=function(){function n(){u()}function i(t){void 0!==t&&(y=t)}function o(t){void 0!==t&&(R=t)}function a(t){void 0!==t&&(P=t)}function c(t){void 0!==t&&(M=t)}function s(t){void 0!==t&&(x=t)}function d(t){void 0!==t&&(Y=t)}function r(t){void 0!==t&&(O=t)}function l(t){void 0!==t&&(G=t)}function u(){t(document).ready(function(){F=t("body"),U=t(document),L=t(window),E=t('<canvas id="cs-particle-canvas"></canvas>'),j=t('<div class="cs-canvas-container"></div>'),j.append(E),F.prepend(j),j.hide(),E.hide(),j.css({position:"absolute",zIndex:99999,width:"100%",height:"100%",top:window.pageYOffset,left:window.pageXOffset})})}function A(){var t={};return I&&(t.x=b,t.y=S,t.rotation=0),t.speed=m(0,P),t.angle=m(0,360)*(Math.PI/180),t.rotationSpeed=m(-1*Y,Y),t.size=x,t}function f(){I=E[0],N=new Image,N.src=y||W,I&&"function"==typeof I.getContext&&(C=I.getContext("2d"),C.canvas.width=document.body.clientWidth,C.canvas.height=document.body.clientHeight),p()}function p(){for(var t=0;R>t;t++)J.push(A())}function w(){C.clearRect(0,0,window.innerWidth,window.innerHeight);var t=T[O]||T[DEFAULT_ANIMATION];J.forEach(function(e){t(e),g(e)})}function g(t){t.size*=.96+m(1,10)/100,t.rotation+=t.rotationSpeed,C.save(),C.translate(t.x,t.y),C.rotate(t.rotation*Math.PI/180),N.width=D,N.height=D,C.drawImage(N,-(N.width/2),-(N.height/2),t.size,t.size),C.restore()}function h(){if(Z){var t=z;z=Date.now(),requestAnimationFrame(h,z-t),w()}}function m(t,e){return Math.random()*(e-t)+t}function v(t){function e(){E.hide(),j.hide(),F.css({overflow:"inherit"}),Z=!1,"function"==typeof G&&G.call(this)}z=Date.now(),"click"===t.type?(b=t.pageX-window.pageXOffset,S=t.pageY-window.pageYOffset):(b=t.offset().left+t.width()/2-window.pageXOffset,S=t.offset().top+t.height()/2-window.pageYOffset),J=[],f(),U.height()>L.height()?F.css("overflow-y","inherit"):F.css("overflow-y","hidden"),U.width()>L.width()?F.css("overflow-x","inherit"):F.css("overflow-x","hidden"),j.css({top:window.pageYOffset,left:window.pageXOffset}),E.css({top:0,left:0}),j.show(),E.show(),window.setTimeout(function(){E.fadeOut(e)},M),Z=!0,h()}var I,C,b,S,y=e.particleImagePath,R=e.particleCount,P=e.particleSpeed,M=e.particleDuration,Y=e.particleRotationSpeed,O=e.animationType,x=e.particleSize,G=e.callback,k=60,X=1e3/k,z=0,Z=!1,J=[],W="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAAXNSR0IArs4c6QAAAAlwSFlzAAALEwAACxMBAJqcGAAAAc5pVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx4bXA6Q3JlYXRvclRvb2w+QWRvYmUgRmlyZXdvcmtzIENTNTwveG1wOkNyZWF0b3JUb29sPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KaBqfRAAAATZJREFUOBGtlM2NwjAQhd+MAndaSAu5cuBAC9RAAyuxVICQtgFqoAUOHLi6BbfAnY3ineeNTXYvKA6WRv59X8bxzAj+teUhLCqgeSg2CGhsuzZbmN3NPARu3uHcAu62F67lJnlkg+VXaAKwC20GEEJLjeJoUsGb+Hj7EJc2M2x1COtWsOuAddp81StwqQKO171ceDbC6FHX4mRzXmtsc1phSw+F/yjMcLKrbcZS0nm78lm+sTUomv4fpb3RPfXkaHy13xcbDRkIanK0f/7BeuHQwsgeJIdBISXKGD41YcM4mgQk7E8UT6DdCfNvANIhr8y1Cd48pcZRJi2pz9WikSdHmf1M2iJEL6KeHGUZYfbbeul1XawexuEDgEk6D/i0Scz+/oMvO56nLpWhXIKofFs9S25MqbQ/ard2fSmw8JoAAAAASUVORK5CYII=",D=20;n();var F,U,L,j,E,N,T={explosion:function(t){t.x+=t.speed*Math.cos(t.angle),t.y+=t.speed*Math.sin(t.angle)},splash:function(t){t.x-=Math.tan(t.angle),t.y+=-2*t.speed},falloff:function(t){t.x-=Math.tan(t.angle),t.y-=-2*t.speed},blowright:function(t){t.x-=-2*t.speed,t.y-=Math.tan(t.angle/8)},blowleft:function(t){t.x+=-2*t.speed,t.y-=Math.tan(t.angle/8)}};return window.requestAnimationFrame=function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(t,e){var n=X;e>n&&(n-=e-n,0>n&&(n=0)),window.setTimeout(t,n)}}(),{setParticleImagePath:function(t){i(t)},setParticleCount:function(t){o(t)},setParticleSpeed:function(t){a(t)},setParticleDuration:function(t){c(t)},setParticleSize:function(t){s(t)},setParticleRotationSpeed:function(t){d(t)},setAnimationType:function(t){r(t)},setCallback:function(t){l(t)},init:function(){v(element)},fireParticles:function(t){v(t)},stdFuncOCl:function(t){v(t)}}}();return n}();