package br.com.synchro.baseLegal

class EstruturacaoBaseLegal {

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