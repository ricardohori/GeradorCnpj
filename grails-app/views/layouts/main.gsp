<!DOCTYPE html>
<html>
  <head>
    <title>Gerador de CNPJ</title>
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
                  <g:link class="navbar-brand" absolute="/">Gerador de CNPJ</g:link>
              </div>
              <div class="collapse navbar-collapse">
                  <ul class="nav navbar-nav">
                      <li class="active"><a href="${createLinkTo(absolute: "/")}">Home</a></li>
                  </ul>
              </div><!--/.nav-collapse -->
          </div>
      </div>

      <div class="container">

          <div class="starter-template">
              <h1>Gerar CNPJ</h1>
              <div class="input-group">
                  <span class="input-group-btn">
                      <button id="gerar-cnpj" class="btn btn-default" type="button">Gerar</button>
                  </span>
                  <input id="cnpj" type="text" class="form-control" />
              </div>

              <h1>Gerar Final CNPJ</h1>
              <div class="input-group">
                  <span class="input-group-btn">
                      <label id="gerar-final-label" class="form-control">Raiz</label>
                  </span>
                  <input id="raiz-cnpj" type="text" class="form-control" />
                  <span class="input-group-btn">
                      <button id="gerar-final-cnpj" class="btn btn-default" type="button">Gerar</button>
                  </span>
                  <input id="cnpj-final" type="text" class="form-control" />
              </div>

              <h1>Validar CNPJ</h1>
              <div class="input-group">
                  <span class="input-group-btn">
                      <label id="cnpj-validar-label" class="form-control">CNPJ</label>
                  </span>
                  <input id="cnpj-validar" type="text" class="form-control" />
                  <span class="input-group-btn">
                      <button id="validar-cnpj" class="btn btn-default" type="button">Validar</button>
                  </span>
                  <input id="esta-valido" type="text" class="form-control" />
              </div>
          </div>

      </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${resource(dir: "js/vendor/twitter-bootstrap", file: "bootstrap.js")}"></script>
    <script src="${resource(dir: "js/vendor/jquery", file: "jquery-1.2.6.pack.js")}"></script>
    <script src="${resource(dir: "js/vendor/jquery", file: "jquery.maskedinput-1.1.4.pack.js")}"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#gerar-cnpj").click(function(){
                $("#cnpj").val(gerarCNPJ());
            });
            $("#gerar-final-cnpj").click(function(){
                $("#cnpj-final").val(gerarCNPJComRaiz($("#raiz-cnpj").val()));
            });
            $("#validar-cnpj").click(function(){
                if(validarCNPJ($("#cnpj-validar").val())){
                    $("#esta-valido").val("Válido")
                    $("#esta-valido").css("color", "green")
                }else{
                    $("#esta-valido").val("Inválido!")
                    $("#esta-valido").css("color", "red")
                }
            });
            $("#cnpj").mask("99.999.999/9999-99");
            $("#raiz-cnpj").mask("99.999.999");
            $("#cnpj-final").mask("99.999.999/9999-99");
            $("#cnpj-validar").mask("99.999.999/9999-99");
        });

        function gerarCNPJComRaiz(raiz) {
            var comPontos = true;

            var n = 9;

            var n1 = raiz.charAt(0);
            var n2 = raiz.charAt(1);
            var n3 = raiz.charAt(3);
            var n4 = raiz.charAt(4);
            var n5 = raiz.charAt(5);
            var n6 = raiz.charAt(7);
            var n7 = raiz.charAt(8);
            var n8 = raiz.charAt(9);

            var n9 = randomiza(n);
            var n10 = randomiza(n);
            var n11 = randomiza(n);
            var n12 = randomiza(n);
            var d1 = n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;
            d1 = 11 - ( mod(d1,11) );

            if (d1>=10) d1 = 0;
            var d2 = d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
            d2 = 11 - ( mod(d2,11) );
            if (d2>=10) d2 = 0;
            retorno = '';
            if (comPontos) cnpj = ''+n1+n2+'.'+n3+n4+n5+'.'+n6+n7+n8+'/'+n9+n10+n11+n12+'-'+d1+d2;
            else cnpj = ''+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+d1+d2;

            return cnpj
        }

        function gerarCNPJ() {
            var comPontos = true;

            var n = 9;
            var n1 = randomiza(n);
            var n2 = randomiza(n);
            var n3 = randomiza(n);
            var n4 = randomiza(n);
            var n5 = randomiza(n);
            var n6 = randomiza(n);
            var n7 = randomiza(n);
            var n8 = randomiza(n);
            var n9 = 0; //randomiza(n);
            var n10 = 0; //randomiza(n);
            var n11 = 0; //randomiza(n);
            var n12 = 1; //randomiza(n);
            var d1 = n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;
            d1 = 11 - ( mod(d1,11) );

            if (d1>=10) d1 = 0;
            var d2 = d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
            d2 = 11 - ( mod(d2,11) );
            if (d2>=10) d2 = 0;
            retorno = '';
            if (comPontos) cnpj = ''+n1+n2+'.'+n3+n4+n5+'.'+n6+n7+n8+'/'+n9+n10+n11+n12+'-'+d1+d2;
            else cnpj = ''+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+d1+d2;

            return cnpj
        }

        function validarCNPJ(cnpj) {

            cnpj = cnpj.replace(/[^\d]+/g,'');

            if(cnpj == '') return false;

            // Elimina CNPJs invalidos conhecidos
            if (cnpj.length != 14 || cnpj == "00000000000000" || cnpj == "11111111111111" || cnpj == "22222222222222" || cnpj == "33333333333333" || cnpj == "44444444444444" || cnpj == "55555555555555" || cnpj == "66666666666666" || cnpj == "77777777777777" || cnpj == "88888888888888" || cnpj == "99999999999999")
                return false;

            // Valida DVs
            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0,tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                return false;

            tamanho = tamanho + 1;
            numeros = cnpj.substring(0,tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                return false;

            return true;

        }

        function randomiza(n) {
            var ranNum = Math.round(Math.random()*n);
            return ranNum;
        }

        function mod(dividendo,divisor) {
            return Math.round(dividendo - (Math.floor(dividendo/divisor)*divisor));
        }
    </script>
  </body>
</html>
