#include "Protheus.ch"

/*
@Protheus.doc PRW PE_M030DEL
Ponto de Entrada para o Processo de Exclusão de Itens do Estoque (MVC) 
Este Ponto de Entrada é acionado durante o processo de exclusão de clientes. Ele permite a implementação de lógicas personalizadas antes que a exclusão seja efetivada.
@return     lRet - Lógico indicando se a operação deve continuar (.T.) ou ser bloqueada (.F.).
@author     Bruno Souza
@version    12.1.17
@since      18/12/2025
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784134
*/

User Function M030DEL()
    Local lRet := .T.
    Local aArea := GetArea()

    If SA1->A1_PESSOA == "J"
        lRet := .F.
        // Bloqueia a exclusão se o cliente for do tipo "Jurídica"
        MsgAlert("Exclusão de clientes do tipo 'Jurídica' está bloqueada por este Ponto de Entrada.", "PE_M030DEL")
    EndIf

    Restarea(aArea)

Return lRet
