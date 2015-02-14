chef-sugar-rackspace
====================
Chef Sugar Extensions useful if you use Rackspace as a provider

Usage
-----
Include it in your Chef recipes:

```ruby
include_recipe 'chef-sugar-rackspace::default'
```

### IP
- `cloud_network_ip` - return the node's ip from a Rackspace cloud network
- `best_rackspace_ip_for` - determine the best IP address for a given node, preferring a cloud network IP address
- `cloud_networks` - return Rackspace cloud networks as a Hash with each key being a cloud network label

#### cloud_network_ip
```ruby
node.set['redis']['bind'] = cloud_network_ip
```

cloud_network_ip takes an optional argument of the Cloud Network Label
```ruby
node.set['redis']['bind'] = cloud_network_ip('mycloudnetwork')
```

#### best_rackspace_ip_for
Prefers a connected Rackspace cloud network IP but falls through to using the
default Chef Sugar best_ip_for() method if one does not exist.

```ruby
memcached = search('node', 'tags:memcached').first

memcahed_ip = best_rackspace_ip_for(memcached)
```

#### cloud_networks
```ruby
private_networks = cloud_networks
```

License & Authors
-----------------
- Author: Jim Rosser (jarosser06@gmail.com)

```text
copyright (C) 2015 Jim Rosser

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the “Software”), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
```
