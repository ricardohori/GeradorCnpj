package br.com.synchro.obrigacoes

import br.com.synchro.api.utils.ApiUtils
import br.com.synchro.api.utils.TargetApplication
import br.com.synchro.baseLegal.EstruturacaoBaseLegal
import org.hibernate.Session
import br.com.synchro.api.gateway.controller.IntegrationController

/**
 * <pre>
 * User: rfh
 * Date: 2/5/14
 *
 * </pre>
 */
@Mixin(IntegrationController)
class BaseLegalController {

    def visualizar = {
        render(
                view: "visualizar",
                model:[items: EstruturacaoBaseLegal.list()]
        )
    }

    def salvar = {
        final estruturaBaseLegal = EstruturacaoBaseLegal.get(params.id as Long)
        estruturaBaseLegal.status = params.status
        estruturaBaseLegal.linkFonte = params.linkFonte
        estruturaBaseLegal.orgaoClassificador = params.orgaoClassificador
        estruturaBaseLegal.fonte = params.fonte
        estruturaBaseLegal.responsavel = params.responsavel
        estruturaBaseLegal.save(flush: true, failOnError: true)
        render """
                Item <b>[${estruturaBaseLegal.id}] [${estruturaBaseLegal.orgaoClassificador}] [${estruturaBaseLegal.fonte}] [${estruturaBaseLegal.linkFonte}]</b><br />
                    Registrado com status <b>${estruturaBaseLegal.status}</b> para <b>${estruturaBaseLegal.responsavel}</b>
        """
    }

    def listarDados = {
        createApiWith(EstruturacaoBaseLegal)
    }

    def atualizar = {
        final basesEmUso = ApiUtils.getRemoteList(TargetApplication.OBRIGACOES, "basesLegaisEmUso", BaseLegalTO)
        int count = 0
        int countTotal = 0

        basesEmUso.each{BaseLegalTO baseEmUso->
            final bases = []
            bases.addAll baseEmUso.baseLegalInstituidora? baseEmUso.baseLegalInstituidora.split("\\|") : []
            bases.addAll baseEmUso.baseLegalAtualizadora ? baseEmUso.baseLegalAtualizadora.split("\\|") : []

            bases.each{
                EstruturacaoBaseLegal.withSession {Session session->
                    final baseLegal = it.trim()
                    final identificadorOrgaoLegal = baseEmUso.orgaoLegal?.trim()

                    if(baseLegal && identificadorOrgaoLegal){
                        final baseExistente = EstruturacaoBaseLegal.findByBaseLegalAndIdentificadorOrgaoLegal(baseLegal, identificadorOrgaoLegal)

                        if(!baseExistente){
                            final estruturacaoBaseLegal = new EstruturacaoBaseLegal(
                                    obrigacao: baseEmUso.obrigacao,
                                    identificadorOrgaoLegal: identificadorOrgaoLegal,
                                    baseLegal: baseLegal,
                                    componenteObrigacao: baseEmUso.componenteObrigacao.name(),
                                    status: "Em fila"
                            ).save(flush: true, failOnError: true)

                            println "Salvando nova base legal! ===> " + estruturacaoBaseLegal.identificadorOrgaoLegal + " - " + estruturacaoBaseLegal.baseLegal
                            count++
                        }else{
                            baseExistente.identificadorOrgaoLegal = identificadorOrgaoLegal
                            baseExistente.baseLegal = baseLegal
                            baseExistente.save(flush: true, failOnError: true)
                        }
                    }

                    if(countTotal % 50 == 0){
                        session.flush()
                        session.clear()
                    }
                }
                countTotal++
            }
        }

        render "${count} bases novas adicionadas! Total de bases => ${countTotal}"
    }

}
