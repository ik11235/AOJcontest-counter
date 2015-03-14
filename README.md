# AOJcontest-counter
AOJで開催されるコンテスト( http://judge.u-aizu.ac.jp/onlinejudge/contest.jsp )からAC数,submit数,first ACを取得するプログラム

オンサイト開催などで特定のチーム群だけでの情報と全てのチームの情報を取りたいときは、teamlist.txtに行ごとにチーム名を列挙すればそのファイルに書かれたチーム群だけの情報を取得できます。

```
% ruby main.rb -i RitsCamp15Day1    
contest id:		RitsCamp15Day1
onsite Team count:	16
contest API url:	http://judge.u-aizu.ac.jp/onlinejudge/webservice/contest_status_log?id=RitsCamp15Day1
ONsite:
A: 15/35 	 Fitst AC:Doubling
B: 16/51 	 Fitst AC:nimoji
C: 15/24 	 Fitst AC:WJK
D: 9/34 	 Fitst AC:Doubling
E: 10/17 	 Fitst AC:Doubling
F: 0/10 	 Fitst AC:
ALL:
A: 69/152 	 First AC:anta
B: 64/199 	 First AC:anta
C: 59/95 	 First AC:WJK
D: 45/178 	 First AC:yukim
E: 33/68 	 First AC:ichyo
F: 6/119 	 First AC:yutaka1999
```

## Usage
```
ruby main.rb -i [Contest ID]
```
