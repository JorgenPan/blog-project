<!DOCTYPE html>
<html style="display: none;" lang="zh">
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="blog" value="${pageContext.request.contextPath}" />
    <head>
    <meta charset="utf-8">

    <script>
        window.materialVersion = "1.5.6"
        // Delete localstorage with these tags
        window.oldVersion = [
            'codestartv1',
            '1.3.4',
            '1.4.0',
            '1.4.0b1',
            '1.5.0',
            '1.5.2',
            '1.5.5'
        ]
    </script>

    <!-- dns prefetch -->
    <meta http-equiv="x-dns-prefetch-control" content="on">

    <link rel="dns-prefetch" href="https://fonts.googleapis.com"/>
    
    <!-- Meta & Info -->
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <!-- Title -->
    <title>JorgenPan-Blog</title>

    <!-- Favicons -->
    <link rel="icon shortcut" type="image/ico" href="/img/favicon.png">
    <link rel="icon" href="/img/favicon.png">

    <meta name="format-detection" content="telephone=no"/>
    <meta name="description" itemprop="description" content="">
    <meta name="keywords" content="">
    <meta name="theme-color" content="#0097A7">

    <!-- Disable Fucking Bloody Baidu Tranformation -->
    <meta http-equiv="Cache-Control" content="no-transform" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <!-- Import lsloader -->
    <script>
