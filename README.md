## My Own VPN

* Ensure ruby-dev is installed (required for librarian-puppet, else fails to load mkmf):

```
apt-get install ruby-dev make
```

* Install puppet:

```
wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get update
apt-get install puppet
```

* Initialize puppet:

```
gem install librarian-puppet --no-ri --no-rdoc
cd /etc/puppet
librarian-puppet init
<copy Puppetfile to /etc/puppet>
librarian-puppet install
```

* Execute puppet config:

```
<copy site.pp to /etc/puppet/manifests/site.pp>
puppet apply /etc/puppet/manifests/site.pp
```

* Concatenate the following into an .ovpn file (replace x.x.x.x with your ip)

```
client
dev tun
proto tcp-client
remote x.x.x.x 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
<ca>
Contents of ca.crt
</ca>
<cert>
Contents of client.crt
</cert>
<key>
Contents of client.key
</key>
```
