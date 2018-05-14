#!/bin/bash


kubectl --namespace=onenet delete service peer0
kubectl --namespace=onenet delete service orderer
kubectl --namespace=onenet delete deployment peer0
kubectl --namespace=onenet delete deployment orderer


