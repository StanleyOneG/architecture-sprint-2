#!/bin/bash

# Initiate Config Server Replica Set
docker compose exec -T configSrv1 mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id: "config_server",
    configsvr: true,
    members: [
      { _id: 0, host: "configSrv1:27017" },
      { _id: 1, host: "configSrv2:27018" },
      { _id: 2, host: "configSrv3:27019" }
    ]
  }
);
EOF

# Wait for Config Server Replica Set to initialize
echo "Waiting for config server replica set to initialize..."
sleep 5

# Initiate Shard 1 Replica Set
docker compose exec -T shard01-a mongosh --port 27016 --quiet <<EOF
rs.initiate(
  {
    _id: "shard01",
    members: [
      { _id: 0, host: "shard01-a:27016" },
      { _id: 1, host: "shard01-b:27015" },
      { _id: 2, host: "shard01-c:27014" }
    ]
  }
);
EOF

# Wait for Shard 1 Replica Set to initialize
echo "Waiting for shard01 replica set to initialize..."
sleep 5

# Initiate Shard 2 Replica Set
docker compose exec -T shard02-a mongosh --port 27013 --quiet <<EOF
rs.initiate(
  {
    _id: "shard02",
    members: [
      { _id: 0, host: "shard02-a:27013" },
      { _id: 1, host: "shard02-b:27012" },
      { _id: 2, host: "shard02-c:27011" }
    ]
  }
);
EOF

# Wait for Shard 2 Replica Set to initialize
echo "Waiting for shard02 replica set to initialize..."
sleep 5

# Configure the Mongos Router
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard01/shard01-a:27016,shard01-b:27015,shard01-c:27014");
sh.addShard("shard02/shard02-a:27013,shard02-b:27012,shard02-c:27011");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name": "hashed" });

use somedb;

for (var i = 0; i < 1000; i++) {
  db.helloDoc.insert({ age: i, name: "ly" + i });
}

print("Documents inserted: " + db.helloDoc.countDocuments());
EOF

echo "Sharding setup and data population completed."
