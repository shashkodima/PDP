public with sharing class DynamicBindingController {
    private final String contractId;
    private final Contract contract;
    private ApexPages.StandardController controllerStandard;

    public DynamicBindingController (ApexPages.StandardController controller) {
        this.controllerStandard = controller;
        controllerStandard.addFields(getFieldLabels);
        this.contractId = (String)controllerStandard.getId();
        this.contract = (Contract)controllerStandard.getRecord();
    }

    public List<String> getFieldLabels {
        get {
            List<String> fieldNames = new List<String>();

            for (Schema.FieldSetMember field : fieldsFromFieldSet) {
                fieldNames.add(field.fieldPath);
            }

            return fieldNames;
        }
    }

    public List<Schema.FieldSetMember> fieldsFromFieldSet {
        get {
            return SObjectType.Contract.FieldSets.SetPDP.getFields();
        }
    }

    public Component.Apex.pageBlockSection getSection() {

        Component.Apex.pageBlockSection section = new Component.Apex.pageBlockSection();
        section.title = 'Dynamic Component';

        for (Schema.FieldSetMember field : fieldsFromFieldSet) {
            Component.Apex.PageBlockSectionItem sectionItem = new Component.Apex.PageBlockSectionItem();

            Component.Apex.outputLabel fieldLabel = new Component.Apex.outputLabel();
            String labelText = field.label;
            fieldLabel.value = labelText;

            Component.Apex.outputText fieldValue = new Component.Apex.outputText();
            String fieldName = field.fieldPath;
            fieldValue.value = contract.get(fieldName);

            section.childComponents.add(sectionItem);
            sectionItem.childComponents.add(fieldLabel);
            sectionItem.childComponents.add(fieldValue);
        }

        return section;
    }
}