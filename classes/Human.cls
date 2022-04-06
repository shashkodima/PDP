/**
 * Created by user on 4/6/2022.
 */

abstract public with sharing class Human {
    String name;

    public Human(String name) {
        this.name = name;
    }

    abstract public boolean hasEuropeWorkPermission();
}