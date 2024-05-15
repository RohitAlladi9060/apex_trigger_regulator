/**
 * @author Xavier Fromageot
 * @date May 2017
 * @group Marketingforce Classes
 * @group-content ../ApexDocContent/Classes.html
 * @description Used to prevent trigger handler methods from firing more than once
 **/
global class TriggerRegulator {

    public final static String CAMPAIGN = 'Campaign';
    public final static String TASK = 'Task';

    private static Boolean afterInsertDone = false;
    private static Boolean afterUpdateOfferConstruct = false;
    private static Boolean afterUpdateDone = false;
    private static final String BEFORE_INSERT_SFX = ' Before Insert';
    private static final String AFTER_INSERT_SFX = ' After Insert';
    private static final String BEFORE_UPDATE_SFX = ' Before Update';
    private static final String AFTER_UPDATE_SFX = ' After Update';

    //TODO: Setup delete regulation in the future (Kyle Walsh)
    private static final String BEFORE_DELETE_SFX = ' Before Delete';
    private static final String AFTER_DELETE_SFX = ' After Delete';
    //private static final String AFTER_UNDELETE_SFX = ' After UnDelete';

    private static Set<String> inactiveTriggers = new Set<String>();
    private static Map<String, Integer> executedTriggers = new Map<String, Integer>();


    //After Insert
    //Deprecated.
    public static Boolean hasAlreadyHandledAfterInsert() {
        return afterInsertDone;
    }

    //Deprecated.
    public static void setAlreadyHandledAfterInsert() {
        afterInsertDone = true;
    }

    //After Update
    public static Boolean hasAlreadyHandledAfterUpdate() {
        return afterUpdateDone;
    }

    public static void setAlreadyHandledAfterUpdate() {
        afterUpdateDone = true;
    }

    public static void resetAfterUpdate() {
        afterUpdateDone = false;
    }

    public static void deactivateObjectTrigger(String objectName) {
        inactiveTriggers.add(objectName);
    }

    public static void activateObjectTrigger(String objectName) {
        inactiveTriggers.remove(objectName);
    }

    public static Boolean isObjectTriggerActive(String objectName) {
        return !inactiveTriggers.contains(objectName);
    }

    private static void incrementCount(String key) {
        if (executedTriggers.get(key) == null) {
            executedTriggers.put(key, 1);
        } else {
            Integer count = executedTriggers.get(key);
            count++;
            executedTriggers.put(key, count);
        }
    }

    private static Boolean doCheck(String key, Integer maxAllowedTimes) {
        Boolean alreadyRun = true;

        incrementCount(key);

        if (executedTriggers.get(key) <= maxAllowedTimes) {
            alreadyRun = false;
        }

        return alreadyRun;
    }

    public static Integer getBeforeInsertRunCount(String objectName) {
        String key = objectName + BEFORE_INSERT_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Integer getAfterInsertRunCount(String objectName) {
        String key = objectName + AFTER_INSERT_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Integer getBeforeUpdateRunCount(String objectName) {
        String key = objectName + BEFORE_UPDATE_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Integer getAfterUpdateRunCount(String objectName) {
        String key = objectName + AFTER_UPDATE_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Integer getBeforeDeleteRunCount(String objectName) {
        String key = objectName + BEFORE_DELETE_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Integer getAfterDeleteRunCount(String objectName) {
        String key = objectName + AFTER_DELETE_SFX;
        return executedTriggers.get(key) == null ? 0 : executedTriggers.get(key);
    }

    public static Boolean beforeInsertHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + BEFORE_INSERT_SFX;
        return doCheck(key, maxAllowedTimes);
    }

    public static Boolean afterInsertHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + AFTER_INSERT_SFX;
        return doCheck(key, maxAllowedTimes);
    }

    public static Boolean beforeUpdateHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + BEFORE_UPDATE_SFX;
        return doCheck(key, maxAllowedTimes);
    }

    public static Boolean afterUpdateHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + AFTER_UPDATE_SFX;
        return doCheck(key, maxAllowedTimes);
    }

    public static Boolean beforeDeleteHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + BEFORE_DELETE_SFX;
        return doCheck(key, maxAllowedTimes);
    }

    public static Boolean afterDeleteHasRun(String objectName, Integer maxAllowedTimes) {
        String key = objectName + AFTER_DELETE_SFX;
        return doCheck(key, maxAllowedTimes);
    }
}