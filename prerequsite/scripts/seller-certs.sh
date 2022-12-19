set -x

mkdir -p /organizations/peerOrganizations/seller.agm.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/seller.agm.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-seller:7054 --caname ca-seller --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-seller-7054-ca-seller.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-seller-7054-ca-seller.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-seller-7054-ca-seller.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-seller-7054-ca-seller.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/seller.agm.com/msp/config.yaml"



fabric-ca-client register --caname ca-seller --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"



fabric-ca-client register --caname ca-seller --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"




fabric-ca-client register --caname ca-seller --id.name selleradmin --id.secret selleradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-seller:7054 --caname ca-seller -M "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/msp" --csr.hosts peer0.seller.agm.com --csr.hosts  peer0-seller --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"



cp "/organizations/peerOrganizations/seller.agm.com/msp/config.yaml" "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-seller:7054 --caname ca-seller -M "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls" --enrollment.profile tls --csr.hosts peer0.seller.agm.com --csr.hosts  peer0-seller --csr.hosts ca-seller --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"




cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/ca.crt"
cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/signcerts/"* "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/server.crt"
cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/keystore/"* "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/seller.agm.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/seller.agm.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/seller.agm.com/tlsca"
cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/tls/tlscacerts/"* "/organizations/peerOrganizations/seller.agm.com/tlsca/tlsca.seller.agm.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/seller.agm.com/ca"
cp "/organizations/peerOrganizations/seller.agm.com/peers/peer0.seller.agm.com/msp/cacerts/"* "/organizations/peerOrganizations/seller.agm.com/ca/ca.seller.agm.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-seller:7054 --caname ca-seller -M "/organizations/peerOrganizations/seller.agm.com/users/User1@seller.agm.com/msp" --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"

cp "/organizations/peerOrganizations/seller.agm.com/msp/config.yaml" "/organizations/peerOrganizations/seller.agm.com/users/User1@seller.agm.com/msp/config.yaml"

fabric-ca-client enroll -u https://selleradmin:selleradminpw@ca-seller:7054 --caname ca-seller -M "/organizations/peerOrganizations/seller.agm.com/users/Admin@seller.agm.com/msp" --tls.certfiles "/organizations/fabric-ca/seller/tls-cert.pem"

cp "/organizations/peerOrganizations/seller.agm.com/msp/config.yaml" "/organizations/peerOrganizations/seller.agm.com/users/Admin@seller.agm.com/msp/config.yaml"

{ set +x; } 2>/dev/null
