/**
 * Created by user on 4/6/2022.
 */

public with sharing class ImmigrationAgency {

    public static boolean checkEuropeWorkPermission(Human human) {
            return human.hasEuropeWorkPermission();
    }
}