## My Own VPN

* Update site.pp with your info
  * Replace `server-name` with your server's name
  * Duplicate `openvpn::client { ... }` and `openvpn::client_specific_config { ... }` for each of your clients, with unique names
  * Replace `?.?.?.?` with your masked server ip (x.x.x.0)

* Ensure ruby-dev is installed (required for librarian-puppet, else fails to load mkmf):

```
apt-get update
apt-get install ruby-dev make
```

* Install puppet:

```
wget https://apt.puppetlabs.com/puppetlabs-release-jessie.deb
dpkg -i puppetlabs-release-jessie.deb
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

* Or copy /etc/openvpn/<server-name>/download-configs/<client-name>.ovpn and change the following
  * Remove the `ca`, `cert`, and `key` lines
  * Change `proto` to `tcp-client`
  * Change `server-name` to your ip
