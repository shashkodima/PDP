/**
 * Created by user on 4/6/2022.
 */

public with sharing class Belarusian extends Human{

    public Belarusian(String name) {
        super(name);
    }

    public override Boolean hasEuropeWorkPermission() {
        return false;
    }
}