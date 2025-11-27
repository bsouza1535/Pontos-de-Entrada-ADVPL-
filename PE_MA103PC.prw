#INCLUDE "Rwmake.ch"
#INCLUDE "Protheus.ch"
#Include "Topconn.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"

/*/{Protheus.doc} fAltUsr
Inclusão de Ações Relacionadas no Documento de Entrada (MATA103)
@type function
@version 12.1.2310
@author Bruno Souza
@since 13/05/2024
/*/

User Function MA103OPC()

Local aRet := {}

aAdd(aRet, {"Informar Chave Eletrônica","U_NFEVLDCHV('TR')",0,2})   //Preenche a Chave Eletronica na SF1,SF3,SFT : MATA311 - Transferencia entre Filiais

Return aRet
