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
    <link href="${resource(dir: "js/vendor/dataTables/css", file: "jquery.dataTables_themeroller.css")}" rel="stylesheet">
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

    <div class="starter-template">
        <h1>Bases Legais em uso pelo Obrigações</h1>

        <hr />
        <form id="atualizar-form">
            <g:actionSubmit action="atualizar" id="atualizar" value="Atualizar bases legais"/><div id="msg"></div>
        </form>
        <hr />
        <table id="tabela-bases-legais">
            <thead>
                <tr>
                    <th><input style="width: 25px"/></th>
                    <th><input /></th>
                    <th><input /></th>
                    <th><input /></th>
                    <th><input /></th>
                    <th><input /></th>
                    <th><input style="width: 280px"/></th>
                    <th><input /></th>
                    <th><input /></th>
                    <th></th>
                </tr>
                <tr>
                    <th>Id</th>
                    <th>Obrigação </th>
                    <th>Órgão Legal </th>
                    <th>BaseLegal </th>
                    <th>Órgão Classificador</th>
                    <th>Fonte </th>
                    <th>Link da Fonte </th>
                    <th>Responsável </th>
                    <th>Status </th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${items}" var="item" status="idx">
                    <tr id="${idx}">
                        <td class="id">${item.id}</td>
                        <td>${item.obrigacao}</td>
                        <td>${item.identificadorOrgaoLegal}</td>
                        <td>${item.baseLegal}</td>
                        <td>
                            <p style="display: none;">${item.orgaoClassificador}</p>
                            <textarea rows="2" style="width: 150px" id="orgaoClassificador-${item.id}" name="orgaoClassificador" class="orgaoClassificador">${item.orgaoClassificador}</textarea>
                        </td>
                        <td>
                            <p style="display: none;">${item.fonte}</p>
                            <input type="text" id="fonte-${item.id}" name="fonte" class="fonte" value="${item.fonte}"/>
                        </td>
                        <td>
                            <p style="display: none;">${item.linkFonte}</p>
                            <textarea rows="3" style="width: 300px" id="linkFonte-${item.id}" name="linkFonte" class="linkFonte">${item.linkFonte}</textarea>
                        </td>
                        <td>
                            <p style="display: none;">${item.responsavel}</p>
                            <input type="text" id="responsavel-${item.id}" name="responsavel" class="responsavel" value="${item.responsavel}"/>
                        </td>
                        <td>
                            <p style="display: none;">${item.status}</p>
                            <input type="text" id="status-${item.id}" name="status" class="status" value="${item.status}"/>
                        </td>
                        <td>
                            <input id="salvar-linha-${item.id}" class="salvar-linha" type="button" value="Salvar" />
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${resource(dir: "js/vendor/twitter-bootstrap", file: "bootstrap.js")}"></script>
<script src="${resource(dir: "js/vendor/dataTables/js", file: "jquery.dataTables.js")}"></script>

<script type="text/javascript">
    $(document).ready(function(){
        var oTable = $('#tabela-bases-legais').dataTable( {
            "oLanguage": {
                "sSearch": "Search all columns:"
            },
            "bScrollInfinite": true,
            "bScrollCollapse": true,
            "sScrollY": "600px",
            "fnSaveState": true,
            "fnDrawCallback": function () {
                var currentTable = this;

                var updateTd = function(obj, idx){
                    $(obj).parent().find("p").remove();
                    var val = $(obj).val();
                    var newP = "<p style='display: none'>" + val + "</p>";
                    var newText = $(obj).parent().html() + newP;
                    var td = $(obj).closest("td");
                    var tr = $(obj).closest("tr");
                    currentTable.fnUpdate(newText, tr.attr("id"), idx);
                    td.find("input, textarea, select").val(val);
                };

                $("[class=salvar-linha]").click(function(){
                    var id = $(this).closest("tr").find(".id").text();
                    var params = {id:id};
                    $(this).closest("tr").find("input[type=text], select, textarea").each(function(index, child){
                        var childJ = $(child);
                        params[childJ.attr("name")] = childJ.val()
                    });

                    $.ajax({
                        url: "baseLegal/salvar",
                        data: params
                    }).success(function(data) {
                                $("#msg").html(data)
                            }).fail(function(){
                                $("#msg").text("Erro ao tentar salvar!")
                            });
                });

                $("[class=orgaoClassificador]").blur(function(){
                    updateTd(this, 4)
                });

                $("[class=fonte]").blur(function(){
                    updateTd(this, 5)
                });

                $("[class=linkFonte]").blur(function(){
                    updateTd(this, 6)
                });

                $("[class=responsavel]").blur(function(){
                    updateTd(this, 7)
                });

                $("[class=status]").blur(function(){
                    updateTd(this, 8)
                });
            }
        } );


        $("thead input").keyup( function () {
            /* Filter on the column (the index) of this element */
            oTable.fnFilter( this.value, $("thead input").index(this) );
        } );

        $("thead input").focus( function () {
            if ( this.className == "search_init" )
            {
                this.className = "";
                this.value = "";
            }
        } );
    })

</script>
</body>
</html>
