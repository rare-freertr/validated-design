# Metropolitan Area Network use case [bgp-fm]

## BGP Fully Meshed

```
cd validated-design/000-man/001-run-interconnect
java -jar ../../rtr.jar test tester criann path ./ temp ./ wait
```
From there you should have the replica of a regional network in production that would have BGP Fully Meshed.

## Diagram
![syvik-2-diagram.png](../syvik-2-diagram.png)

## Assumptions

### Public adresses

We used the public subnet `194.199.218.128/28` split into 8 subnets `/31`

### Loopback identification

* Node Loopback0 rule (IPv6):

2001:660:2001: abcd::`id`/128

## Verification

* leh100001

```
leh100001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.217  64919  true   6      6     00:28:51
194.199.218.218  64919  true   6      6     00:30:24
194.199.218.219  64919  true   6      6     00:29:23
194.199.218.220  64919  true   6      6     00:25:10
194.199.218.221  64919  true   6      6     00:29:32

leh100001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::2  64919  true   6      6     00:19:19
2001:660:2001:abcd::3  64919  true   6      6     00:19:19
2001:660:2001:abcd::4  64919  true   6      6     00:19:20
2001:660:2001:abcd::5  64919  true   6      6     00:19:16
2001:660:2001:abcd::6  64919  true   6      6     00:19:15
```

* leh200001

```
leh200001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.216  64919  true   6      6     00:33:05
194.199.218.218  64919  true   6      6     00:33:39
194.199.218.219  64919  true   6      6     00:33:36
194.199.218.220  64919  true   6      6     00:29:26
194.199.218.221  64919  true   6      6     00:33:47

leh200001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::1  64919  true   6      6     00:23:21
2001:660:2001:abcd::3  64919  true   6      6     00:22:30
2001:660:2001:abcd::4  64919  true   6      6     00:22:09
2001:660:2001:abcd::5  64919  true   6      6     00:21:55
2001:660:2001:abcd::6  64919  true   6      6     00:33:47
```

* uro100001

```
uro100001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.216  64919  true   6      6     00:36:09
194.199.218.217  64919  true   6      6     00:35:10
194.199.218.219  64919  true   6      6     00:36:31
194.199.218.220  64919  true   6      6     00:35:36
194.199.218.221  64919  true   6      6     00:35:18

uro100001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::1  64919  true   6      6     00:24:52
2001:660:2001:abcd::2  64919  true   6      6     00:24:01
2001:660:2001:abcd::4  64919  true   6      6     00:23:42
2001:660:2001:abcd::5  64919  true   6      6     00:23:26
2001:660:2001:abcd::6  64919  true   6      6     00:35:18
```
* uro200001

```
uro200001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.216  64919  true   6      6     00:36:23
194.199.218.217  64919  true   6      6     00:36:22
194.199.218.218  64919  true   6      6     00:37:46
194.199.218.220  64919  true   6      6     00:36:44
194.199.218.221  64919  true   6      6     00:32:45

uro200001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::1  64919  true   6      6     00:26:09
2001:660:2001:abcd::2  64919  true   6      6     00:24:56
2001:660:2001:abcd::3  64919  true   6      6     00:24:58
2001:660:2001:abcd::5  64919  true   6      6     00:24:34
2001:660:2001:abcd::6  64919  true   6      6     00:24:19
```
* cfr100001

```
cfr100001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.216  64919  true   6      6     00:33:09
194.199.218.217  64919  true   6      6     00:33:12
194.199.218.218  64919  true   6      6     00:37:50
194.199.218.219  64919  true   6      6     00:37:43
194.199.218.221  64919  true   6      6     00:37:26

cfr100001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::1  64919  true   6      6     00:27:04
2001:660:2001:abcd::2  64919  true   6      6     00:25:41
2001:660:2001:abcd::3  64919  true   6      6     00:25:41
2001:660:2001:abcd::4  64919  true   6      6     00:25:33
2001:660:2001:abcd::6  64919  true   6      6     00:25:14
```
* cfr200001

```
cfr200001#show ipv4 bgp 1 summary                                                                       
neighbor         as     ready  learn  sent  uptime
194.199.218.216  64919  true   6      6     00:38:40
194.199.218.217  64919  true   6      6     00:38:40
194.199.218.218  64919  true   6      6     00:38:40
194.199.218.219  64919  true   6      6     00:34:52
194.199.218.220  64919  true   6      6     00:38:34

cfr200001#show ipv6 bgp 1 summary                                                                       
neighbor               as     ready  learn  sent  uptime
2001:660:2001:abcd::1  64919  true   6      6     00:28:11
2001:660:2001:abcd::2  64919  true   6      6     00:38:40
2001:660:2001:abcd::3  64919  true   6      6     00:38:40
2001:660:2001:abcd::4  64919  true   6      6     00:26:26
2001:660:2001:abcd::5  64919  true   6      6     00:26:21
```
