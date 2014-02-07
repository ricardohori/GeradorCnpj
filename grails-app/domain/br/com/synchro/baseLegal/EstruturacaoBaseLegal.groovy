package br.com.synchro.baseLegal

import br.com.synchro.ext.util.ExtUtils
import br.com.synchro.framework.model.serializer.gateway.JsonApi

class EstruturacaoBaseLegal {

    static expose = 'estruturacaoBaseLegal'

    static api = [
            list : { params ->
                if(params.sort.toString().startsWith("[")){
                    final sort = JsonApi.defaultBuilder().build().deserialize(params.sort.toString(), List)
                    params.sort = sort[0].property
                    params.order = sort[0].direction
                }
                EstruturacaoBaseLegal.createCriteria().list(params){
                    ExtUtils.decodeFilterParams(params).each{k,v->
                        ilike k, "%${v}%" as String
                    }
                }
            },
            count: {params ->
                EstruturacaoBaseLegal.createCriteria().count{
                    ExtUtils.decodeFilterParams(params).each{k,v->
                        ilike k, "%${v}%" as String
                    }
                }
            }
    ]

    String obrigacao
    String identificadorOrgaoLegal
    String baseLegal
    String orgaoClassificador
    String fonte
    String linkFonte
    String responsavel
    String status
    String componenteObrigacao

    static constraints = {
        fonte nullable: true, blank: true, maxSize: 4000
        linkFonte nullable: true, blank: true, maxSize: 4000
        responsavel nullable: true, blank: true
        orgaoClassificador nullable: true, blank: true
        identificadorOrgaoLegal nullable: true, unique: ["baseLegal"], maxSize: 4000
        baseLegal maxSize: 4000
    }
}