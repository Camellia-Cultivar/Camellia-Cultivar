package com.camellia.models.characteristics;

public class CharacteristicDTO {
    private Long id;
    private String name;
    private UPOVCategoryDTO upovCategory;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public UPOVCategoryDTO getUpovCategory() {
        return upovCategory;
    }

    public void setUpovCategory(UPOVCategoryDTO upovCategory) {
        this.upovCategory = upovCategory;
    }
}
