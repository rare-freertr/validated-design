# Metropolitan Area Network use case [isis]

## ISIS config

```
cd validated-design/000-man/002-run-isis
java -jar ../../rtr.jar test tester criann path ./ tmppath ./ wait
```
From that point you should have a running lab as depicted in the diagram below. This lab inherit from [interconnect](../001-run-interconnect)
In the present lab, we will test ISIS by redistributing looback0 into the routing domain.

## Diagram
![syvik-2-diagram.png](../syvik-2-diagram.png)

## Assumptions

### ISIS NSAP configuration

* NSAP format is:

```
49.0200.0971.460<$ID>.00
```

For example `leh100001` has id=`1`, thus its ISIS NSAP is: `49.0200.0971.460<$ID>.00`
In this example, $ID is inferior to `9`. In case

* Area level
For flexibility's sake, let's use a ISIS Level 2 area only.

* Integrated ISIS is used
with wide metric and also dual topology for IPv4 and IPv6. Hence the CLI knobis: `multi-topology` and `afi-other enable`

## Verification


* leh100001

```
leh100001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

leh100001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address       state  uptime
ethernet1  2      0200.0971.4602  10.0.12.1   fd00:200:971:12::1  up     00:39:21
ethernet2  2      0200.0971.4606  10.0.16.1   fd00:200:971:16::1  up     00:35:12

leh100001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
C    10.0.0.1/32   0/0     loopback0  null       04:32:02
I    10.0.0.2/32   115/10  ethernet1  10.0.12.1  00:39:24
I    10.0.0.3/32   115/20  ethernet1  10.0.12.1  00:36:40
I    10.0.0.4/32   115/30  ethernet1  10.0.12.1  00:36:18
I    10.0.0.5/32   115/20  ethernet2  10.0.16.1  00:35:15
I    10.0.0.6/32   115/10  ethernet2  10.0.16.1  00:35:15
C    10.0.12.0/31  0/0     ethernet1  null       04:32:02
LOC  10.0.12.0/32  0/1     ethernet1  null       04:32:02
C    10.0.16.0/31  0/0     ethernet2  null       04:32:02
LOC  10.0.16.0/32  0/1     ethernet2  null       04:32:02
I    10.0.23.0/31  115/20  ethernet1  10.0.12.1  00:39:24
I    10.0.34.0/31  115/30  ethernet1  10.0.12.1  00:36:40
I    10.0.45.0/31  115/30  ethernet2  10.0.16.1  00:35:15
I    10.0.56.0/31  115/20  ethernet2  10.0.16.1  00:35:15

leh100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 4, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#

leh100001#show ipv6 route CORE
typ   prefix                 metric  iface      hop                 time
C     fd00:200:971::1/128    0/0     loopback0  null                04:36:26
I EX  fd00:200:971::2/128    115/10  ethernet1  fd00:200:971:12::1  00:43:48
I EX  fd00:200:971::3/128    115/20  ethernet1  fd00:200:971:12::1  00:41:04
I EX  fd00:200:971::4/128    115/30  ethernet1  fd00:200:971:12::1  00:40:42
I EX  fd00:200:971::5/128    115/20  ethernet2  fd00:200:971:16::1  00:39:38
I EX  fd00:200:971::6/128    115/10  ethernet2  fd00:200:971:16::1  00:39:38
C     fd00:200:971:12::/127  0/0     ethernet1  null                04:36:26
LOC   fd00:200:971:12::/128  0/1     ethernet1  null                04:36:26
C     fd00:200:971:16::/127  0/0     ethernet2  null                04:36:26
LOC   fd00:200:971:16::/128  0/1     ethernet2  null                04:36:26
I     fd00:200:971:23::/127  115/20  ethernet1  fd00:200:971:12::1  00:43:48
I     fd00:200:971:34::/127  115/30  ethernet1  fd00:200:971:12::1  00:41:04
I     fd00:200:971:45::/127  115/30  ethernet2  fd00:200:971:16::1  00:39:38
I     fd00:200:971:56::/127  115/20  ethernet2  fd00:200:971:16::1  00:39:38

leh100001#ping fd00:200:971::2 vrf CORE source loopback0
pinging fd00:200:971::2, src=fd00:200:971::1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping fd00:200:971::3 vrf CORE source loopback0
pinging fd00:200:971::3, src=fd00:200:971::1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh100001#ping fd00:200:971::4 vrf CORE source loopback0
pinging fd00:200:971::4, src=fd00:200:971::1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
leh100001#ping fd00:200:971::5 vrf CORE source loopback0
pinging fd00:200:971::5, src=fd00:200:971::1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh100001#ping fd00:200:971::6 vrf CORE source loopback0
pinging fd00:200:971::6, src=fd00:200:971::1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.0/0/0.0, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#
```