(function() {
    window.lsloader = {
      jsRunSequence: [],
      jsnamemap: {},
      cssnamemap: {}
    };
    lsloader.removeLS = function(a) {
      try {
        localStorage.removeItem(a)
      } catch(b) {}
    };
    lsloader.setLS = function(a, c) {
      try {
        localStorage.setItem(a, c)
      } catch(b) {}
    };
    lsloader.getLS = function(a) {
      var c = "";
      try {
        c = localStorage.getItem(a)
      } catch(b) {
        c = ""
      }
      return c
    };
    versionString = "/*" + (window.materialVersion || "unknownVersion") + "*/";
    lsloader.clean = function() {
      try {
        var b = [];
        for (var a = 0; a < localStorage.length; a++) {
          b.push(localStorage.key(a))
        }
        b.forEach(function(e) {
          var f = lsloader.getLS(e);
          if (window.oldVersion) {
            var d = window.oldVersion.reduce(function(g, h) {
              return g || f.indexOf("/*" + h + "*/") !== -1
            },
            false);
            if (d) {
              lsloader.removeLS(e)
            }
          }
        })
      } catch(c) {}
    };
    lsloader.clean();
    lsloader.load = function(f, a, b, d) {
      if (typeof b === "boolean") {
        d = b;
        b = undefined
      }
      d = d || false;
      b = b ||
      function() {};
      var e;
      e = this.getLS(f);
      if (e && e.indexOf(versionString) === -1) {
        this.removeLS(f);
        this.requestResource(f, a, b, d);
        return
      }
      if (e) {
        var c = e.split(versionString)[0];
        if (c != a) {
          console.log("reload:" + a);
          this.removeLS(f);
          this.requestResource(f, a, b, d);
          return
        }
        e = e.split(versionString)[1];
        if (d) {
          this.jsRunSequence.push({
            name: f,
            code: e
          });
          this.runjs(a, f, e)
        } else {
          document.getElementById(f).appendChild(document.createTextNode(e));
          b()
        }
      } else {
        this.requestResource(f, a, b, d)
      }
    };
    lsloader.requestResource = function(b, e, a, c) {
      var d = this;
      if(e.indexOf("${blog}/static/") == -1){
    	  e = "${blog}/static/"+e;
      }
      if (c) {
        this.iojs( e, b,
        function(h, f, g) {
          d.setLS(f, h + versionString + g);
          d.runjs(h, f, g)
        })
      } else {
        this.iocss(e, b,
        function(f) {
          document.getElementById(b).appendChild(document.createTextNode(f));
          d.setLS(b, e + versionString + f)
        },
        a)
      }
    };
    lsloader.iojs = function(d, b, g) {
      var a = this;
      a.jsRunSequence.push({
        name: b,
        code: ""
      });
      try {
        var f = new XMLHttpRequest();
        f.open("get", d, true);
        f.onreadystatechange = function() {
          if (f.readyState == 4) {
            if ((f.status >= 200 && f.status < 300) || f.status == 304) {
              if (f.response != "") {
                g(d, b, f.response);
                return
              }
            }
            a.jsfallback(d, b)
          }
        };
        f.send(null)
      } catch(c) {
        a.jsfallback(d, b)
      }
    };
    lsloader.iocss = function(f, c, h, a) {
      var b = this;
      try {
        var g = new XMLHttpRequest();
        g.open("get", f, true);
        g.onreadystatechange = function() {
          if (g.readyState == 4) {
            if ((g.status >= 200 && g.status < 300) || g.status == 304) {
              if (g.response != "") {
                h(g.response);
                a();
                return
              }
            }
            b.cssfallback(f, c, a)
          }
        };
        g.send(null)
      } catch(d) {
        b.cssfallback(f, c, a)
      }
    };
    lsloader.iofonts = function(f, c, h, a) {
      var b = this;
      try {
        var g = new XMLHttpRequest();
        g.open("get", f, true);
        g.onreadystatechange = function() {
          if (g.readyState == 4) {
            if ((g.status >= 200 && g.status < 300) || g.status == 304) {
              if (g.response != "") {
                h(g.response);
                a();
                return
              }
            }
            b.cssfallback(f, c, a)
          }
        };
        g.send(null)
      } catch(d) {
        b.cssfallback(f, c, a)
      }
    };
    lsloader.runjs = function(f, c, e) {
      if ( !! c && !!e) {
        for (var b in this.jsRunSequence) {
          if (this.jsRunSequence[b].name == c) {
            this.jsRunSequence[b].code = e
          }
        }
      }
      if ( !! this.jsRunSequence[0] && !!this.jsRunSequence[0].code && this.jsRunSequence[0].status != "failed") {
        var a = document.createElement("script");
        a.appendChild(document.createTextNode(this.jsRunSequence[0].code));
        a.type = "text/javascript";
        document.getElementsByTagName("head")[0].appendChild(a);
        this.jsRunSequence.shift();
        if (this.jsRunSequence.length > 0) {
          this.runjs()
        }
      } else {
        if ( !! this.jsRunSequence[0] && this.jsRunSequence[0].status == "failed") {
          var d = this;
          var a = document.createElement("script");
          a.src = this.jsRunSequence[0].path;
          a.type = "text/javascript";
          this.jsRunSequence[0].status = "loading";
          a.onload = function() {
            d.jsRunSequence.shift();
            if (d.jsRunSequence.length > 0) {
              d.runjs()
            }
          };
          document.body.appendChild(a)
        }
      }
    };
    lsloader.tagLoad = function(b, a) {
      this.jsRunSequence.push({
        name: a,
        code: "",
        path: b,
        status: "failed"
      });
      this.runjs()
    };
    lsloader.jsfallback = function(c, b) {
      if ( !! this.jsnamemap[b]) {
        return
      } else {
        this.jsnamemap[b] = b
      }
      for (var a in this.jsRunSequence) {
        if (this.jsRunSequence[a].name == b) {
          this.jsRunSequence[a].code = "";
          this.jsRunSequence[a].status = "failed";
          this.jsRunSequence[a].path = c
        }
      }
      this.runjs()
    };
    lsloader.cssfallback = function(e, c, b) {
      if ( !! this.cssnamemap[c]) {
        return
      } else {
        this.cssnamemap[c] = 1
      }
      var d = document.createElement("link");
      d.type = "text/css";
      d.href = e;
      d.rel = "stylesheet";
      d.onload = d.onerror = b;
      var a = document.getElementsByTagName("script")[0];
      a.parentNode.insertBefore(d, a)
    };
    lsloader.runInlineScript = function(c, b) {
      var a = document.getElementById(b).innerText;
      this.jsRunSequence.push({
        name: c,
        code: a
      });
      this.runjs()
    }
  })();

  </script>
  
    <!-- Import queue -->
    <script>function Queue(){this.dataStore=[];this.offer=b;this.poll=d;this.execNext=a;this.debug=false;this.startDebug=c;function b(e){if(this.debug){console.log("Offered a Queued Function.")}if(typeof e==="function"){this.dataStore.push(e)}else{console.log("You must offer a function.")}}function d(){if(this.debug){console.log("Polled a Queued Function.")}return this.dataStore.shift()}function a(){var e=this.poll();if(e!==undefined){if(this.debug){console.log("Run a Queued Function.")}e()}}function c(){this.debug=true}}var queue=new Queue();</script>

    <!-- Import CSS -->
    <style id="material_css"></style><script>if(typeof window.lsLoadCSSMaxNums === "undefined")window.lsLoadCSSMaxNums = 0;window.lsLoadCSSMaxNums++;lsloader.load("material_css","/css/material.min.css?Z7a72R1E4SxzBKR/WGctOA==",function(){if(typeof window.lsLoadCSSNums === "undefined")window.lsLoadCSSNums = 0;window.lsLoadCSSNums++;if(window.lsLoadCSSNums == window.lsLoadCSSMaxNums)document.documentElement.style.display="";}, false)</script>
    <style id="style_css"></style><script>if(typeof window.lsLoadCSSMaxNums === "undefined")window.lsLoadCSSMaxNums = 0;window.lsLoadCSSMaxNums++;lsloader.load("style_css","/css/style.min.css?uVzgA6RLrOm13Ukw8Qgy+A==",function(){if(typeof window.lsLoadCSSNums === "undefined")window.lsLoadCSSNums = 0;window.lsLoadCSSNums++;if(window.lsLoadCSSNums == window.lsLoadCSSMaxNums)document.documentElement.style.display="";}, false)</script>
    
    <!-- Config CSS -->

