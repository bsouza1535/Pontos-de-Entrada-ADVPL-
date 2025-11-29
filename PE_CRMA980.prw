

#include "Protheus.ch"
#include "FWMVCDEF.CH"

Static __LogTela    := NIL

//-------------------------------------------------------------------

/*/{Protheus.doc} CRMA980

Ponto de Entrada do Cadastro de Clientes (MVC)
Temos aqui um exemplo de Ponto de Entrada MVC que bloqueia a exclusão de clientes no momento da validação antes da gravação (MODELPOS) e registra um log após a confirmação da transação (MODELCOMMITTTS).
ATENÇÃO: Este Ponto de Entrada é apenas um exemplo didático. Em um ambiente de produção, recomenda-se implementar lógicas de negócio mais robustas e considerar aspectos de segurança e desempenho.
@param      PARAMIXB     Array com os parâmetros padrões dos Pontos de Entrada MVC.
@return     Varios. Dependerão de qual PE esta sendo executado.
@author     Bruno Souza
@version    12.1.17
@since      29/11/2025
/*/

//-------------------------------------------------------------------

User Function CRMA980()
    Local aParam        := PARAMIXB
    Local xRet          := .T.
    Local cIDPonto      := ''
    Local cIDModel      := ''
    Local oObj          := NIL

    If __LogTela == NIL
        __LogTela   := ApMsgYesNo("A geracao do 'LOG de processamento' dos PE 'CRMA980' (MVC) sera exibido em TELA?" + CRLF + CRLF +;
            'SIM = TELA' + CRLF +;
            'NAO = CONSOLE do AppServer')
    EndIf

    If aParam <> NIL
        oObj        := aParam[1]
        cIDPonto    := aParam[2]
        cIDModel    := aParam[3]
        nOperation := oObj:GetOperation()

        // MODELPOS: Validacao antes da gravacao (este PE consegue bloquear a operacao)
        If cIDPonto == 'MODELPOS'

            // Exclusao
            If nOperation == 5
                xRet := .F.
                MsgAlert("Exclusao bloqueada pelo Ponto de Entrada customizado!", "CRMA980 - MODELPOS")
            EndIf

        // MODELCOMMITTTS: Apos a transacao ser confirmada
        ElseIf cIDPonto == 'MODELCOMMITTTS'

            // Aqui a transacao ja foi confirmada
            If nOperation == 5
                // Apenas para log/auditoria
                MsgAlert("Exclusao ja foi confirmada", "CRMA980 - MODELCOMMITTTS")
            EndIf
        EndIf
    EndIf
Return (xRet)

