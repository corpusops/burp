# CorpusOps ppa upgrade workflow
## INSTALL
```sh
sudo apt-get install devscripts debhelper dh-systemd dput python-paramiko python-scp/xenial python3-paramiko python3-scp
git clone https://github.com/corpusops/burp.git burpp/burp
cd burpp/burp
git remote add grke https://github.com/grke/burp.git
git fetch --all
```

## Refresh stable
```sh
git checkout master
git pull origin
git fetch grke
git rebase -i grke/master  # ou tag
mc_packaging/sync_debian.sh
```

## Test build in docker
```sh
docker build --progress=plain -t burpp  -f mc_packaging/Dockerfile .
docker run --name=burpp1 --rm -v /src_real -ti burpp bash
```