<!-- Other Styles -->
<style>
  body, html {
    font-family: Roboto, "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "å¾®è½¯éé»", Arial, sans-serif;
    overflow-x: hidden !important;
  }
  
  code {
    font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
  }

  a {
    color: #00838F;
  }

  .mdl-card__media,
  #search-label,
  #search-form-label:after,
  #scheme-Paradox .hot_tags-count,
  #scheme-Paradox .sidebar_archives-count,
  #scheme-Paradox .sidebar-colored .sidebar-header,
  #scheme-Paradox .sidebar-colored .sidebar-badge{
    background-color: #0097A7 !important;
  }

  /* Sidebar User Drop Down Menu Text Color */
  #scheme-Paradox .sidebar-colored .sidebar-nav>.dropdown>.dropdown-menu>li>a:hover,
  #scheme-Paradox .sidebar-colored .sidebar-nav>.dropdown>.dropdown-menu>li>a:focus {
    color: #0097A7 !important;
  }

  #post_entry-right-info,
  .sidebar-colored .sidebar-nav li:hover > a,
  .sidebar-colored .sidebar-nav li:hover > a i,
  .sidebar-colored .sidebar-nav li > a:hover,
  .sidebar-colored .sidebar-nav li > a:hover i,
  .sidebar-colored .sidebar-nav li > a:focus i,
  .sidebar-colored .sidebar-nav > .open > a,
  .sidebar-colored .sidebar-nav > .open > a:hover,
  .sidebar-colored .sidebar-nav > .open > a:focus,
  #ds-reset #ds-ctx .ds-ctx-entry .ds-ctx-head a {
    color: #0097A7 !important;
  }

  .toTop {
    background: #757575 !important;
  }

  .material-layout .material-post>.material-nav,
  .material-layout .material-index>.material-nav,
  .material-nav a {
    color: #757575;
  }

  #scheme-Paradox .MD-burger-layer {
    background-color: #757575;
  }

  #scheme-Paradox #post-toc-trigger-btn {
    color: #757575;
  }

  .post-toc a:hover {
    color: #00838F;
    text-decoration: underline;
  }

</style>


<!-- Theme Background Related-->

    <style>
      body{
        background-color: #F5F5F5;
      }

      /* blog_info bottom background */
      #scheme-Paradox .material-layout .something-else .mdl-card__supporting-text{
        background-color: #fff;
      }
    </style>




<!-- Fade Effect -->

    <style>
      .fade {
        transition: all 800ms linear;
        -webkit-transform: translate3d(0,0,0);
        -moz-transform: translate3d(0,0,0);
        -ms-transform: translate3d(0,0,0);
        -o-transform: translate3d(0,0,0);
        transform: translate3d(0,0,0);
        opacity: 1;
      }

      .fade.out{
        opacity: 0;
      }
    </style>


