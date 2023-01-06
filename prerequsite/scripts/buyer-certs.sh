  set -x
mkdir -p /organizations/peerOrganizations/buyer.agm.com/
export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/buyer.agm.com/

fabric-ca-client enroll -u https://agmadmin:agmadminpw@ca-buyer:8054 --caname ca-buyer --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-buyer-8054-ca-buyer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-buyer-8054-ca-buyer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-buyer-8054-ca-buyer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-buyer-8054-ca-buyer.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/buyer.agm.com/msp/config.yaml"



fabric-ca-client register --caname ca-buyer --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

fabric-ca-client register --caname ca-buyer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

fabric-ca-client register --caname ca-buyer --id.name buyeradmin --id.secret buyeradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

fabric-ca-client enroll -u https://peer0:peer0pw@ca-buyer:8054 --caname ca-buyer -M "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/msp" --csr.hosts peer0.buyer.agm.com --csr.hosts  peer0-buyer --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

cp "/organizations/peerOrganizations/buyer.agm.com/msp/config.yaml" "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/msp/config.yaml"

fabric-ca-client enroll -u https://peer0:peer0pw@ca-buyer:8054 --caname ca-buyer -M "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls" --enrollment.profile tls --csr.hosts peer0.buyer.agm.com --csr.hosts  peer0-buyer --csr.hosts ca-buyer --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"


cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/ca.crt"
cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/signcerts/"* "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/server.crt"
cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/keystore/"* "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/buyer.agm.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/buyer.agm.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/buyer.agm.com/tlsca"
cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/buyer.agm.com/tlsca/tlsca.buyer.agm.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/buyer.agm.com/ca"
cp "/organizations/peerOrganizations/buyer.agm.com/peers/peer0.buyer.agm.com/msp/cacerts/"* "/organizations/peerOrganizations/buyer.agm.com/ca/ca.buyer.agm.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-buyer:8054 --caname ca-buyer -M "/organizations/peerOrganizations/buyer.agm.com/users/User1@buyer.agm.com/msp" --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

cp "/organizations/peerOrganizations/buyer.agm.com/msp/config.yaml" "/organizations/peerOrganizations/buyer.agm.com/users/User1@buyer.agm.com/msp/config.yaml"

fabric-ca-client enroll -u https://buyeradmin:buyeradminpw@ca-buyer:8054 --caname ca-buyer -M "/organizations/peerOrganizations/buyer.agm.com/users/Admin@buyer.agm.com/msp" --tls.certfiles "/organizations/fabric-ca/buyer/tls-cert.pem"

cp "/organizations/peerOrganizations/buyer.agm.com/msp/config.yaml" "/organizations/peerOrganizations/buyer.agm.com/users/Admin@buyer.agm.com/msp/config.yaml"

  { set +x; } 2>/dev/null