* leh200001

```
leh200001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

leh200001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address       state  uptime
ethernet1  2      0200.0971.4601  10.0.12.0   fd00:200:971:12::   up     00:40:57
ethernet2  2      0200.0971.4603  10.0.23.1   fd00:200:971:23::1  up     00:38:21

leh200001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
I    10.0.0.1/32   115/10  ethernet1  10.0.12.0  00:36:22
C    10.0.0.2/32   0/0     loopback0  null       04:33:42
I    10.0.0.3/32   115/10  ethernet2  10.0.23.1  00:38:20
I    10.0.0.4/32   115/20  ethernet2  10.0.23.1  00:37:58
I    10.0.0.5/32   115/30  ethernet2  10.0.23.1  00:37:21
I    10.0.0.6/32   115/20  ethernet1  10.0.12.0  00:36:55
C    10.0.12.0/31  0/0     ethernet1  null       04:33:42
LOC  10.0.12.1/32  0/1     ethernet1  null       04:33:42
I    10.0.16.0/31  115/20  ethernet1  10.0.12.0  00:36:22
C    10.0.23.0/31  0/0     ethernet2  null       04:33:42
LOC  10.0.23.0/32  0/1     ethernet2  null       04:33:42
I    10.0.34.0/31  115/20  ethernet2  10.0.23.1  00:38:20
I    10.0.45.0/31  115/30  ethernet2  10.0.23.1  00:37:58
I    10.0.56.0/31  115/30  ethernet1  10.0.12.0  00:36:55

leh200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 14, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 4, min/avg/max/dev rtt=0/0.8/1/0.1, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh200001#

leh200001#show ipv6 route CORE
typ   prefix                  metric  iface      hop                 time
I EX  fd00:200:971::1/128     115/10  ethernet1  fd00:200:971:12::   00:36:27
C     fd00:200:971::2/128     0/0     loopback0  null                04:33:47
I EX  fd00:200:971::3/128     115/10  ethernet2  fd00:200:971:23::1  00:38:25
I EX  fd00:200:971::4/128     115/20  ethernet2  fd00:200:971:23::1  00:38:03
I EX  fd00:200:971::5/128     115/30  ethernet2  fd00:200:971:23::1  00:37:26
I EX  fd00:200:971::6/128     115/20  ethernet1  fd00:200:971:12::   00:36:59
C     fd00:200:971:12::/127   0/0     ethernet1  null                04:33:47
LOC   fd00:200:971:12::1/128  0/1     ethernet1  null                04:33:47
I     fd00:200:971:16::/127   115/20  ethernet1  fd00:200:971:12::   00:36:27
C     fd00:200:971:23::/127   0/0     ethernet2  null                04:33:47
LOC   fd00:200:971:23::/128   0/1     ethernet2  null                04:33:47
I     fd00:200:971:34::/127   115/20  ethernet2  fd00:200:971:23::1  00:38:25
I     fd00:200:971:45::/127   115/30  ethernet2  fd00:200:971:23::1  00:38:03
I     fd00:200:971:56::/127   115/30  ethernet1  fd00:200:971:12::   00:36:59

leh200001#ping fd00:200:971::1 vrf CORE source loopback0
pinging fd00:200:971::1, src=fd00:200:971::2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping fd00:200:971::3 vrf CORE source loopback0
pinging fd00:200:971::3, src=fd00:200:971::2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping fd00:200:971::4 vrf CORE source loopback0
pinging fd00:200:971::4, src=fd00:200:971::2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh200001#ping fd00:200:971::5 vrf CORE source loopback0
pinging fd00:200:971::5, src=fd00:200:971::2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
leh200001#ping fd00:200:971::6 vrf CORE source loopback0
pinging fd00:200:971::6, src=fd00:200:971::2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
leh200001#
```

