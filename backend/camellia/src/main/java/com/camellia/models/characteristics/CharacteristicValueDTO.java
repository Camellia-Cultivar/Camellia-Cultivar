package com.camellia.models.characteristics;

public class CharacteristicValueDTO {
    private Long id;
    private Short value;
    private String descriptor;
    private CharacteristicDTO characteristic;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Short getValue() {
        return value;
    }

    public void setValue(Short value) {
        this.value = value;
    }

    public String getDescriptor() {
        return descriptor;
    }

    public void setDescriptor(String descriptor) {
        this.descriptor = descriptor;
    }

    public CharacteristicDTO getCharacteristic() {
        return characteristic;
    }

    public void setCharacteristic(CharacteristicDTO characteristic) {
        this.characteristic = characteristic;
    }
}
