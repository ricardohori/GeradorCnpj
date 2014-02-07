package br.com.synchro.obrigacoes

/**
 * Created with IntelliJ IDEA.
 * User: gbr
 * Date: 12/6/13
 * Time: 10:02 AM
 * To change this template use File | Settings | File Templates.
 */
public enum ComponenteObrigacao {
    OBRIGACAO("Obrigação"),
    APLICABILIDADE("Aplicabilidade"),
    PERIODICIDADE("Periodicidade"),
    PENALIDADE("Penalidade"),
    DADOENTREGA("Dado de Entrega"),
    CRITERIOVENCIMENTO("Critério de Vencimento"),
    REGRAVENCIMENTO("Regra de Vencimento")

    final String rotulo

    ComponenteObrigacao(final String pRotulo){
        this.rotulo = pRotulo
    }
}