* uro100001

```
uro100001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

uro100001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address       state  uptime
ethernet1  2      0200.0971.4604  10.0.34.1   fd00:200:971:34::1  up     00:43:40
ethernet2  2      0200.0971.4602  10.0.23.0   fd00:200:971:23::   up     00:43:59

uro100001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
I    10.0.0.1/32   115/20  ethernet2  10.0.23.0  00:42:11
I    10.0.0.2/32   115/10  ethernet2  10.0.23.0  00:44:09
C    10.0.0.3/32   0/0     loopback0  null       04:39:31
I    10.0.0.4/32   115/10  ethernet1  10.0.34.1  00:43:47
I    10.0.0.5/32   115/20  ethernet1  10.0.34.1  00:43:10
I    10.0.0.6/32   115/30  ethernet2  10.0.23.0  00:42:44
I    10.0.12.0/31  115/20  ethernet2  10.0.23.0  00:44:09
I    10.0.16.0/31  115/30  ethernet2  10.0.23.0  00:42:11
C    10.0.23.0/31  0/0     ethernet2  null       04:39:31
LOC  10.0.23.1/32  0/1     ethernet2  null       04:39:31
C    10.0.34.0/31  0/0     ethernet1  null       04:39:31
LOC  10.0.34.0/32  0/1     ethernet1  null       04:39:31
I    10.0.45.0/31  115/20  ethernet1  10.0.34.1  00:43:47
I    10.0.56.0/31  115/30  ethernet1  10.0.34.1  00:43:10

uro100001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 13, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.0/0/0.0, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 4, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
uro100001#
uro100001#show ipv6 route CORE
typ   prefix                  metric  iface      hop                 time
I EX  fd00:200:971::1/128     115/20  ethernet2  fd00:200:971:23::   00:42:58
I EX  fd00:200:971::2/128     115/10  ethernet2  fd00:200:971:23::   00:44:56
C     fd00:200:971::3/128     0/0     loopback0  null                04:40:18
I EX  fd00:200:971::4/128     115/10  ethernet1  fd00:200:971:34::1  00:44:34
I EX  fd00:200:971::5/128     115/20  ethernet1  fd00:200:971:34::1  00:43:57
I EX  fd00:200:971::6/128     115/30  ethernet2  fd00:200:971:23::   00:43:30
I     fd00:200:971:12::/127   115/20  ethernet2  fd00:200:971:23::   00:44:56
I     fd00:200:971:16::/127   115/30  ethernet2  fd00:200:971:23::   00:42:58
C     fd00:200:971:23::/127   0/0     ethernet2  null                04:40:18
LOC   fd00:200:971:23::1/128  0/1     ethernet2  null                04:40:18
C     fd00:200:971:34::/127   0/0     ethernet1  null                04:40:18
LOC   fd00:200:971:34::/128   0/1     ethernet1  null                04:40:18
I     fd00:200:971:45::/127   115/20  ethernet1  fd00:200:971:34::1  00:44:34
I     fd00:200:971:56::/127   115/30  ethernet1  fd00:200:971:34::1  00:43:57

uro100001#ping fd00:200:971::1 vrf CORE source loopback0
pinging fd00:200:971::1, src=fd00:200:971::3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro100001#ping fd00:200:971::2 vrf CORE source loopback0
pinging fd00:200:971::2, src=fd00:200:971::3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping fd00:200:971::4 vrf CORE source loopback0
pinging fd00:200:971::4, src=fd00:200:971::3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping fd00:200:971::5 vrf CORE source loopback0
pinging fd00:200:971::5, src=fd00:200:971::3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro100001#ping fd00:200:971::6 vrf CORE source loopback0
pinging fd00:200:971::6, src=fd00:200:971::3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
uro100001#
```


