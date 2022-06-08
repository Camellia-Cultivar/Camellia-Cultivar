package com.camellia.models.specimens;

public enum SpecimenType {
    REFERENCE("R"),
    TO_IDENTIFY("I"),
    FOR_APPROVAL("A");

    private final String code;

    private SpecimenType(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