<!-- Import Font -->
<!-- Import Roboto -->

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">


<!-- Import Material Icons -->


    <style id="material_icons"></style><script>if(typeof window.lsLoadCSSMaxNums === "undefined")window.lsLoadCSSMaxNums = 0;window.lsLoadCSSMaxNums++;lsloader.load("material_icons","/css/material-icons.css?pqhB/Rd/ab0H2+kZp0RDmw==",function(){if(typeof window.lsLoadCSSNums === "undefined")window.lsLoadCSSNums = 0;window.lsLoadCSSNums++;if(window.lsLoadCSSNums == window.lsLoadCSSMaxNums)document.documentElement.style.display="";}, false)</script>




    <!-- Import jQuery -->
    
        <script>lsloader.load("jq_js","/js/jquery.min.js?ezyEvm8ST5CGfpA+kFFi1g==", true)</script>
    

    <!-- WebAPP Icons -->
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="application-name" content="Hexo">
    <meta name="msapplication-starturl" content="http://yoursite.com/">
    <meta name="msapplication-navbutton-color" content="#0097A7">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="Hexo">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="apple-touch-icon" href="/img/favicon.png">

    <!-- Site Verification -->
    
    

    <!-- RSS -->
    

    <!-- The Open Graph protocol -->
    <meta property="og:url" content="http://yoursite.com/">
    <meta property="og:type" content="blog">
    <meta property="og:title" content="Hexo">
    <meta property="og:image" content="/img/favicon.png">
    <meta property="og:description" content="">
    

    

    <!-- The Twitter Card protocol -->
    <meta name="twitter:card" content="summary_large_image">

    <!-- Add canonical link for SEO -->
    
        <link rel="canonical" href="http://yoursite.com" />
    

    <!-- Structured-data for SEO -->
    
        
<script type="application/ld+json">
{
    "@context": "http://schema.org",
    "@type": "Website",
    "publisher": {
        "@type": "Organization",
        "name": "Hexo",
        "logo": "/img/favicon.png"
    },
    "url": "http://yoursite.com",
    "image": {
        "@type": "ImageObject",
        "url": "/img/favicon.png"
    },
    "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "http://yoursite.com"
    },
    "description": ""
}
</script>




    

    <!-- Analytics -->
    
    
    

    <!-- Custom Head -->
    

</head>


    
        <body id="scheme-Paradox" class="lazy">
            <div class="material-layout  mdl-js-layout has-drawer is-upgraded">
                

                <!-- Main Container -->
                <main class="material-layout__content" id="main">

                    <!-- Top Anchor -->
                    <div id="top"></div>

                    
                        <!-- Hamburger Button -->
                        <button class="MD-burger-icon sidebar-toggle">
                            <span id="MD-burger-id" class="MD-burger-layer"></span>
                        </button>
                    

                    <!-- Index Module -->
<div class="material-index mdl-grid">
    
        <!-- Paradox Header -->
        <!-- Daily pic -->
<div class="mdl-card mdl-shadow--2dp daily-pic mdl-cell mdl-cell--8-col index-top-block">

    <!-- Pic & Slogan -->
    <div class="mdl-card__media mdl-color-text--grey-50" style="background-image:url(${blog}/static/img/daily_pic.png)">
        <p class="index-top-block-slogan"><a href="#">
                Hi, nice to meet you
        </a></p>
    </div>

    <!-- Avatar & Name -->
    <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
        <!-- Author Avatar -->
        <div id="author-avatar">
            <img src="${blog}/static/img/avatar.png" width="32px" height="32px" alt="avatar">
        </div>
        <div>
            <strong>JorgenPan</strong>
        </div>
    </div>
</div>

        <!-- Blog info -->
