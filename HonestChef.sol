/*

https://t.me/honestworkfarms
https://honestwork.farm

Join Us in this new concept of yield farming on polygon

Deflationary native token with 33% allocation to the HonestChef contract to be distributed on the farms


                 
                                                                                                                        
                                           `.::////:-`                                                                  
                                      `:+oo+/:-----:/+osso+:                                                            
                                    `oy/`               ``ssmo`                                                         
                                  `oy:                   `/`.ym:                                                        
                                ./ms::-:.-----....`      `.:  :mo                                                       
                              :ys/:...-/ooo:`    `...-..` `/   .h:                                                      
                            `ss`          `:oo/.        `.-/`   `d:                                                     
                           `ho         `----``-os/`    `./oso/`  d:                                                     
                           /h       `-:-````:::::/+oooso+:/: `//`.m.                                                    
                           /s      ..          ``:/::` `-::-.  `::ys.                                                   
                           `h/--+ ..            ```..::-`   .-   /sysy-                                                 
                            `:/:h.-   ..     `oo+///--       .:  /o-+:d                                                 
                                h/-///:/+`   .-`-+/o++-`      .. /: -/d`                                                
                                m.-.:+:/:`.  -`  ``            :.-+-.om.                                                
                                h. :.``  `:                     --::/:d                                                 
                                -h       .`   --.                /. `so                                                 
                                 h-      -   `:`+`--`            .o`/h-                                                 
                                 y:     o-/:..:.`  `--            +s:`                                                  
                                 h-    /.  .. `.--.. `            `d.                                                   
                                 h:    :`.-:/+///-`` -             os`                                                  
                                 /y     .` ```..`.`  `            .s.o:                                                 
                                  oo    `     ```                 s- `so//.                                             
                                   y+                 .`     .   `y   `+/:oo-`                                          
                                   `ho   `.`        -/:     -.   +:    `s  ./o+/-`                                      
                                  .-oho`  `.:-.--:/o/.     .`  `/o     /.     `-/oo:--`                                 
                             `.-:+--o`:o.    :::--.`         `:yo`   `/.        `-+--/s:.`                              
                         `-/y/:-`  o.  .+:`                `:ys-    .+`        ./.`   `:/so+.                           
                      `-+/-/:     -+    `s+-`          ``.:+s-     `+`        `o`         /os+:`                        
                   `-++-` `/     `h-    ::`-:-......-//://+:`     ./`         o`        `-.` `/h`                       
                  -+:`    /`    `/:s    `o    `..---..-/:-`       .          +-        --`    `oh/`                     
                `/+`     :`  `..+. +/   .o     ``..:+:.        `:           :+       `/-        -hh.                    
               -s-     `-:.--.o+/   o:  -:    -/:-.`          `/`          -:-:-.`  -/-          `+d:                   
              :y.     .:--.-:::+`    :/.`o  `/.     ``        +`          ::`` `.-::/-             :d+                  
             -h.      .:...` .:`:.    `--/-`+`    `:-`       /.         `::..---..`+.          -`   .hs`                
            -s`       /`     /`  /.     ``+:` `-` `         --         `+.      `-+:           `:    `+s.               
           `y`       :.     -.   `o      ..  -..          ```         ./`        :/             /      -y-              
           o.       `/     -:     /-    -`--- .`       `..`          -:         :/              :       .y:             
          :s        :`    ./      `+   .` :-/`:      `.-`           ::         ::              `-        `y:            
         `d.       `/    `+`       o   :     .-    `.-`            -:`        :/               -          `d-           
         oo        :.   `-/        -/ -`     /    ..`             ::         ::               -`           /d`          
        +s        `+`.-/+s          :-/      /   ``             `:/       `-:-               -.             yo          
       :y        `:y.`-+-            o.     ..                 `/y.`      //.               .-              `m:         
      `h.         `y-o+-`            /      :                  `.-/--:-` -o`  .-           .-                :m.        
      /o         `/+/:`.:/`         -.      :                   `o: `-/++o/    -/         `/                  /y        
      h.        -+...``..`:::-``    /       :                  `:/-:+/----      ./`      `+                    ss       
     .h       `+-         ```.:://:/o-```   /           ``.://:/+/:+              /-    `/                      s+      
     +o       s`                   ``.::::::o::.``.-//////:.`   ---/:              -:   :                       `yo     
     y/     `o-                       `.-.`   `-::-..--...``      . -+              `:                           `ho    
    -d`     o.                            `                       `: -+              `/                           `dy`  
   .m-     o-                                                         //              :.                           `sh` 
   y+     -+                                                           /+             `/                             +h.
  :y      s                                                             -s`            +                              .h
  +`     -:                                                              /o            :`                               
                                                                          :                                             
                                                                                                                        


SPDX-License-Identifier: MIT
*/
pragma solidity 0.8.4;