* uro200001

```
uro200001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

uro200001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address       state  uptime
ethernet1  2      0200.0971.4603  10.0.34.0   fd00:200:971:34::   up     00:45:57
ethernet2  2      0200.0971.4605  10.0.45.1   fd00:200:971:45::1  up     00:45:25

uro200001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
I    10.0.0.1/32   115/30  ethernet1  10.0.34.0  00:44:28
I    10.0.0.2/32   115/20  ethernet1  10.0.34.0  00:46:04
I    10.0.0.3/32   115/10  ethernet1  10.0.34.0  00:46:04
C    10.0.0.4/32   0/0     loopback0  null       04:41:48
I    10.0.0.5/32   115/10  ethernet2  10.0.45.1  00:45:27
I    10.0.0.6/32   115/20  ethernet2  10.0.45.1  00:45:02
I    10.0.12.0/31  115/30  ethernet1  10.0.34.0  00:46:04
I    10.0.16.0/31  115/30  ethernet2  10.0.45.1  00:45:02
I    10.0.23.0/31  115/20  ethernet1  10.0.34.0  00:46:04
C    10.0.34.0/31  0/0     ethernet1  null       04:41:48
LOC  10.0.34.1/32  0/1     ethernet1  null       04:41:48
C    10.0.45.0/31  0/0     ethernet2  null       04:41:48
LOC  10.0.45.0/32  0/1     ethernet2  null       04:41:48
I    10.0.56.0/31  115/20  ethernet2  10.0.45.1  00:45:27

uro200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 17, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro200001#

uro200001#show ipv6 route CORE
typ   prefix                  metric  iface      hop                 time
I EX  fd00:200:971::1/128     115/30  ethernet1  fd00:200:971:34::   00:45:19
I EX  fd00:200:971::2/128     115/20  ethernet1  fd00:200:971:34::   00:46:54
I EX  fd00:200:971::3/128     115/10  ethernet1  fd00:200:971:34::   00:46:55
C     fd00:200:971::4/128     0/0     loopback0  null                04:42:39
I EX  fd00:200:971::5/128     115/10  ethernet2  fd00:200:971:45::1  00:46:18
I EX  fd00:200:971::6/128     115/20  ethernet2  fd00:200:971:45::1  00:45:52
I     fd00:200:971:12::/127   115/30  ethernet1  fd00:200:971:34::   00:46:54
I     fd00:200:971:16::/127   115/30  ethernet2  fd00:200:971:45::1  00:45:52
I     fd00:200:971:23::/127   115/20  ethernet1  fd00:200:971:34::   00:46:55
C     fd00:200:971:34::/127   0/0     ethernet1  null                04:42:39
LOC   fd00:200:971:34::1/128  0/1     ethernet1  null                04:42:39
C     fd00:200:971:45::/127   0/0     ethernet2  null                04:42:38
LOC   fd00:200:971:45::/128   0/1     ethernet2  null                04:42:38
I     fd00:200:971:56::/127   115/20  ethernet2  fd00:200:971:45::1  00:46:18

uro200001#ping fd00:200:971::1 vrf CORE source loopback0
pinging fd00:200:971::1, src=fd00:200:971::4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
uro200001#ping fd00:200:971::2 vrf CORE source loopback0
pinging fd00:200:971::2, src=fd00:200:971::4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro200001#ping fd00:200:971::3 vrf CORE source loopback0
pinging fd00:200:971::3, src=fd00:200:971::4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping fd00:200:971::5 vrf CORE source loopback0
pinging fd00:200:971::5, src=fd00:200:971::4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping fd00:200:971::6 vrf CORE source loopback0
pinging fd00:200:971::6, src=fd00:200:971::4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.0/0/0.0, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
uro200001#
```