<div class="mdl-card mdl-shadow--2dp something-else mdl-cell mdl-cell--8-col mdl-cell--4-col-desktop index-top-block">

    <!-- Search -->
    
    <!-- Google -->
    <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable" method="post" action="">
        <label id="search-label" class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--fab mdl-color--accent mdl-shadow--4dp" for="search">
            <i class="material-icons mdl-color-text--white" role="presentation">search</i>
        </label>

        <form autocomplete="off" id="search-form" method="get" action="//google.com/search" accept-charset="UTF-8" class="mdl-textfield__expandable-holder" target="_blank">
            <input class="mdl-textfield__input search-input" type="search" name="q" id="search" placeholder="">
            <label id="search-form-label" class="mdl-textfield__label" for="search"></label>

            <input type="hidden" name="sitesearch" value="http://yoursite.com">
        </form>
    </div>







    <!-- LOGO -->
    <div class="something-else-logo mdl-color--white mdl-color-text--grey-600">
        <a href="#" target="_blank">
            <img src="${blog}/static/img/logo.png" alt="logo" />
        </a>
    </div>

    <!-- Infomation -->
    <div class="mdl-card__supporting-text meta meta--fill mdl-color-text--grey-600">
        <!-- Blog Title -->
        <div>
            <strong>Hexo</strong>
        </div>
        <div class="section-spacer"></div>

        <!-- Pages -->
        <button id="show-pages-button" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
            <i class="material-icons" role="presentation">view_carousel</i>
            <span class="visuallyhidden">Pages</span>
        </button>
        <ul class="mdl-menu mdl-js-menu mdl-menu--bottom-right" for="show-pages-button">
            
        </ul>

        <!-- Menu -->
        <button id="menubtn" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
            <i class="material-icons" role="presentation">more_vert</i>
            <span class="visuallyhidden">show menu</span>
        </button>
        <ul class="mdl-menu mdl-js-menu mdl-menu--bottom-right" for="menubtn">
            

            

            
                <a class="index_share-link" href="http://service.weibo.com/share/share.php?appkey=&title=Hexo&url=http://yoursite.com&pic=http://yoursite.com/img/favicon.png&searchPic=false&style=simple" target="_blank">
                    <li class="mdl-menu__item mdl-js-ripple-effect">
                        åäº«å°å¾®å
                    </li>
                </a>
            

            
                <a class="index_share-link" href="https://twitter.com/intent/tweet?text=Hexo&url=http://yoursite.com&via=John Doe" target="_blank">
                    <li class="mdl-menu__item mdl-js-ripple-effect">
                        åäº«å° Twitter
                    </li>
                </a>
            

            
                <a class="index_share-link" href="https://www.facebook.com/sharer/sharer.php?u=http://yoursite.com" target="_blank">
                    <li class="mdl-menu__item mdl-js-ripple-effect">
                        åäº«å° Facebook
                    </li>
                </a>
            

            
                <a class="index_share-link" href="https://plus.google.com/share?url=http://yoursite.com" target="_blank">
                    <li class="mdl-menu__item mdl-js-ripple-effect">
                        åäº«å° Google+
                    </li>
                </a>
            

            

            

            
        </ul>
    </div>
</div>

    
    <div class="locate-thumbnail-symbol"></div>

    <!-- Pin on top -->
    

    <!-- Normal Post -->
    
        
            
                <!-- Paradox Thumbnail -->
                <div class="post_entry-module mdl-card mdl-shadow--2dp mdl-cell mdl-cell--12-col fade out">
    <!-- Post Thumbnail -->
    
        
            <!-- Random Thumbnail -->
            <div class="post_thumbnail-random mdl-card__media mdl-color-text--grey-50">
        
    

        <!-- Post Title -->
        <p class="article-headline-p"><a href="/2018/09/25/hello-world/">Hello World</a></p>
    </div>

    <!-- Post Excerpt -->
    <div class="mdl-color-text--grey-600 mdl-card__supporting-text post_entry-content">
            Welcome to Hexo&nbsp;&nbsp;&nbsp;
        <span>
            <a href="/2018/09/25/hello-world/" target="_self">阅读全文</a>
        </span>
    </div>
    <!-- Post_entry Info-->
    <div id="post_entry-info">
        <div id="post_entry-left-info" class="mdl-card__supporting-text meta mdl-color-text--grey-600 ">
            <!-- Author Avatar -->
            <div id="author-avatar">
                <img src="${blog}/static/img/avatar.png" width="44px" height="44px" alt="John Doe's avatar">
            </div>
            <div>
                <strong>JorgenPan</strong>
                <span>9日 25, 2018</span>
            </div>
        </div>
        <div id="post_entry-right-info">
          

            

            

            <!-- Post Views -->
            <span class="post_entry-views">
            </span>
        </div>
    </div>
