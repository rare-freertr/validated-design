# Metropolitan Area Network use case [isis-sr]

## ISIS Segment Routing (SR) extension config

```
cd validated-design/000-man/003a-run-isis-sr
java -jar ../../rtr.jar test tester criann path ./ temp ./ wait
```
From that point you should have a running lab as depicted in the diagram below. This lab inherit from [isis](../002-run-isis)
In the present lab, we will test ISIS with SR extension into the routing domain. Loopback0 is the SR node-sid

## Diagram
![syvik-2-diagram.png](../syvik-2-diagram.png)

## Assumptions

### ISIS SR configuration

* Segment Routing domain radius is set to 15 nodes

## Verification


* leh100001

```
leh100001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.2/32  2      866039  866039
10.0.0.3/32  3      866039  526253
10.0.0.4/32  4      866039  381927
10.0.0.5/32  5      432107  99116
10.0.0.6/32  6      432107  432107

leh100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 12, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.1, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh100001#
leh100001#traceroute 10.0.0.2 vrf CORE source loopback0
tracing 10.0.0.2, src=10.0.0.1, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.2/32 115/20 ethernet1 10.0.12.1 00:13:58
1 10.0.0.2 time=0, mpls=866041
leh100001#traceroute 10.0.0.3 vrf CORE source loopback0
tracing 10.0.0.3, src=10.0.0.1, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.3/32 115/30 ethernet1 10.0.12.1 00:13:42
1 10.0.23.0 time=1, mpls=866042
2 10.0.0.3 time=0, mpls=526256
leh100001#traceroute 10.0.0.4 vrf CORE source loopback0
tracing 10.0.0.4, src=10.0.0.1, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.4/32 115/40 ethernet1 10.0.12.1 00:13:22
1 10.0.23.0 time=1, mpls=866043
2 10.0.34.0 time=0, mpls=526257
3 10.0.0.4 time=1, mpls=381931
leh100001#traceroute 10.0.0.5 vrf CORE source loopback0
tracing 10.0.0.5, src=10.0.0.1, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.5/32 115/30 ethernet2 10.0.16.1 00:13:01
1 10.0.56.1 time=1, mpls=432112
2 10.0.0.5 time=0, mpls=99121
leh100001#traceroute 10.0.0.6 vrf CORE source loopback0
tracing 10.0.0.6, src=10.0.0.1, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.6/32 115/20 ethernet2 10.0.16.1 00:12:51
1 10.0.0.6 time=1, mpls=432113
```

* leh200001

```
leh200001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.1/32  1      723679  723679
10.0.0.3/32  3      526253  526253
10.0.0.4/32  4      526253  381927
10.0.0.5/32  5      526253  99116
10.0.0.6/32  6      723679  432107

leh200001#ping ping 10.0.0.1 vrf CORE source loopback0
invalid command, try ping <host> ?

leh200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 14, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.2, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.5/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
leh200001#
leh200001#
leh200001#traceroute 10.0.0.1 vrf CORE source loopback0
tracing 10.0.0.1, src=10.0.0.2, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.1/32 115/20 ethernet1 10.0.12.0 00:17:04
1 10.0.0.1 time=4, mpls=723680
leh200001#traceroute 10.0.0.3 vrf CORE source loopback0
tracing 10.0.0.3, src=10.0.0.2, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.3/32 115/20 ethernet2 10.0.23.1 00:12:34
1 10.0.0.3 time=1, mpls=526256
leh200001#traceroute 10.0.0.4 vrf CORE source loopback0
tracing 10.0.0.4, src=10.0.0.2, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.4/32 115/30 ethernet2 10.0.23.1 00:12:16
1 10.0.34.0 time=0, mpls=526257
2 10.0.0.4 time=0, mpls=381931
leh200001#traceroute 10.0.0.5 vrf CORE source loopback0
tracing 10.0.0.5, src=10.0.0.2, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.5/32 115/40 ethernet2 10.0.23.1 00:11:54
1 10.0.34.0 time=1, mpls=526258
2 10.0.45.0 time=1, mpls=381932
3 10.0.0.5 time=1, mpls=99121
leh200001#traceroute 10.0.0.6 vrf CORE source loopback0
tracing 10.0.0.6, src=10.0.0.2, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.6/32 115/30 ethernet1 10.0.12.0 00:11:39
1 10.0.16.0 time=1, mpls=723685
2 10.0.0.6 time=1, mpls=432113
leh200001#

```

