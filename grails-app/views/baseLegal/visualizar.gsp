<!DOCTYPE html>
<html>
<head>
    <title>Bases Legais</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="${resource(dir: "css/vendor/twitter-bootstrap", file: "bootstrap.css")}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <!-- Custom styles for this template -->
    <link href="${resource(dir: "css/vendor/twitter-bootstrap", file: "starter-template.css")}" rel="stylesheet">
    <link href="${resource(dir: "js/vendor/extjs/resources/css", file: "ext-all.css")}" rel="stylesheet">

    <script src="${resource(dir: "js/vendor/extjs", file: "ext-all-dev.js")}"></script>
    <script src="${resource(dir: "js/app/baseLegal", file: "baseLegal.js")}"></script>
</head>
<body>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <g:link class="navbar-brand" absolute="/">Bases Legais</g:link>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="${createLinkTo(absolute: "/")}">Home</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>

    <div class="container">

        <div class="starter-template" >
            <h1>Bases Legais em uso pelo Obrigações</h1>

            <hr />
            <form id="atualizar-form">
                <g:actionSubmit action="atualizar" id="atualizar" value="Atualizar bases legais"/><div id="msg"></div>
            </form>
            <hr />

            <div style="display: inline-block;">
                <div style="width: 10%"></div>
                <div id="grid-base-legal"></div>
                <div style="width: 10%"></div>
            </div>
        </div>
    </div>
</body>
</html>
