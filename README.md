## What's this?
Docker 初心者の私がお勉強がてら Jenkins のタイムゾーンを JST(Asia/Tokyo) にする DockerFile を書いてみた。

```dockerfile
FROM jenkins/jenkins:lts
LABEL maintainer="https://qiita.com/k1tajima"

# set timezone for Java runtime arguments
ENV JAVA_OPTS=-Duser.timezone=Asia/Tokyo

# set timezone for OS by root
USER root
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# drop back to the regular jenkins user - good practice
USER jenkins
```

内容はわかってしまえば簡単。ポイントは次の通り。

* JAVA_OPTS で JavaVM 起動時にタイムゾーンを指定
* OS のタイムゾーンも合わせて変更する時は USER root してから変更


## その他のノウハウ
* Docker Hub 上で `official` と付記されている Docker Image: [`jenkins`](https://hub.docker.com/_/jenkins/) は廃止されている。  
Full Description の先頭にも **DEPRECATION NOTICE** と明記されている。
* 他にも類似のイメージが散見されるが、現時点で Jenkins Community によって公式メンテされている Docker Image は
 [`jenkins/jenkins`](https://hub.docker.com/r/jenkins/jenkins/) とのこと。
* この Docker Image では `docker exec -it` でコンテナにログインしても sudo できないようになっている（[README.md](https://github.com/jenkinsci/docker/blob/master/README.md#installing-more-tools) 参照）。  
なので、root 権限が必要な変更は Dockerfile を用意して対処しておくのが得策。
