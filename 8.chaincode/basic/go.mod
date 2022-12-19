module github.com/marbles
module github.com/car_contract_api
  
go 1.12
go 1.13

require (
        github.com/hyperledger/fabric-chaincode-go v0.0.0-20200128192331-2d899240a7ed
        github.com/hyperledger/fabric-protos-go v0.0.0-20200124220212-e9cfc186ba7b
        golang.org/x/net v0.0.0-20200202094626-16171245cfb2 // indirect
        golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4 // indirect
        golang.org/x/text v0.3.2 // indirect
        google.golang.org/genproto v0.0.0-20200218151345-dad8c97a84f5 // indirect
        
        github.com/hyperledger/fabric v2.1.1+incompatible
	github.com/hyperledger/fabric-contract-api-go v1.0.0
	github.com/pkg/errors v0.9.1 // indirect
	github.com/sykesm/zap-logfmt v0.0.4 // indirect
	go.uber.org/zap v1.16.0 // indirect
)