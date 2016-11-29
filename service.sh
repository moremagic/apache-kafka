#! /bin/bash

# zookeeoer start
/kafka/bin/zookeeper-server-start.sh -daemon /kafka/config/zookeeper.properties
# -daemon option がなければブロッキングモードで起動される
/kafka/bin/kafka-server-start.sh -daemon /kafka/config/server.properties

ps aux | grep zookeeper
ps aux | grep kafka

# Trifecta start
/trifecta_ui-0.21.3/bin/trifecta_ui &

# sshd start
/usr/sbin/sshd -D

