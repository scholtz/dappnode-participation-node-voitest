# VOI Participation DAppNode app

## Setup DAppNode in cloud

Create ubuntu server in server housing

- CPU 8 vCores
- 16 GB RAM
- 100 GB NVMe SSD or equivalent
- 100 Mbps connection minimum

Setup DAppNode : https://docs.dappnode.io/docs/user/install/script

```
sudo wget -O - https://prerequisites.dappnode.io | sudo bash
sudo wget -O - https://installer.dappnode.io | sudo bash
shutdown -r now
```

Setup VPN and connect your home computer to the node : https://docs.dappnode.io/docs/user/access-your-dappnode/vpn/openvpn

```
dappnode_openvpn
```

If error is shown

```
Error response from daemon: No such container: DAppNodeCore-vpn.dnp.dappnode.eth
```

run

```
sudo wget -O - https://installer.dappnode.io | sudo UPDATE=true bash
```

If error in openvpn is shown:

```
Compression or compression stub framing is not allowed since data-channel offloading is enabled.
OPTIONS ERROR: server pushed compression settings that are not allowed and will result in a non-working connection. See also allow-compression in the manual.
```

edit vpn configuration and add there lines:

```
comp-lzo yes
allow-compression yes
```

Open http://my.dappnode/ at your home computer which is connected to VPN to your DAppNode

And setup the passwords and update the system if needed.

## Install Participation Node Voitest

Go to [DAppStore](http://my.dappnode/installer/dnp) menu

Insert into search bar /ipfs/QmUygEGihrfYB6UK6emKAWcuVmQ35YnTDNTxwPeQZ73Z5m and hit enter

Click advanced options, enable Bypass only signed safe restriction, click INSTALL button, wait until the app is installed.

[Go to packages](http://my.dappnode/packages/my), click on "Participation Node Voitest".

Go to Logs, wait until your node is synced up.

## Setup participation account

In the root shell write `docker ps | grep voitest`

First column is docker container id.

Run 

```
docker exec -it {containerId} /bin/bash
```

Now you can access your goal command, you can check the node status with `goal node status`

### Create wallet

Select secure password and make sure you remember it.

```
goal wallet new voi
```

### Create new account

```
goal account new
```

Export the mnemonic and store it somewhere safe

```
goal account export -a $addr
```

### Fund your account

Fill in the form [Node Runner Form
](https://docs.google.com/forms/d/e/1FAIpQLSehNL0nNP0mtIXK5j615vxQtzz6QQpYUKHTVN4irN6YpHjXfg/viewform)

Wait until your account gets funded.

### Generate your participation keys

```
addr="YOUR ADDRESS"
start=$(goal node status | grep "Last committed block:" | cut -d\  -f4) 
duration=2000000
end=$((start + duration))
dilution=$(echo "sqrt($end - $start)" | bc)
goal account addpartkey -a $addr --roundFirstValid $start --roundLastValid $end --keyDilution $dilution
```

### Register to go online

```
goal account changeonlinestatus -a $addr -o=1 
```

### Register to go offline

If you want to stop the node, please make your account offline.

You can use [AWallet](https://www.a-wallet.net) to go offline or you can use the command

```
goal account changeonlinestatus -a $addr -o=0
```

## Modify name

```
diagcfg telemetry name -n "yourNodeName"
```

## Monitoring

Check your node status: https://voi-node-info.boeieruurd.com/


## Build image

git clone this repo

in linux connected to openvpn to your dappnode run

```
npx @dappnode/dappnodesdk build
```

Example output

```
  ✔ Verify connection
  ✔ Verify connection
  ✔ Create release dir
  ✔ Validate files
  ✔ Copy files
  ✔ Build docker image
  ✔ Save and compress image
  ✔ Upload release to IPFS node
  ✔ Save upload results

  DNP (DAppNode Package) built and uploaded
  Release hash : /ipfs/QmUygEGihrfYB6UK6emKAWcuVmQ35YnTDNTxwPeQZ73Z5m
  http://my.dappnode/installer/public/%2Fipfs%2FQmUygEGihrfYB6UK6emKAWcuVmQ35YnTDNTxwPeQZ73Z5m
```