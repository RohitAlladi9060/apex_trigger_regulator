/**
 * @author Rohit Alladi
 * @date May 2017
 * @group-content ../ApexDocContent/TestClasses.html
 * @description Test class for TriggerRegulator
 **/
@IsTest
private class TriggerRegulatorTest {

    /**
     * Method Tested: all methods
     * | Scenario: Called
     * | Expected Result: Coverage generated. Don't need much else for this class.
     **/
    static testMethod void allMethods_Called_CoverageGenerated() {

        TriggerRegulator.resetAfterUpdate();

        TriggerRegulator.setAlreadyHandledAfterUpdate();
        TriggerRegulator.hasAlreadyHandledAfterUpdate();

        TriggerRegulator.deactivateObjectTrigger('objectname');
        TriggerRegulator.activateObjectTrigger('objectname');
        TriggerRegulator.isObjectTriggerActive('objectname');

        Boolean result = TriggerRegulator.beforeUpdateHasRun('objectname', 1);
        System.assertNotEquals(true, result, 'Should return FALSE since beforeUpdateHasRun not previously called');
        //No asserts needed on this one.
    }

    /**
     * Method Tested: beforeUpdateHasRun
     * | Scenario: Called once with maxAllowed = 1
     * | Expected Result: Returns FALSE
     **/
    static testmethod void beforeUpdateHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsFalse() {

        Test.startTest();
        Boolean result = TriggerRegulator.beforeUpdateHasRun('objectname', 1);
        Test.stopTest();

        System.assertNotEquals(true, result, 'Expected FALSE since only one call is made.');
        System.assertEquals(1, TriggerRegulator.getBeforeUpdateRunCount('objectname'), 'Expected a run count of 1.');
    }

    /**
     * Method Tested: getBeforeUpdateRunCount
     * | Scenario: Called with no beforeUpdateHasRun calls
     * | Expected Result: Returns 0
     **/
    static testmethod void getBeforeUpdateRunCount_CalledWithNoBeforeUpdateHasRunCalls_Returns0() {

        Test.startTest();
        TriggerRegulator.getBeforeUpdateRunCount('objectname');
        Test.stopTest();

        System.assertEquals(0, TriggerRegulator.getBeforeUpdateRunCount('objectname'), 'Expected a run count of 0.');
    }

    /**
     * Method Tested: beforeUpdateHasRun
     * | Scenario: Called twice with maxAllowed = 1
     * | Expected Result: Returns TRUE
     **/
    static testmethod void beforeUpdateHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.beforeUpdateHasRun('objectname', 1);
        Boolean secondTime = TriggerRegulator.beforeUpdateHasRun('objectname', 1);
        Test.stopTest();

        System.assert(secondTime, 'Expected TRUE since call was made previously.');
        System.assertEquals(2, TriggerRegulator.getBeforeUpdateRunCount('objectname'), 'Expected a run count of 2.');
    }

    /**
     * Method Tested: afterUpdateHasRun
     * | Scenario: afterUpdate called after beforeUpdate called, each with maxAllowed = 1
     * | Expected Result: Returns FALSE
     **/
    static testmethod void afterUpdateHasRun_CalledAfterBeforeUpdateEachWithMaxAllowedEqualsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.beforeUpdateHasRun('objectname', 1);
        Boolean result = TriggerRegulator.afterUpdateHasRun('objectname', 1);
        Test.stopTest();

        System.assertNotEquals(true, result, 'Expected FALSE since beforeUpdateHasRun should not impact afterUpdateHasRun count.');
        System.assertEquals(1, TriggerRegulator.getAfterUpdateRunCount('objectname'), 'Expected a run count of 1.');
    }

    /**
     * Method Tested: beforeInsertHasRun
     * | Scenario: Called once with maxAllowed = 1
     * | Expected Result: Returns FALSE
     **/
    static testmethod void beforeInsertHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsFalse() {
        Test.startTest();
        Boolean result = TriggerRegulator.beforeInsertHasRun('objectname', 1);
        Test.stopTest();

        System.assert(!result, 'Expected FALSE since only one call is made.');
        System.assertEquals(1, TriggerRegulator.getBeforeInsertRunCount('objectname'), 'Expected a run count of 1.');
    }

    /**
     * Method Tested: beforeInsertHasRun
     * | Scenario: Called twice with maxAllowed = 1
     * | Expected Result: Returns TRUE
     **/
    static testmethod void beforeInsertHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.beforeInsertHasRun('objectname', 1);
        Boolean secondTime = TriggerRegulator.beforeInsertHasRun('objectname', 1);
        Test.stopTest();

        System.assert(secondTime, 'Expected TRUE since call was made previously.');
        System.assertEquals(2, TriggerRegulator.getBeforeInsertRunCount('objectname'), 'Expected a run count of 2.');
    }

    /**
     * Method Tested: afterInsertHasRun
     * | Scenario: Called once with maxAllowed = 1
     * | Expected Result: Returns FALSE
     **/
    static testmethod void afterInsertHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsFalse() {
        Test.startTest();
        Boolean result = TriggerRegulator.afterInsertHasRun('objectname', 1);
        Test.stopTest();

        System.assert(!result, 'Expected FALSE since only one call is made.');
        System.assertEquals(1, TriggerRegulator.getAfterInsertRunCount('objectname'), 'Expected a run count of 1.');
    }

    /**
     * Method Tested: afterInsertHasRun
     * | Scenario: Called twice with maxAllowed = 1
     * | Expected Result: Returns TRUE
     **/
    static testmethod void afterInsertHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.afterInsertHasRun('objectname', 1);
        Boolean secondTime = TriggerRegulator.afterInsertHasRun('objectname', 1);
        Test.stopTest();

        System.assert(secondTime, 'Expected TRUE since call was made previously.');
        System.assertEquals(2, TriggerRegulator.getAfterInsertRunCount('objectname'), 'Expected a run count of 2.');
    }

    /**
     * Method Tested: beforeDeleteHasRun
     * | Scenario: Called twice with maxAllowed = 1
     * | Expected Result: Returns TRUE
     **/
    static testmethod void beforeDeleteHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.beforeDeleteHasRun('objectname', 1);
        Boolean secondTime = TriggerRegulator.beforeDeleteHasRun('objectname', 1);
        Test.stopTest();

        System.assert(secondTime, 'Expected TRUE since call was made previously.');
        System.assertEquals(2, TriggerRegulator.getBeforeDeleteRunCount('objectname'), 'Expected a run count of 2.');
    }

    /**
     * Method Tested: afterDeleteHasRun
     * | Scenario: Called twice with maxAllowed = 1
     * | Expected Result: Returns TRUE
     **/
    static testmethod void afterDeleteHasRun_CalledOnceWhenMaxAllowedTimesIsOne_ReturnsTrue() {

        Test.startTest();
        TriggerRegulator.afterDeleteHasRun('objectname', 1);
        Boolean secondTime = TriggerRegulator.afterDeleteHasRun('objectname', 1);
        Test.stopTest();

        System.assert(secondTime, 'Expected TRUE since call was made previously.');
        System.assertEquals(2, TriggerRegulator.getAfterDeleteRunCount('objectname'), 'Expected a run count of 2.');
    }
}