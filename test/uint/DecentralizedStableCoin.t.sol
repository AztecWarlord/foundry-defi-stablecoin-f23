// SPDX-license-identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;
    DeployDSC deployer;

    function setUp() public {
        dsc = new DecentralizedStableCoin();
    }

    ///////////////////
    // Burn Function //
    ///////////////////

    function testBurn() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1000);
        dsc.burn(1000);
        vm.stopPrank();
        assertEq(dsc.balanceOf(address(this)), 0);
    }

    function testRevertsIfBurnAmountIsZero() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1000);
        vm.expectRevert();
        dsc.burn(0);
        vm.stopPrank();
    }

    function testRevertsIfBurnAmountExceedsBalance() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1000);
        vm.expectRevert();
        dsc.burn(1001);
        vm.stopPrank();
    }

    ////////////////////
    // Mint Function  //
    ////////////////////

    function testMint() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 1000);
        vm.stopPrank();
    }

    function testRevertsMintAmoutMustBeMoreThanZero() public {
        vm.startPrank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(this), 0);
        vm.stopPrank();
    }

    function testRevertsIfNotOwner() public {
        vm.startPrank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(0), 1000);
        vm.stopPrank();
    }
}
