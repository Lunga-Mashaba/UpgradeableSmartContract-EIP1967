// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Proxy.sol";
import "../src/LogicV1.sol";
import "../src/LogicV2.sol";

contract ProxyTest is Test {
    Proxy proxy;
    LogicV1 logicV1;
    LogicV2 logicV2;

    function setUp() public {
        logicV1 = new LogicV1();
        proxy = new Proxy(address(logicV1));
    }

    function testIncrementThroughProxy() public {
        LogicV1 proxyAsLogic = LogicV1(address(proxy));
        proxyAsLogic.increment();
        assertEq(proxyAsLogic.getCounter(), 1);
    }

    function testUpgradeImplementation() public {
        LogicV1 proxyAsLogic = LogicV1(address(proxy));
        proxyAsLogic.increment();

        logicV2 = new LogicV2();
        proxy.setImplementation(address(logicV2));

        LogicV2 proxyAsLogicV2 = LogicV2(address(proxy));
        proxyAsLogicV2.increment(); // adds 2
        assertEq(proxyAsLogicV2.getCounter(), 3); // 1 + 2 = 3

        proxyAsLogicV2.reset();
        assertEq(proxyAsLogicV2.getCounter(), 0);
    }
}
