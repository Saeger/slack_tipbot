
# ODN Slack Tipbot

## Setup

We're using [digitalocean.com](https://digitalocean.com) so these instructions will be specific to that plaform.

#### Compile your coin

For this example I'm using litecoin but the instructions should be similar for most other coins.

* Download the source code
  * `git clone https://github.com/obsidianproject/Obsidian-Qt.git`
* Run the daemon
  * `su obsidian`
  * `cd Obsidian-Qt && obsidiand`    
  * On the first run, obsidiand will return an error and tell you to make a configuration file, named obsidian.conf, in order to add a username and password to the file.
    * `nano ~/.obsidian/obsidian.conf && chmod 0600 ~/.obsidian/obsidian.conf`
    * Add the following to your config file, changing the username and password
    * to something secure. Make sure to take note of the `rpcuser` and * `rpcpassword` because you'll need them in a couple of steps
      * `daemon=1`
      * `staking=0`
      * `enableaccounts=1`
      * `rpcuser=odnrpc`
      * `rpcpassword=odnpass`
      * `rpcport=56661`
      * `rpcthreads=100`
      * `irc=0`
      * `dnsseed=1`
  * Run the daemon again
    * `obsidiand` 
  * To confirm that the daemon is running
    * `obsidiand getinfo`
  * Now wait for the blockchain to sync

#### Clone the CoinTipper Bot git repo

* `git clone https://github.com/jacobzlogar/slack_tipbot.git`

* `git checkout obsidian`

#### Launch the server!

* `bundle exec ruby tipper.rb -p 4567`
  
## Commands

* Tip - send someone coins

  `odntip tip @somebody 100`

* Deposit - put coin in

  `odntip deposit`

* Withdraw - take coin out

  `odntip withdraw LKzHM7rUB2sP1dgVskVFfdSoysnojuw2pX 100`

* Balance - find out how much is in your wallet

  `odntip balance`

## Security

This runs an unencrypted hot wallet on your server. You should not store significant amounts of cryptocoins in this wallet. Withdraw your tips to an offline wallet often. 

## Credits

This project was originally forked from [dogetip-slack](https://github.com/tenforwardconsulting/dogetip-slack) by [tenforwardconsulting](https://github.com/tenforwardconsulting)
