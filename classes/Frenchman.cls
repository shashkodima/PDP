/**
 * Created by user on 4/6/2022.
 */

public with sharing class Frenchman extends Human{

    public Frenchman(String name) {
        super(name);
    }

    public override boolean hasEuropeWorkPermission() {
        return true;
    }
}