* cfr100001

```
cfr100001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

cfr100001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address       state  uptime
ethernet1  2      0200.0971.4606  10.0.56.1   fd00:200:971:56::1  up     00:47:34
ethernet2  2      0200.0971.4604  10.0.45.0   fd00:200:971:45::   up     00:47:54

cfr100001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
I    10.0.0.1/32   115/20  ethernet1  10.0.56.1  00:47:01
I    10.0.0.2/32   115/30  ethernet1  10.0.56.1  00:47:33
I    10.0.0.3/32   115/20  ethernet2  10.0.45.0  00:48:00
I    10.0.0.4/32   115/10  ethernet2  10.0.45.0  00:48:00
C    10.0.0.5/32   0/0     loopback0  null       04:44:21
I    10.0.0.6/32   115/10  ethernet1  10.0.56.1  00:47:35
I    10.0.12.0/31  115/30  ethernet1  10.0.56.1  00:47:01
I    10.0.16.0/31  115/20  ethernet1  10.0.56.1  00:47:35
I    10.0.23.0/31  115/30  ethernet2  10.0.45.0  00:48:00
I    10.0.34.0/31  115/20  ethernet2  10.0.45.0  00:48:00
C    10.0.45.0/31  0/0     ethernet2  null       04:44:21
LOC  10.0.45.1/32  0/1     ethernet2  null       04:44:21
C    10.0.56.0/31  0/0     ethernet1  null       04:44:21
LOC  10.0.56.0/32  0/1     ethernet1  null       04:44:21

cfr100001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 15, min/avg/max/dev rtt=0/0.5/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#
cfr100001#show ipv6 route CORE
typ   prefix                  metric  iface      hop                 time
I EX  fd00:200:971::1/128     115/20  ethernet1  fd00:200:971:56::1  00:47:36
I EX  fd00:200:971::2/128     115/30  ethernet1  fd00:200:971:56::1  00:48:09
I EX  fd00:200:971::3/128     115/20  ethernet2  fd00:200:971:45::   00:48:36
I EX  fd00:200:971::4/128     115/10  ethernet2  fd00:200:971:45::   00:48:36
C     fd00:200:971::5/128     0/0     loopback0  null                04:44:56
I EX  fd00:200:971::6/128     115/10  ethernet1  fd00:200:971:56::1  00:48:10
I     fd00:200:971:12::/127   115/30  ethernet1  fd00:200:971:56::1  00:47:36
I     fd00:200:971:16::/127   115/20  ethernet1  fd00:200:971:56::1  00:48:10
I     fd00:200:971:23::/127   115/30  ethernet2  fd00:200:971:45::   00:48:36
I     fd00:200:971:34::/127   115/20  ethernet2  fd00:200:971:45::   00:48:36
C     fd00:200:971:45::/127   0/0     ethernet2  null                04:44:56
LOC   fd00:200:971:45::1/128  0/1     ethernet2  null                04:44:56
C     fd00:200:971:56::/127   0/0     ethernet1  null                04:44:56
LOC   fd00:200:971:56::/128   0/1     ethernet1  null                04:44:56

cfr100001#ping fd00:200:971::1 vrf CORE source loopback0
pinging fd00:200:971::1, src=fd00:200:971::5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr100001#ping fd00:200:971::2 vrf CORE source loopback0
pinging fd00:200:971::2, src=fd00:200:971::5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
cfr100001#ping fd00:200:971::3 vrf CORE source loopback0
pinging fd00:200:971::3, src=fd00:200:971::5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr100001#ping fd00:200:971::4 vrf CORE source loopback0
pinging fd00:200:971::4, src=fd00:200:971::5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping fd00:200:971::6 vrf CORE source loopback0
pinging fd00:200:971::6, src=fd00:200:971::5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#
```

* cfr200001

````
cfr200001#show ipv4 isis 200971 interface
interface  neighbors
ethernet1  1
ethernet2  1

