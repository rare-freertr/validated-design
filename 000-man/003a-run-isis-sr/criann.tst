
!---------- LE HAVRE ----------

addrouter leh100001 extcfg ./leh100001-sw.txt
int eth1 eth 0000.0001.1111 $1a$ $1b$
int eth2 eth 0000.0001.2222 $2a$ $2b$
!
!

addrouter leh200001 extcfg ./leh200001-sw.txt
int eth1 eth 0000.0002.1111 $1b$ $1a$
int eth2 eth 0000.0002.2222 $3a$ $3b$
!
!

!---------- ROUEN ----------

addrouter uro100001 extcfg ./uro100001-sw.txt
int eth1 eth 0000.0003.1111 $4a$ $4b$
int eth2 eth 0000.0003.2222 $3b$ $3a$
!
!

addrouter uro200001 extcfg ./uro200001-sw.txt
int eth1 eth 0000.0004.1111 $4b$ $4a$
int eth2 eth 0000.0004.2222 $5a$ $5b$
!
!

!---------- CAEN ----------

addrouter cfr100001 extcfg ./cfr100001-sw.txt
int eth1 eth 0000.0005.1111 $6a$ $6b$
int eth2 eth 0000.0005.2222 $5b$ $5a$
!
!

addrouter cfr200001 extcfg ./cfr200001-sw.txt
int eth1 eth 0000.0006.1111 $6b$ $6a$
int eth2 eth 0000.0006.2222 $2b$ $2a$
!
!