import "./SafeMath.sol";
import "./IBEP20.sol";
import "./SafeBEP20.sol";


import "./honestwork.sol";

// HonestChef is the master of 🚜. He can NOT mint 🚜 and but he is a fair guy and will give you rewards.
//
// Note that it's ownable and the owner wields tremendous power. The ownership
// will be transferred to a governance smart contract once honest is sufficiently
// distributed and the community can show to govern itself.
//



contract honestChef is Ownable {
    using SafeMath for uint256;
    using SafeBEP20 for IBEP20;

    // Info of each user.
    struct UserInfo {
        uint256 amount;         // How many LP tokens the user has provided.
        uint256 rewardDebt;     // Reward debt. See explanation below.
        //
        // We do some fancy math here. Basically, any point in time, the amount of EGGs
        // entitled to a user but is pending to be distributed is:
        //
        //   pending reward = (user.amount * pool.accEggPerShare) - user.rewardDebt
        //
        // Whenever a user deposits or withdraws LP tokens to a pool. Here's what happens:
        //   1. The pool's `accEggPerShare` (and `lastRewardBlock`) gets updated.
        //   2. User receives the pending reward sent to his/her address.
        //   3. User's `amount` gets updated.
        //   4. User's `rewardDebt` gets updated.
    }

    // Info of each pool.
    struct PoolInfo {
        IBEP20 lpToken;           // Address of LP token contract.
        uint256 allocPoint;       // How many allocation points assigned to this pool. EGGs to distribute per block.
        uint256 lastRewardBlock;  // Last block number that EGGs distribution occurs.
        uint256 accEggPerShare;   // Accumulated honests per share, times 1e12. See below.
        uint16 depositFeeBP;      // Deposit fee in basis points
    }

    // The honest TOKEN!
    HonestWork public honest;
    // Dev address.
    address public devaddr;
    // honest tokens created per block.
    uint256 public honestPerBlock;
    // Bonus muliplier for early Honest makers.
    uint256 public constant BONUS_MULTIPLIER = 1;
    // Deposit Fee address
    address public feeAddress;

    // Info of each pool.
    PoolInfo[] public poolInfo;
    // Info of each user that stakes LP tokens.
    mapping (uint256 => mapping (address => UserInfo)) public userInfo;
    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;
    // The block number when EGG mining starts.
    uint256 public startBlock;

    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);

    constructor(
        HonestWork _honest,
        address _devaddr,
        address _feeAddress,
        uint256 _honestPerBlock,
        uint256 _startBlock
    ) public {
        honest = _honest;
        devaddr = _devaddr;
        feeAddress = _feeAddress;
        honestPerBlock = _honestPerBlock;
        startBlock = _startBlock;
    }

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // Add a new lp to the pool. Can only be called by the owner.
    // XXX DO NOT add the same LP token more than once. Rewards will be messed up if you do.
    function add(uint256 _allocPoint, IBEP20 _lpToken, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
        require(_depositFeeBP <= 10000, "add: invalid deposit fee basis points");
        if (_withUpdate) {
            massUpdatePools();
        }
        uint256 lastRewardBlock = block.number > startBlock ? block.number : startBlock;
        totalAllocPoint = totalAllocPoint.add(_allocPoint);
        poolInfo.push(PoolInfo({
            lpToken: _lpToken,
            allocPoint: _allocPoint,
            lastRewardBlock: lastRewardBlock,
            accEggPerShare: 0,
            depositFeeBP: _depositFeeBP
        }));
    }

    // Update the given pool's honest allocation point and deposit fee. Can only be called by the owner.
    function set(uint256 _pid, uint256 _allocPoint, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
        require(_depositFeeBP <= 10000, "set: invalid deposit fee basis points");
        if (_withUpdate) {
            massUpdatePools();
        }
        totalAllocPoint = totalAllocPoint.sub(poolInfo[_pid].allocPoint).add(_allocPoint);
        poolInfo[_pid].allocPoint = _allocPoint;
        poolInfo[_pid].depositFeeBP = _depositFeeBP;
    }

    // Return reward multiplier over the given _from to _to block.
    function getMultiplier(uint256 _from, uint256 _to) public view returns (uint256) {
        return _to.sub(_from).mul(BONUS_MULTIPLIER);
    }

    // View function to see pending honest on frontend.
    function pendinghonest(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 accEggPerShare = pool.accEggPerShare;
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));
        if (block.number > pool.lastRewardBlock && lpSupply != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);
            uint256 honestReward = multiplier.mul(honestPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
            accEggPerShare = accEggPerShare.add(honestReward.mul(1e12).div(lpSupply));
        }
        return user.amount.mul(accEggPerShare).div(1e12).sub(user.rewardDebt);
    }

    // Update reward variables for all pools. Be careful of gas spending!
    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));
        if (lpSupply == 0 || pool.allocPoint == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }
        uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);
        uint256 honestReward = multiplier.mul(honestPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
        honest.transfer(devaddr, honestReward.div(10));
        honest.transfer(address(this), honestReward);
        pool.accEggPerShare = pool.accEggPerShare.add(honestReward.mul(1e12).div(lpSupply));
        pool.lastRewardBlock = block.number;
    }

    // Deposit LP tokens to MasterChef for honest allocation.
    function deposit(uint256 _pid, uint256 _amount) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        if (user.amount > 0) {
            uint256 pending = user.amount.mul(pool.accEggPerShare).div(1e12).sub(user.rewardDebt);
            if(pending > 0) {
                safeEggTransfer(msg.sender, pending);
            }
        }
        if(_amount > 0) {
            pool.lpToken.safeTransferFrom(address(msg.sender), address(this), _amount);
            if(pool.depositFeeBP > 0){
                uint256 depositFee = _amount.mul(pool.depositFeeBP).div(10000);
                pool.lpToken.safeTransfer(feeAddress, depositFee);
                user.amount = user.amount.add(_amount).sub(depositFee);
            }else{
                user.amount = user.amount.add(_amount);
            }
        }
        user.rewardDebt = user.amount.mul(pool.accEggPerShare).div(1e12);
        emit Deposit(msg.sender, _pid, _amount);
    }

    // Withdraw LP tokens from MasterChef.
    function withdraw(uint256 _pid, uint256 _amount) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        require(user.amount >= _amount, "withdraw: not good");
        updatePool(_pid);
        uint256 pending = user.amount.mul(pool.accEggPerShare).div(1e12).sub(user.rewardDebt);
        if(pending > 0) {
            safeEggTransfer(msg.sender, pending);
        }
        if(_amount > 0) {
            user.amount = user.amount.sub(_amount);
            pool.lpToken.safeTransfer(address(msg.sender), _amount);
        }
        user.rewardDebt = user.amount.mul(pool.accEggPerShare).div(1e12);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        user.amount = 0;
        user.rewardDebt = 0;
        pool.lpToken.safeTransfer(address(msg.sender), amount);
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    // Safe honest transfer function, just in case if rounding error causes pool to not have enough EGGs.
    function safeEggTransfer(address _to, uint256 _amount) internal {
        uint256 honestBal = honest.balanceOf(address(this));
        if (_amount > honestBal) {
            honest.transfer(_to, honestBal);
        } else {
            honest.transfer(_to, _amount);
        }
    }

    // Update dev address by the previous dev.
    function dev(address _devaddr) public {
        require(msg.sender == devaddr, "dev: wut?");
        devaddr = _devaddr;
    }

    function setFeeAddress(address _feeAddress) public{
        require(msg.sender == feeAddress, "setFeeAddress: FORBIDDEN");
        feeAddress = _feeAddress;
    }

    //Pancake has to add hidden dummy pools inorder to alter the emission, here we make it simple and transparent to all.
    function updateEmissionRate(uint256 _honestPerBlock) public onlyOwner {
        massUpdatePools();
        honestPerBlock = _honestPerBlock;
    }

    //Only update before start of farm
    function updateStartBlock(uint256 _startBlock) public onlyOwner {
        startBlock = _startBlock;
    }
}