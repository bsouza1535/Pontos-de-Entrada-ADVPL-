#include "protheus.ch"


/*/{Protheus.doc} A010TOK
Ponto de entrada para impedir inclusão e alteração dos produtos com grupos 0008/0009/0010/0011/0012
autor:  Bruno Souza
data:     2025-11-18
versao:  1.0
/*/
User Function A010TOK()
    Local lRet := .T.

    If Inclui //Variável IInclui e Altera são globais
        If SB1->B1_GRUPO $ "0008/0009/0010/0011/0012"
            MsgStop("Inclusão de produtos dos grupos 0008, 0009, 0010, 0011 e 0012 não permitida!")
            lRet := .F.
            Alert("Inclusão bloqueada pelo ponto de entrada A010TOK, que não permite inclusão para os grupos 0008, 0009, 0010, 0011 e 0012 .")
        else
            Msginfo("Você incluiu um produto!")
        Endif
    else
        Msginfo("Você alterou um produto!")
    Endif
return (lRet)