* uro100001

```
uro100001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.1/32  1      866039  723679
10.0.0.2/32  2      866039  866039
10.0.0.4/32  4      381927  381927
10.0.0.5/32  5      381927  99116
10.0.0.6/32  6      866039  432107

uro100001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 14, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.3, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro100001#
uro100001#
uro100001#
uro100001#traceroute 10.0.0.1 vrf CORE source loopback0
tracing 10.0.0.1, src=10.0.0.3, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.1/32 115/30 ethernet2 10.0.23.0 00:19:23
1 10.0.12.1 time=3, mpls=866040
2 10.0.0.1 time=1, mpls=723680
uro100001#traceroute 10.0.0.2 vrf CORE source loopback0
tracing 10.0.0.2, src=10.0.0.3, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.2/32 115/20 ethernet2 10.0.23.0 00:15:38
1 10.0.0.2 time=0, mpls=866041
uro100001#traceroute 10.0.0.4 vrf CORE source loopback0
tracing 10.0.0.4, src=10.0.0.3, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.4/32 115/20 ethernet1 10.0.34.1 00:14:57
1 10.0.0.4 time=0, mpls=381931
uro100001#traceroute 10.0.0.5 vrf CORE source loopback0
tracing 10.0.0.5, src=10.0.0.3, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.5/32 115/30 ethernet1 10.0.34.1 00:14:35
1 10.0.45.0 time=0, mpls=381932
2 10.0.0.5 time=0, mpls=99121
uro100001#traceroute 10.0.0.6 vrf CORE source loopback0
tracing 10.0.0.6, src=10.0.0.3, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.6/32 115/40 ethernet2 10.0.23.0 00:14:19
1 10.0.12.1 time=1, mpls=866045
2 10.0.16.0 time=1, mpls=723685
3 10.0.0.6 time=0, mpls=432113
uro100001#

```


* uro200001

```
uro200001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.1/32  1      526253  723679
10.0.0.2/32  2      526253  866039
10.0.0.3/32  3      526253  526253
10.0.0.5/32  5      99116   99116
10.0.0.6/32  6      99116   432107

uro200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 15, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.2/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.4, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
uro200001#
uro200001#
uro200001#traceroute 10.0.0.1 vrf CORE source loopback0
tracing 10.0.0.1, src=10.0.0.4, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.1/32 115/40 ethernet1 10.0.34.0 00:19:43
1 10.0.23.1 time=3, mpls=526254
2 10.0.12.1 time=1, mpls=866040
3 10.0.0.1 time=0, mpls=723680
uro200001#traceroute 10.0.0.2 vrf CORE source loopback0
tracing 10.0.0.2, src=10.0.0.4, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.2/32 115/30 ethernet1 10.0.34.0 00:17:07
1 10.0.23.1 time=1, mpls=526255
2 10.0.0.2 time=1, mpls=866041
uro200001#traceroute 10.0.0.3 vrf CORE source loopback0
tracing 10.0.0.3, src=10.0.0.4, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.3/32 115/20 ethernet1 10.0.34.0 00:16:52
1 10.0.0.3 time=0, mpls=526256
uro200001#traceroute 10.0.0.5 vrf CORE source loopback0
tracing 10.0.0.5, src=10.0.0.4, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.5/32 115/20 ethernet2 10.0.45.1 00:16:07
1 10.0.0.5 time=0, mpls=99121
uro200001#traceroute 10.0.0.6 vrf CORE source loopback0
tracing 10.0.0.6, src=10.0.0.4, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.6/32 115/30 ethernet2 10.0.45.1 00:15:51
1 10.0.56.0 time=0, mpls=99122
2 10.0.0.6 time=1, mpls=432113
uro200001#

```

* cfr100001

