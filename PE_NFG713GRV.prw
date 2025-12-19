#INCLUDE "Protheus.ch"
#INCLUDE "TOTVS.ch"
#INCLUDE "FILEIO.CH"
#Include "FwLibVersion.ch"

/*/{Protheus.doc} NFG713GRV
Realiza gravações complementares durante a execução do job de transmissão dos boletos
registrados online (API), na chamada do PE as tabelas envolvidas no processo estarão posicionadas
(SE1, SEA, SA6, SEE e etc...). Caso haja a necessidade de mexer no posicionamento das tabelas lembre-se de utilizar
o FwGetArea e FwRestArea, garantindo assim a integridade do job.
@type  Function
@author Bruno de Souza
@since 19/12/2025
@version 12.1.2410
@see https://tdn.totvs.com/pages/viewpage.action?pageId=780009506
@obs Exemplo de uso do ponto de entrada para captura de retorno da API de registro de boletos online.
/*/
User Function NFG713GRV()
	Local aArea := FwGetArea()
	Local oRetJson  := Nil
	Local oXmlPsr   := Nil
	Local cXmlErro  := ""
	Local cXmlWarn  := ""
	Local cNumTit   := SEA->EA_PREFIXO + SEA->EA_NUM + SEA->EA_PARCELA + SEA->EA_TIPO


	oRetJson := JsonObject():new()
	oRetJson:FromJson(SEA->EA_APIMSG)
	oXmlPsr :=  XMLPARSER(oRetJson['response'], "_", @cXmlErro, @cXmlWarn)

	If oXmlPsr <> Nil .And. Empty(cXmlErro) .And. Empty(cXmlWarn)
		If AttIsMemberOf(oXmlPsr,'_SOAPENV_ENVELOPE') //Validar se existe o nó do envelope
			//Validar se a situação no retorno é igual a 00 - Título registrado em cobrança;
			//Validar se foi retornado o código de barras do boleto;
			//Validar se foi retornado a linha digitavel do boleto.
			If  oXmlPsr:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_REGISTRATITULORESPONSE:_RETURN:_SITUACAO:TEXT == "00" .AND. ;
				!Empty(AllTrim(oXmlPsr:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_REGISTRATITULORESPONSE:_RETURN:_TITULO:_CDBARRA:TEXT)) .AND. ;
				!Empty(AllTrim(oXmlPsr:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_REGISTRATITULORESPONSE:_RETURN:_TITULO:_LINDIG:TEXT))

				CONOUT("PE_NFG713GRV - DT: " + dToC( dDataBase ) + " - HORA: " + Time() + " - TITULO " + cNumTit + " TITULO REGISTRADO EM COBRANCA." )				
			Endif
		Endif
	EndIf

	FwRestArea(aArea)
Return
