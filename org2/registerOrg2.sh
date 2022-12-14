#!/bin/bash


createCertificatOrg2() {
  echo "Enroll the CA admin"

  mkdir -p ../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
}
nodeOrgUnits() {

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/config.yaml

}
registerUsers() {
  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.org2.amit.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.org2.amit.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.org2.amit.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.org2.amit.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

}
createCertificatOrg2
sleep 2
nodeOrgUnits
sleep 2
registerUsers