cfr200001#show ipv4 isis 200971 neighbor
interface  level  routerid        ip address  other address      state  uptime
ethernet1  2      0200.0971.4605  10.0.56.0   fd00:200:971:56::  up     00:49:29
ethernet2  2      0200.0971.4601  10.0.16.0   fd00:200:971:16::  up     00:49:28

cfr200001#show ipv4 route CORE
typ  prefix        metric  iface      hop        time
I    10.0.0.1/32   115/10  ethernet2  10.0.16.0  00:49:01
I    10.0.0.2/32   115/20  ethernet2  10.0.16.0  00:49:01
I    10.0.0.3/32   115/30  ethernet2  10.0.16.0  00:49:01
I    10.0.0.4/32   115/20  ethernet1  10.0.56.0  00:49:35
I    10.0.0.5/32   115/10  ethernet1  10.0.56.0  00:49:35
C    10.0.0.6/32   0/0     loopback0  null       04:46:21
I    10.0.12.0/31  115/20  ethernet2  10.0.16.0  00:49:01
C    10.0.16.0/31  0/0     ethernet2  null       04:46:21
LOC  10.0.16.1/32  0/1     ethernet2  null       04:46:21
I    10.0.23.0/31  115/30  ethernet2  10.0.16.0  00:49:01
I    10.0.34.0/31  115/30  ethernet1  10.0.56.0  00:49:35
I    10.0.45.0/31  115/20  ethernet1  10.0.56.0  00:49:35
C    10.0.56.0/31  0/0     ethernet1  null       04:46:21
LOC  10.0.56.1/32  0/1     ethernet1  null       04:46:21

cfr200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 14, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#
cfr200001#show ipv6 route CORE
typ   prefix                  metric  iface      hop                time
I EX  fd00:200:971::1/128     115/10  ethernet2  fd00:200:971:16::  00:49:41
I EX  fd00:200:971::2/128     115/20  ethernet2  fd00:200:971:16::  00:49:41
I EX  fd00:200:971::3/128     115/30  ethernet2  fd00:200:971:16::  00:49:41
I EX  fd00:200:971::4/128     115/20  ethernet1  fd00:200:971:56::  00:50:14
I EX  fd00:200:971::5/128     115/10  ethernet1  fd00:200:971:56::  00:50:14
C     fd00:200:971::6/128     0/0     loopback0  null               04:47:01
I     fd00:200:971:12::/127   115/20  ethernet2  fd00:200:971:16::  00:49:41
C     fd00:200:971:16::/127   0/0     ethernet2  null               04:47:01
LOC   fd00:200:971:16::1/128  0/1     ethernet2  null               04:47:01
I     fd00:200:971:23::/127   115/30  ethernet2  fd00:200:971:16::  00:49:41
I     fd00:200:971:34::/127   115/30  ethernet1  fd00:200:971:56::  00:50:14
I     fd00:200:971:45::/127   115/20  ethernet1  fd00:200:971:56::  00:50:14
C     fd00:200:971:56::/127   0/0     ethernet1  null               04:47:01
LOC   fd00:200:971:56::1/128  0/1     ethernet1  null               04:47:01

cfr200001#ping fd00:200:971::1 vrf CORE source loopback0
pinging fd00:200:971::1, src=fd00:200:971::6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping fd00:200:971::2 vrf CORE source loopback0
pinging fd00:200:971::2, src=fd00:200:971::6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr200001#ping fd00:200:971::3 vrf CORE source loopback0
pinging fd00:200:971::3, src=fd00:200:971::6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 253/253/253/0.0, tos 0/0.0/0/0.0
cfr200001#ping fd00:200:971::4 vrf CORE source loopback0
pinging fd00:200:971::4, src=fd00:200:971::6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 254/254/254/0.0, tos 0/0.0/0/0.0
cfr200001#ping fd00:200:971::5 vrf CORE source loopback0
pinging fd00:200:971::5, src=fd00:200:971::6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#
```
