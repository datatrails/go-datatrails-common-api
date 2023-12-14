replace (
	// These pseudoversions are for: ConsenSys/quorum@v22.4.4
	github.com/coreos/etcd => github.com/Consensys/etcd v3.3.13-quorum197+incompatible

	// github.com/datatrails/go-datatrails-common-api => ../../go-datatrails-common-api/api
	github.com/ethereum/go-ethereum => github.com/ConsenSys/quorum v0.0.0-20221208112643-d318a5aa973a
	// github.com/ethereum/go-ethereum/crypto/secp256k1 => github.com/ConsenSys/goquorum-crypto-secp256k1 v0.0.2
	github.com/ethereum/go-ethereum/crypto/secp256k1 => github.com/ConsenSys/goquorum-crypto-secp256k1 v0.0.2

)

require ( 
    github.com/datatrails/go-datatrails-common-api-gen v0.3.3 // indirect
)