</div>

            
            
        
    

    

    
        <script type="text/ls-javascript" id="thumbnail-script">
    var randomNum;

    var locatePost = $('.locate-thumbnail-symbol').next();
    for(var i = 0; i < 10; i++) {
        randomNum = Math.floor(Math.random() * 19 + 1);

        locatePost.children('.post_thumbnail-random').attr('id', 'random_thumbnail-'+randomNum);
        locatePost.children('.post_thumbnail-random').attr('data-original', '${blog}/static/img/random/material-' + randomNum + '.png');
    $('.post_thumbnail-random').addClass('lazy');

        locatePost = locatePost.next();
    }
</script>

    
</div>


                    
<!-- Overlay For Active Sidebar -->
<div class="sidebar-overlay"></div>

<!-- Material sidebar -->
<aside id="sidebar" class="sidebar sidebar-colored sidebar-fixed-left" role="navigation">
    <div id="sidebar-main">
        <!-- Sidebar Header -->
        <div class="sidebar-header header-cover" style="background-image: url(${blog}/static/img/sidebar_header.png);">
    <!-- Top bar -->
    <div class="top-bar"></div>

    <!-- Sidebar toggle button -->
    <button type="button" class="sidebar-toggle mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" style="display: initial;" data-upgraded=",MaterialButton,MaterialRipple">
        <i class="material-icons">clear_all</i>
        <span class="mdl-button__ripple-container">
            <span class="mdl-ripple">
            </span>
        </span>
    </button>

    <!-- Sidebar Avatar -->
    <div class="sidebar-image">
        <img src="${blog}/static/img/avatar.png" alt="John Doe's avatar">
    </div>

    <!-- Sidebar Email -->
    <a data-toggle="dropdown" class="sidebar-brand" href="#settings-dropdown">
        905095514@qq.com
        <b class="caret"></b>
    </a>
</div>


        <!-- Sidebar Navigation  -->
        <ul class="nav sidebar-nav">
    <!-- User dropdown  -->
    <li class="dropdown">
        <ul id="settings-dropdown" class="dropdown-menu">
                <li>
                    <a href="#" target="_blank" title="Email Me">
                            <i class="material-icons sidebar-material-icons sidebar-indent-left1pc-element">email</i>
                        		写邮件给我
                    </a>
                </li>
            
        </ul>
    </li>

    <!-- Homepage -->
    
        <li id="sidebar-first-li">
            <a href="/">
                    <i class="material-icons sidebar-material-icons">home</i>
                	主页
            </a>
        </li>
        
    

    <!-- Archives  -->
    
        <li class="dropdown">
            <a href="#" class="ripple-effect dropdown-toggle" data-toggle="dropdown">
                
                    <i class="material-icons sidebar-material-icons">inbox</i>
                    	归档
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
            <li>
                <a class="sidebar_archives-link" href="/archives/2018/09/">九月 2018<span class="sidebar_archives-count">1</span></a>
            </ul>
        </li>
</ul>


        <!-- Sidebar Footer -->
        <!--
I'm glad you use this theme, the development is no so easy, I hope you can keep the copyright, I will thank you so much.
If you still want to delete the copyrights, could you still retain the first one? Which namely "Theme Material"
It will not impact the appearance and can give developers a lot of support :)
-->

<!-- Sidebar Divider -->

    <div class="sidebar-divider"></div>


<!-- Theme Material -->

    <a href="https://github.com/viosey/hexo-theme-material"  class="sidebar-footer-text-a" target="_blank">
        <div class="sidebar-text mdl-button mdl-js-button mdl-js-ripple-effect sidebar-footer-text-div" data-upgraded=",MaterialButton,MaterialRipple">
            hexo - Material
            <span class="sidebar-badge badge-circle">i</span>
        </div>
    </a>


    </div>

    <!-- Sidebar Image -->
    

</aside>

                    

                    
<!-- Footer Top Button -->
<div id="back-to-top" class="toTop-wrap">
    <a href="#top" class="toTop">
        <i class="material-icons footer_top-i">expand_less</i>
    </a>