```
cfr100001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.1/32  1      432107  723679
10.0.0.2/32  2      432107  866039
10.0.0.3/32  3      381927  526253
10.0.0.4/32  4      381927  381927
10.0.0.6/32  6      432107  432107

cfr100001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 23, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.3/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#ping 10.0.0.6 vrf CORE source loopback0
pinging 10.0.0.6, src=10.0.0.5, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 1, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr100001#
cfr100001#
cfr100001#traceroute 10.0.0.1 vrf CORE source loopback0
tracing 10.0.0.1, src=10.0.0.5, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.1/32 115/30 ethernet1 10.0.56.1 00:28:36
1 10.0.16.1 time=3, mpls=432108
2 10.0.0.1 time=1, mpls=723680
cfr100001#traceroute 10.0.0.2 vrf CORE source loopback0
tracing 10.0.0.2, src=10.0.0.5, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.2/32 115/40 ethernet1 10.0.56.1 00:26:35
1 10.0.16.1 time=1, mpls=432109
2 10.0.12.0 time=1, mpls=723681
3 10.0.0.2 time=1, mpls=866041
cfr100001#traceroute 10.0.0.3 vrf CORE source loopback0
tracing 10.0.0.3, src=10.0.0.5, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.3/32 115/30 ethernet2 10.0.45.0 00:26:25
1 10.0.34.1 time=1, mpls=381930
2 10.0.0.3 time=1, mpls=526256
cfr100001#traceroute 10.0.0.4 vrf CORE source loopback0
tracing 10.0.0.4, src=10.0.0.5, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.4/32 115/20 ethernet2 10.0.45.0 00:26:06
1 10.0.0.4 time=0, mpls=381931
cfr100001#traceroute 10.0.0.6 vrf CORE source loopback0
tracing 10.0.0.6, src=10.0.0.5, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.6/32 115/20 ethernet1 10.0.56.1 00:25:24
1 10.0.0.6 time=1, mpls=432113
cfr100001#

```

* cfr200001

```
cfr200001#show ipv4 segrout CORE
prefix       index  base    oldbase
10.0.0.1/32  1      723679  723679
10.0.0.2/32  2      723679  866039
10.0.0.3/32  3      723679  526253
10.0.0.4/32  4      99116   381927
10.0.0.5/32  5      99116   99116

cfr200001#ping 10.0.0.1 vrf CORE source loopback0
pinging 10.0.0.1, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 22, min/avg/max/dev rtt=0/0.1/1/0.1, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.2 vrf CORE source loopback0
pinging 10.0.0.2, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.3 vrf CORE source loopback0
pinging 10.0.0.3, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.6/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.4 vrf CORE source loopback0
pinging 10.0.0.4, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 3, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#ping 10.0.0.5 vrf CORE source loopback0
pinging 10.0.0.5, src=10.0.0.6, vrf=CORE, cnt=5, len=64, df=false, tim=1000, gap=0, ttl=255, tos=0, sgt=0, flow=0, fill=0, alrt=-1, sweep=false, multi=false
!!!!!
result=100.0%, recv/sent/lost/err=5/5/0/0, took 2, min/avg/max/dev rtt=0/0.4/1/0.2, ttl 255/255/255/0.0, tos 0/0.0/0/0.0
cfr200001#
cfr200001#
cfr200001#traceroute 10.0.0.1 vrf CORE source loopback0
tracing 10.0.0.1, src=10.0.0.6, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.1/32 115/20 ethernet2 10.0.16.0 00:30:00
1 10.0.0.1 time=2, mpls=723680
cfr200001#traceroute 10.0.0.2 vrf CORE source loopback0
tracing 10.0.0.2, src=10.0.0.6, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.2/32 115/30 ethernet2 10.0.16.0 00:27:56
1 10.0.12.0 time=1, mpls=723681
2 10.0.0.2 time=1, mpls=866041
cfr200001#traceroute 10.0.0.3 vrf CORE source loopback0
tracing 10.0.0.3, src=10.0.0.6, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.3/32 115/40 ethernet2 10.0.16.0 00:27:38
1 10.0.12.0 time=1, mpls=723682
2 10.0.23.0 time=1, mpls=866042
3 10.0.0.3 time=0, mpls=526256
cfr200001#traceroute 10.0.0.4 vrf CORE source loopback0
tracing 10.0.0.4, src=10.0.0.6, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.4/32 115/30 ethernet1 10.0.56.0 00:27:18
1 10.0.45.1 time=0, mpls=99120
2 10.0.0.4 time=1, mpls=381931
cfr200001#traceroute 10.0.0.5 vrf CORE source loopback0
tracing 10.0.0.5, src=10.0.0.6, vrf=CORE, prt=0/33440, tim=1000, tos=0, flow=0, len=64
via 10.0.0.5/32 115/20 ethernet1 10.0.56.0 00:26:58
1 10.0.0.5 time=1, mpls=99121
cfr200001#
```