</div>


<!--Footer-->
<footer class="mdl-mini-footer" id="bottom">
    
   <!-- Paradox Footer Left Section -->
   <div class="mdl-mini-footer--left-section sns-list">
    
    <!-- Google + -->
    
        <a href="https://www.google.com/" target="_blank">
            <button class="mdl-mini-footer--social-btn social-btn footer-sns-gplus">
                <span class="visuallyhidden">Google Plus</span>
            </button><!--
     --></a>
    
</div>


        <!--Copyright-->
        <div id="copyright">
            Copyright&nbsp;Â©&nbsp;<span year></span>&nbsp;Hexo
            
        </div>

        <!-- Paradox Footer Right Section -->

        <!--
        I am glad you use this theme, the development is no so easy, I hope you can keep the copyright.
        It will not impact the appearance and can give developers a lot of support :)
        -->

        <div class="mdl-mini-footer--right-section">
            <div>
                <div class="footer-develop-div">Powered by <a href="https://hexo.io" target="_blank" class="footer-develop-a">Hexo</a></div>
                <div class="footer-develop-div">Theme - <a href="https://github.com/viosey/hexo-theme-material" target="_blank" class="footer-develop-a">Material</a></div>
            </div>
        </div>
    
</footer>


                    <!-- Import JS File -->

    <script>lsloader.load("lazyload_js","${blog}/static/js/lazyload.min.js?wgjW/HuQG9JDgvPDPoRAng==", true)</script>



    <script>lsloader.load("js_js","${blog}/static/js/js.min.js?LT4t6iE6m8TO1BLGGiNJqA==", true)</script>



    <script>lsloader.load("np_js","/js/nprogress.js?pl3Qhb9lvqR1FlyLUna1Yw==", true)</script>


<script type="text/ls-javascript" id="NProgress-script">
    NProgress.configure({
        showSpinner: true
    });
    NProgress.start();
    $('#nprogress .bar').css({
        'background': '#29d'
    });
    $('#nprogress .peg').css({
        'box-shadow': '0 0 10px #29d, 0 0 15px #29d'
    });
    $('#nprogress .spinner-icon').css({
        'border-top-color': '#29d',
        'border-left-color': '#29d'
    });
    setTimeout(function() {
        NProgress.done();
        $('.fade').removeClass('out');
    }, 800);
</script>












    <!-- Swiftye -->
    

    <!-- Local Search-->
    


<!-- UC Browser Compatible -->
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('ucbrowser')>0) {
		document.write('<link rel="stylesheet" href="/css/uc.css">');
		alert('由于 UC 浏览器使用极旧的内核，而本网站使用了一些新的特性。\n为了您能更好的浏览，推荐使用 Chrome 或 Firefox 浏览器。')
	}
</script>
<!-- Import prettify js  -->

<!-- Window Load -->
<!-- add class for prettify -->
<script type="text/ls-javascript" id="window-load">
    $(window).on('load', function() {
        // Post_Toc parent position fixed
        $('.post-toc-wrap').parent('.mdl-menu__container').css('position', 'fixed');
    });

</script>

<!-- MathJax Load-->


<!-- Bing Background -->


<script type="text/ls-javascript" id="lazy-load">
    // Offer LazyLoad
    queue.offer(function(){
        $('.lazy').lazyload({
            effect : 'show'
        });
    });

    // Start Queue
    $(document).ready(function(){
        setInterval(function(){
            queue.execNext();
        },200);
    });
</script>

<!-- Custom Footer -->


<script>
    var copyrightNow = new Date().getFullYear();
    var textContent = document.querySelector('span[year]')

    copyrightSince = 0000;
    if (copyrightSince === copyrightNow||copyrightSince === 0000) {
        textContent.textContent = copyrightNow
    } else {
        textContent.textContent = copyrightSince + ' - ' + copyrightNow
    }

    (function(){
        var scriptList = document.querySelectorAll('script[type="text/ls-javascript"]')

        for (var i = 0; i < scriptList.length; ++i) {
            var item = scriptList[i];
            lsloader.runInlineScript(item.id,item.id);
        }
    })()
</script>

                </main>
            </div>
        </body>
    
</html>
